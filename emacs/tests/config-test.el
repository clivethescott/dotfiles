;;; tests/config-test.el -*- lexical-binding: t; -*-
;; Run: emacs -Q --batch -l tests/config-test.el -f ert-run-tests-batch-and-exit
;; Exercises local behavior without downloading or starting language servers.
(require 'ert)
(require 'cl-lib)
(require 'subr-x)
(defconst nvim-parity-test-root
  (file-name-directory (directory-file-name (file-name-directory load-file-name))))
(defconst nvim-parity-test-emacs
  (expand-file-name "emacs/" (or (getenv "XDG_CONFIG_HOME") "~/.config/")))
(add-to-list 'load-path (expand-file-name "lisp/" nvim-parity-test-emacs))
(require 'doom-lib)
(require 'doom-modules)
(defvar doom-module-load-path)
(defvar doom-user-dir)
(defun doom-log (&rest _))
;; Package declarations are evaluated by Doom after sync, not by these unit tests.
(defmacro use-package! (&rest _) nil)
(defvar nvim-parity-test-packages nil)
(defmacro package! (name &rest _) `(push ',name nvim-parity-test-packages))
;; Load the installed formatter so the consolidated deferred block is exercised.
(let ((build (expand-file-name ".local/straight/build-31.1/" nvim-parity-test-emacs)))
  (dolist (dir (directory-files build t "^[^.]"))
    (when (file-directory-p dir) (add-to-list 'load-path dir t))))
(require 'apheleia)
(load (expand-file-name "config.el" nvim-parity-test-root) nil t)

(defmacro nvim-parity-test-directory (&rest body)
  (declare (indent 0))
  `(let ((default-directory (file-name-as-directory (make-temp-file "doom-parity-test-" t))))
     (unwind-protect (progn ,@body)
       (delete-directory default-directory t))))

(defun nvim-parity-test-binary (relative contents)
  (let ((file (expand-file-name relative)))
    (make-directory (file-name-directory file) t)
    (with-temp-file file (insert "#!/bin/sh\n" contents "\n"))
    (set-file-modes file #o755)
    file))

(ert-deftest nvim-parity-editorconfig-applies-to-first-file ()
  (require 'use-package)
  (let* ((build (expand-file-name ".local/straight/build-31.1/" nvim-parity-test-emacs))
         (load-path (cons (expand-file-name "editorconfig/" build) load-path)))
    (skip-unless (locate-library "editorconfig"))
    ;; Evaluate the actual consolidated startup config with real use-package.
    (cl-letf (((symbol-function 'use-package!) (symbol-function 'use-package)))
      (load (expand-file-name "config.el" nvim-parity-test-root) nil t))
    (should editorconfig-mode)
    (nvim-parity-test-directory
      (with-temp-file ".editorconfig"
        (insert "root = true\n[*.go]\nindent_style = tab\nindent_size = tab\ntab_width = 4\n"))
      (with-temp-file "main.go" (insert "package main\n"))
      (let* ((auto-mode-alist '(("\\.go\\'" . fundamental-mode)))
             (buffer (find-file-noselect (expand-file-name "main.go"))))
        (unwind-protect
            (with-current-buffer buffer
              (should editorconfig-properties-hash)
              (should (= tab-width 4))
              (should indent-tabs-mode))
          (kill-buffer buffer))))))

(ert-deftest nvim-parity-native-tsc-skips-old-project-version ()
  (nvim-parity-test-directory
    (let* ((old (nvim-parity-test-binary "node_modules/.bin/tsc" "echo 'Version 5.9.0'"))
           (native (nvim-parity-test-binary "mason/tsc" "echo 'Version 7.0.0'"))
           (nvim-parity-mason-bin (expand-file-name "mason/"))
           (exec-path nil))
      (should-not (nvim-parity-native-typescript-p old))
      (should (equal (nvim-parity-command '("tsc" "--lsp" "--stdio"))
                     (list native "--lsp" "--stdio")))
      (delete-file native)
      (should-error (nvim-parity-command '("tsc" "--lsp")) :type 'user-error))))

(ert-deftest nvim-parity-project-tools-win-without-environment-leaks ()
  (nvim-parity-test-directory
    (let* ((project (nvim-parity-test-binary ".venv/bin/ruff" "exit 0"))
           (nvim-parity-mason-bin (expand-file-name "mason/"))
           (original-path (getenv "PATH"))
           (original-exec-path exec-path))
      (nvim-parity-test-binary "mason/ruff" "exit 0")
      (with-temp-buffer
        (should (equal (nvim-parity-executable "ruff") project))
        (nvim-parity-project-path)
        (should (equal (car exec-path) (expand-file-name ".venv/bin/")))
        (should (string-prefix-p (expand-file-name ".venv/bin/") (getenv "PATH"))))
      (should (equal (getenv "PATH") original-path))
      (should (equal exec-path original-exec-path)))))

(ert-deftest nvim-parity-helm-excludes-values-and-unrelated-templates ()
  (nvim-parity-test-directory
    (make-directory "chart/templates" t)
    (make-directory "other/templates" t)
    (with-temp-file "chart/Chart.yaml" (insert "name: example\n"))
    (with-temp-buffer
      (setq buffer-file-name (expand-file-name "chart/templates/deployment.yaml"))
      (should (nvim-parity-helm-template-p))
      (setq buffer-file-name (expand-file-name "chart/values.yaml"))
      (should-not (nvim-parity-helm-template-p))
      (setq buffer-file-name (expand-file-name "other/templates/deployment.yaml"))
      (should-not (nvim-parity-helm-template-p)))))

(ert-deftest nvim-parity-rust-edition-inherits-workspace ()
  (nvim-parity-test-directory
    (make-directory "member/src" t)
    (with-temp-file "Cargo.toml" (insert "[workspace.package]\nedition = \"2024\"\n"))
    (with-temp-file "member/Cargo.toml" (insert "[package]\nedition.workspace = true\n"))
    (let ((default-directory (expand-file-name "member/src/")))
      (should (equal (nvim-parity-rust-edition) "2024")))
    (with-temp-file "member/Cargo.toml" (insert "[package]\nedition = \"2018\"\n"))
    (let ((default-directory (expand-file-name "member/src/")))
      (should (equal (nvim-parity-rust-edition) "2018")))))

(ert-deftest nvim-parity-save-formatting-is-opt-in-by-language ()
  (with-temp-buffer
    (setq major-mode 'python-ts-mode)
    (should-not (nvim-parity-inhibit-save-format))
    (should (equal apheleia-formatter '(nvim-ruff nvim-ruff-imports))))
  (with-temp-buffer
    (setq major-mode 'yaml-mode)
    (should (nvim-parity-inhibit-save-format)))
  (with-temp-buffer
    (setq major-mode 'web-mode buffer-file-name "/tmp/example.html")
    (should (nvim-parity-inhibit-save-format))
    (setq buffer-file-name "/tmp/example.tsx")
    (should-not (nvim-parity-inhibit-save-format))))

(ert-deftest nvim-parity-module-selections-are-in-main-init ()
  (let ((doom-module-load-path
         (list (expand-file-name "sources/doom+/modules/" nvim-parity-test-emacs)))
        (doom-user-dir nvim-parity-test-root)
        (doom-modules (make-hash-table :test 'equal)))
    (cl-letf (((symbol-function 'doom-config) (lambda (&rest _) nil)))
      (load (expand-file-name "init.el" doom-user-dir) nil t))
    (dolist (module '((:tools . lsp) (:tools . editorconfig) (:tools . tree-sitter)
                      (:editor . format) (:editor . snippets) (:lang . markdown)))
      (should (gethash module doom-modules)))
    (should (member '+uv (doom-module-flags (gethash '(:lang . python) doom-modules))))))

(ert-deftest nvim-parity-personal-snippets-expand-and-inherit ()
  (add-to-list 'load-path (expand-file-name ".local/straight/repos/yasnippet/" nvim-parity-test-emacs))
  (require 'yasnippet)
  (yas-load-directory (expand-file-name "snippets/" nvim-parity-test-root))
  (dolist (case '((fundamental-mode "dateUTC") (fundamental-mode "epoch")
                  (go-mode "iff") (go-ts-mode "iff") (rustic-mode "tys")
                  (rust-ts-mode "tafn") (rust-mode "printone")
                  (scala-ts-mode "fory") (lua-ts-mode "foo")))
    (with-temp-buffer
      (setq major-mode (car case))
      (yas-minor-mode 1)
      (insert (cadr case))
      (should (yas-expand))
      (should-not (string-match-p "\\${[0-9]" (buffer-string)))
      (when (equal (cadr case) "dateUTC")
        (should (string-match-p "[0-9]T[0-9].*Z" (buffer-string)))))))

(defvar rust-mode-treesitter-derive)
(ert-deftest nvim-parity-rust-snippets-with-real-tree-sitter-inheritance ()
  (let ((load-path (cons (expand-file-name ".local/straight/repos/rust-mode/" nvim-parity-test-emacs)
                         load-path))
        (rust-mode-treesitter-derive t))
    (skip-unless (locate-library "rust-mode"))
    (require 'rust-mode)
    (require 'rust-mode-treesitter)
    (let ((parents (derived-mode-all-parents 'rust-mode)))
      (should (equal parents '(rust-mode rust-ts-mode prog-mode))))
    (require 'yasnippet)
    (let ((yas-snippet-dirs (list (expand-file-name "snippets/" nvim-parity-test-root))))
      (yas-reload-all t))
    (dolist (mode '(rust-mode rust-ts-mode rustic-mode))
      (with-temp-buffer
        (setq major-mode mode)
        (yas-minor-mode 1)
        (insert "tys")
        (should (yas-expand))
        (should (string-match-p "struct Name" (buffer-string)))))))

(ert-deftest nvim-parity-packages-and-preferences-are-in-main-files ()
  (let ((nvim-parity-test-packages nil))
    (load (expand-file-name "packages.el" nvim-parity-test-root) nil t)
    (should (equal (sort nvim-parity-test-packages) '(nushell-mode typst-ts-mode))))
  (should (eq doom-theme 'doom-tokyo-night))
  (should (eq display-line-numbers-type 'relative))
  (should (eq mac-right-option-modifier 'meta))
  (should (eq (alist-get 'fullscreen default-frame-alist) 'fullboth)))

(ert-deftest nvim-parity-ruff-chain-formats-and-organizes-imports ()
  (let ((ruff (nvim-parity-executable "ruff")))
    (skip-unless ruff)
    (with-temp-buffer
      (insert "import sys\nimport os\n\nx=1\n")
      (should (zerop (call-process-region (point-min) (point-max) ruff t t nil
                                         "format" "--stdin-filename" "/tmp/example.py" "-")))
      (should (zerop (call-process-region (point-min) (point-max) ruff t t nil
                                         "check" "--quiet" "--select" "I" "--fix" "--exit-zero"
                                         "--stdin-filename" "/tmp/example.py" "-")))
      (should (equal (buffer-string) "import os\nimport sys\n\nx = 1\n")))))

(ert-deftest nvim-parity-server-settings-preserve-schema-keys-and-booleans ()
  (let (registered)
    (cl-letf (((symbol-function 'lsp-register-custom-settings)
               (lambda (settings) (setq registered (append settings registered)))))
      (nvim-parity-register-settings nvim-parity-server-settings))
    (should (eq (cadr (assoc "gopls.gofumpt" registered)) t))
    (should (eq (cadr (assoc "gopls.usePlaceholders" registered)) :json-false))
    (let ((schemas (cadr (assoc "yaml.schemas" registered))))
      (should (hash-table-p schemas))
      (should (gethash "https://www.schemastore.org/github-workflow.json" schemas)))
    (should (hash-table-p (cadr (assoc "taplo.schema.associations" registered))))))

(ert-deftest nvim-parity-lsp-loads-after-deferred-config ()
  ;; Use the installed package, not a client-structure stub. Loading it after
  ;; config.el reproduces the original first-Go-buffer failure.
  (let* ((build (expand-file-name ".local/straight/build-31.1/" nvim-parity-test-emacs))
         (load-path (append (and (file-directory-p build)
                                 (cl-remove-if-not #'file-directory-p
                                                   (directory-files build t "^[^.]")))
                            load-path)))
    (skip-unless (locate-library "lsp-mode"))
    (require 'lsp-mode)
    (should (gethash 'nvim-parity-ty lsp-clients))
    (should (gethash 'nvim-parity-docker lsp-clients))
    ;; The merged config is read before lsp-mode, so initialization must not
    ;; depend on expanding a package macro during that earlier read.
    (let (sent)
      (cl-letf (((symbol-function 'lsp--set-configuration)
                 (lambda (_settings)
                   (should (eq lsp--cur-workspace 'test-workspace))
                   (setq sent t))))
        (funcall (lsp--client-initialized-fn (gethash 'nvim-parity-ty lsp-clients))
                 'test-workspace))
      (should sent))
    ;; Exercise the same workspace/configuration response gopls requests after
    ;; initialization. Built-in object settings must not collide with leaves.
    (let* ((settings (lsp--section-workspace-configuration "gopls"))
           (lenses (gethash "codelenses" settings)))
      (should (hash-table-p lenses))
      (should (eq (gethash "gc_details" lenses) :json-false))
      (should (eq (gethash "run_govulncheck" lenses) t))
      (should (hash-table-p (gethash "analyses" settings))))
    ;; Reloading must remove old flattened children as well.
    (puthash "gopls.codelenses.gc_details" '(t) lsp-client-settings)
    (nvim-parity-register-settings nvim-parity-server-settings)
    (should-not (gethash "gopls.codelenses.gc_details" lsp-client-settings))
    (should (eq (gethash "gc_details"
                         (gethash "codelenses" (lsp--section-workspace-configuration "gopls")))
                :json-false))
    (let ((helm (gethash 'nvim-parity-helm lsp-clients))
          (tsc (gethash 'nvim-parity-tsc lsp-clients)))
      (should (functionp (lsp--client-activation-fn helm)))
      (with-temp-buffer
        (setq buffer-file-name "/tmp/example.html")
        (should-not (funcall (lsp--client-activation-fn tsc) buffer-file-name major-mode))
        (setq buffer-file-name "/tmp/example.tsx")
        (should (funcall (lsp--client-activation-fn tsc) buffer-file-name major-mode))))))
