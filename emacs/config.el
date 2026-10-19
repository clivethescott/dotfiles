;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Personal runtime configuration. Modules and packages live in init.el
;; and packages.el, as required by Doom.

;; Map macOS Command to Control
(setq mac-command-modifier 'control)

;; Keep Option as Meta (Alt)
(setq mac-option-modifier 'meta)

;; increase font size
(setq doom-font (font-spec :family "Hack Nerd Font Mono" :size 16))

;; Non-POSIX compliant shells (particularly Fish and Nushell) can cause
;; unpredictable issues with any Emacs utilities that spawn child processes from
;; shell commands (like diff-hl TRAMP, and terminal emulators). configure Emacs to use a POSIX shell internally
(setq shell-file-name (executable-find "zsh"))

;; Emacs' terminal emulators can be safely configured to use your original $SHELL:
(setq-default vterm-shell "/opt/zerobrew/bin/fish")
(setq-default explicit-shell-file-name "/opt/zerobrew/bin/fish")

(setq org-directory "~/org/")

(require 'cl-lib)
(require 'subr-x)

(defvar nvim-parity-mason-bin
  (expand-file-name "nvim/mason/bin/"
                    (or (getenv "XDG_DATA_HOME") "~/.local/share/")))

;; PATH must match exec-path: Mason's launchers invoke node, Java, etc. themselves.
;; Doom imports the login environment for GUI Emacs; retain that environment.
(when (file-directory-p nvim-parity-mason-bin)
  (add-to-list 'exec-path nvim-parity-mason-bin)
  (setenv "PATH" (string-join (delete-dups
                             (cons nvim-parity-mason-bin
                                   (split-string (or (getenv "PATH") "") path-separator t)))
                            path-separator)))

(defun nvim-parity-executable (name &optional predicate)
  "Find NAME in ancestor project bins, Mason, then PATH.
PREDICATE, when supplied, rejects incompatible binaries (such as TypeScript 5)."
  (let ((directory (expand-file-name default-directory)) candidates)
    (unless (file-remote-p directory)
      (while directory
        (dolist (bin '("node_modules/.bin/" ".venv/bin/"))
          (setq candidates (append candidates (list (expand-file-name (concat bin name) directory)))))
        (let ((parent (file-name-directory (directory-file-name directory))))
          (setq directory (unless (equal parent directory) parent)))))
    (setq candidates
          (append candidates (list (expand-file-name name nvim-parity-mason-bin))
                  (mapcar (lambda (dir) (expand-file-name name dir))
                          (delq nil (copy-sequence exec-path)))))
    (cl-find-if (lambda (file)
                  (and (file-executable-p file) (not (file-directory-p file))
                       (or (null predicate) (funcall predicate file))))
                (delete-dups candidates))))

(defun nvim-parity-native-typescript-p (binary)
  "Whether BINARY supports the native TypeScript 7 LSP."
  (with-temp-buffer
    (and (eq 0 (call-process binary nil t nil "--version"))
         (goto-char (point-min))
         (re-search-forward "Version \\([0-9]+\\)" nil t)
         (>= (string-to-number (match-string 1)) 7))))

(defun nvim-parity-command (command)
  "Resolve COMMAND without letting a project's older tsc shadow native tsc."
  (let* ((name (car command))
         (binary (nvim-parity-executable
                  name (when (equal name "tsc") #'nvim-parity-native-typescript-p))))
    (unless binary
      (user-error "Missing %s%s; install it with Mason or the project toolchain"
                  name (if (equal name "tsc") " (native TypeScript >= 7)" "")))
    (cons binary (cdr command))))

(defun nvim-parity-project-path ()
  "Put existing project tool directories ahead of Mason for this buffer."
  (unless (file-remote-p default-directory)
    (let ((directory (expand-file-name default-directory)) bins)
      (while directory
        (dolist (bin '("node_modules/.bin/" ".venv/bin/"))
          (let ((path (expand-file-name bin directory)))
            (when (file-directory-p path)
              (setq bins (append bins (list path))))))
        (let ((parent (file-name-directory (directory-file-name directory))))
          (setq directory (unless (equal parent directory) parent))))
      (when bins
        (setq-local exec-path (delete-dups (append bins exec-path)))
        (setq-local process-environment (copy-sequence process-environment))
        (setenv "PATH" (string-join
                       (delete-dups (append bins (split-string (or (getenv "PATH") "") path-separator t)))
                       path-separator))))))
(add-hook 'hack-local-variables-hook #'nvim-parity-project-path -90)

(setq display-line-numbers-type 'relative)
(setq doom-theme 'doom-tokyo-night)

;; The first-buffer hook is too late to wrap the first find-file operation.
;; Activate EditorConfig before any project file is visited.
(use-package! editorconfig
  :demand t
  :config (editorconfig-mode 1))

;; Doom reserves right Option for special characters; use it as Meta too.
(setq mac-right-option-modifier 'meta
      ns-right-option-modifier 'meta)

;; Start graphical frames in fullscreen.
(add-to-list 'default-frame-alist '(fullscreen . fullboth))

;; Highlight the first completion candidate as soon as the popup opens.
(after! corfu
  (setq corfu-preselect 'first))

;; Doom defaults to 400ms on macOS; keep a shorter pause before completion.
(after! corfu-auto
  (setq corfu-auto-delay 0.15))

;; Personal snippets use Doom's standard $DOOMDIR/snippets directory.

;; Emacs 31 adds rust-mode as a compatibility parent of rust-ts-mode, while
;; rust-mode's tree-sitter backend derives in the opposite direction.
(after! rust-mode-treesitter
  (when (eq (get 'rust-mode 'derived-mode-parent) 'rust-ts-mode)
    (derived-mode-add-parents
     'rust-ts-mode (remq 'rust-mode (copy-sequence (get 'rust-ts-mode 'derived-mode-extra-parents))))))

;; Extra major modes. Smithy deliberately needs no external mode package.
(define-derived-mode nvim-parity-smithy-mode prog-mode "Smithy"
  "Edit Smithy models and use the Smithy language server."
  (modify-syntax-entry ?/ ". 124b" nvim-parity-smithy-mode-syntax-table)
  (modify-syntax-entry ?\n "> b" nvim-parity-smithy-mode-syntax-table)
  (setq-local comment-start "// " comment-end "")
  (setq-local font-lock-defaults
              '((("\\_<\\(namespace\\|use\\|service\\|operation\\|resource\\|structure\\|union\\|list\\|map\\|enum\\|intEnum\\|string\\|integer\\|boolean\\|apply\\|for\\|with\\)\\_>" . font-lock-keyword-face)
                 ("@[[:alnum:]_.#]+" . font-lock-preprocessor-face)))))
(add-to-list 'auto-mode-alist '("\\.smithy\\'" . nvim-parity-smithy-mode))
(use-package! nushell-mode :mode "\\.nu\\'")
(use-package! typst-ts-mode
  :mode "\\.typ\\'"
  :init
  (after! treesit
    (add-to-list 'treesit-language-source-alist
                 '(typst "https://github.com/uben0/tree-sitter-typst"))))

(defun nvim-parity-helm-template-p ()
  "Recognize chart templates without treating arbitrary YAML as Helm."
  (when-let* ((file buffer-file-name)
              (root (locate-dominating-file file "Chart.yaml")))
    (string-prefix-p "templates/" (file-relative-name file root))))

(defun nvim-parity-yaml-setup ()
  (when (nvim-parity-helm-template-p)
    (setq-local lsp-enabled-clients '(nvim-parity-helm))))
(add-hook 'yaml-mode-hook #'nvim-parity-yaml-setup)
(add-hook 'yaml-ts-mode-hook #'nvim-parity-yaml-setup)

(defun nvim-parity-helm-template-mode ()
  "Use YAML/LSP for Helm helper templates, plain text outside a chart."
  (if (nvim-parity-helm-template-p) (yaml-mode) (fundamental-mode)))
(add-to-list 'auto-mode-alist '("/templates/.*\\.tpl\\'" . nvim-parity-helm-template-mode))

(defun nvim-parity-python-setup ()
  (setq-local lsp-enabled-clients '(nvim-parity-ty nvim-parity-ruff)))
(dolist (hook '(python-mode-hook python-ts-mode-hook))
  (add-hook hook #'nvim-parity-python-setup))

(defun nvim-parity-typescript-setup ()
  (unless (or (derived-mode-p 'json-mode 'json-ts-mode)
              (and buffer-file-name (string-match-p "\\.jsonc?\\'" buffer-file-name)))
    (setq-local lsp-enabled-clients '(nvim-parity-tsc nvim-parity-biome))))
(dolist (hook '(js-mode-hook js-ts-mode-hook js2-mode-hook rjsx-mode-hook
                typescript-mode-hook typescript-ts-mode-hook tsx-ts-mode-hook))
  (add-hook hook #'nvim-parity-typescript-setup))
(after! web-mode
  (add-hook 'web-mode-hook
            (lambda ()
              (when (and buffer-file-name (string-match-p "\\.[jt]sx\\'" buffer-file-name))
                (nvim-parity-typescript-setup)))))

;; Prefer explicit local connections for newer/specialist servers. Keep Doom's
;; existing clients for mainstream languages (Go, Rust, Lua, JSON, etc.).
(defun nvim-parity-javascript-buffer-p (&rest _)
  "Restrict the TypeScript and Biome clients to JavaScript-family files."
  (and buffer-file-name (string-match-p "\\.[cm]?[jt]sx?\\'" buffer-file-name)))

;; Convert the embedded settings alist to JSON-compatible objects.
(defun nvim-parity-settings-object (value)
  (cond ((consp value)
         (let ((table (make-hash-table :test 'equal)))
           (dolist (entry value table)
             (puthash (car entry) (nvim-parity-settings-object (cdr entry)) table))))
        ((vectorp value) (vconcat (mapcar #'nvim-parity-settings-object value)))
        (t value)))

;; Static language-server settings, kept here for version tracking.
(defvar nvim-parity-server-settings
  (nvim-parity-settings-object
   '(("metals" . (("fallbackScalaVersion" . "2.13.16")
       ("excludedPackages" . ["akka.actor.typed.javadsl" "com.github.swagger.akka.javadsl"])
       ("showImplicitArguments" . t)
       ("showImplicitConversionsAndClasses" . t)
       ("showInferredType" . t)
       ("superMethodLensesEnabled" . :json-false)
       ("enableBestEffort" . t)
       ("enableSemanticHighlighting" . t)
       ("startMcpServer" . :json-false)
       ("defaultBspToBuildTool" . t)
       ("testUserInterface" . "Test Explorer")
       ("inlayHints" . (("implicitArguments" . (("enable" . t)))
         ("implicitConversions" . (("enable" . :json-false)))
         ("inferredTypes" . (("enable" . t)))
         ("typeParameters" . (("enable" . :json-false)))
         ("byNameParameters" . (("enable" . :json-false)))
         ("hintsInPatternMatch" . (("enable" . t)))))))
     ("json" . (("schemas" . [(("name" . "openapi.json")
          ("fileMatch" . ["openapi.json" "openapi.yml" "openapi.yaml" "*.openapi.json" "*.openapi.yml" "*.openapi.yaml"])
          ("description" . "An OpenAPI documentation file")
          ("url" . "https://www.schemastore.org/openapi-3.X.json")) (("name" . "gRPC API Gateway & OpenAPI Config")
          ("fileMatch" . ["grpc_api_gateway.yaml" "grpc_api_gateway.yml" "grpc_api_gateway.json" "*_gateway.yml" "*_gateway.yaml" "*_gateway.json" "*_openapi.yml" "*_openapi.yaml" "*_openapi.json"])
          ("description" . "Config file for gRPC API Gateway & OpenAPI v3.1 generation")
          ("url" . "https://www.schemastore.org/grpc-api-gateway.json")) (("name" . "Claude Code Settings")
          ("fileMatch" . ["**/.claude/settings.json"])
          ("description" . "Configuration file for Claude Code")
          ("url" . "https://www.schemastore.org/claude-code-settings.json")) (("name" . "AWS CloudFormation")
          ("fileMatch" . ["*.cf.json" "*.cf.yml" "*.cf.yaml" "cloudformation.json" "cloudformation.yml" "cloudformation.yaml"])
          ("description" . "AWS CloudFormation provides a common language for you to describe and provision all the infrastructure resources in your cloud environment")
          ("url" . "https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json")) (("name" . "AWS CloudFormation Serverless Application Model (SAM)")
          ("fileMatch" . ["template.yaml" "serverless.template" "*.sam.json" "*.sam.yml" "*.sam.yaml" "sam.json" "sam.yml" "sam.yaml"])
          ("description" . "The AWS Serverless Application Model (AWS SAM, previously known as Project Flourish) extends AWS CloudFormation to provide a simplified way of defining the Amazon API Gateway APIs, AWS Lambda functions, and Amazon DynamoDB tables needed by your serverless application")
          ("url" . "https://raw.githubusercontent.com/aws/serverless-application-model/main/samtranslator/schema/schema.json")) (("description" . "golangci-lint configuration file")
          ("name" . "Golangci-lint Configuration")
          ("fileMatch" . [".golangci.yml" ".golangci.yaml" ".golangci.toml" ".golangci.json"])
          ("url" . "https://golangci-lint.run/jsonschema/golangci.jsonschema.json")
          ("versions" . (("1" . "https://golangci-lint.run/jsonschema/golangci.v1.jsonschema.json")
            ("2" . "https://golangci-lint.run/jsonschema/golangci.v2.jsonschema.json"))))])
       ("validate" . (("enable" . t)))))
     ("exportPdf" . "onSave")
     ("gopls" . (("usePlaceholders" . :json-false)
       ("codelenses" . (("regenerate_cgo" . t)
         ("run_govulncheck" . t)
         ("test" . t)
         ("tidy" . t)
         ("upgrade_dependency" . t)
         ("vendor" . t)
         ("gc_details" . :json-false)
         ("generate" . t)))
       ("staticcheck" . t)
       ("directoryFilters" . ["-.git" "-.vscode" "-.idea" "-.vscode-test" "-node_modules"])
       ("gofumpt" . t)
       ("hints" . (("compositeLiteralFields" . t)
         ("compositeLiteralTypes" . t)
         ("constantValues" . t)
         ("functionTypeParameters" . t)
         ("rangeVariableTypes" . t)
         ("parameterNames" . t)
         ("assignVariableTypes" . t)))
       ("completeUnimported" . t)
       ("semanticTokens" . t)
       ("experimentalPostfixCompletions" . t)
       ("analyses" . (("unusedvariable" . t)
         ("nilness" . t)
         ("unusedparams" . t)
         ("unusedwrite" . t)
         ("useany" . t)))))
     ("js/ts" . (("inlayHints" . (("enumMemberValues" . (("enabled" . t)))
         ("parameterTypes" . (("enabled" . t)))
         ("variableTypes" . (("enabled" . t)))
         ("propertyDeclarationTypes" . (("enabled" . t)))
         ("functionLikeReturnTypes" . (("enabled" . t)))
         ("parameterNames" . (("enabled" . "literals")
           ("suppressWhenArgumentMatchesName" . t)))))))
     ("helm-ls" . (("valuesFiles" . (("mainValuesFile" . "base_values.yaml")
         ("additionalValuesFilesGlobPattern" . "(dev|qa|prod)-*.yaml")))
       ("logLevel" . "warn")))
     ("taplo" . (("schema" . (("associations" . ((".*sesh\\.toml$" . "https://github.com/joshmedeski/sesh/raw/main/sesh.schema.json")))))))
     ("yaml" . (("schemas" . (("https://raw.githubusercontent.com/aws/serverless-application-model/main/samtranslator/schema/schema.json" . ["template.yaml" "serverless.template" "*.sam.json" "*.sam.yml" "*.sam.yaml" "sam.json" "sam.yml" "sam.yaml"])
         ("https://raw.githubusercontent.com/jesseduffield/lazygit/master/schema/config.json" . ["**/lazygit/config.yml" "lazygit.yml" ".lazygit.yml"])
         ("https://golangci-lint.run/jsonschema/golangci.jsonschema.json" . [".golangci.yml" ".golangci.yaml" ".golangci.toml" ".golangci.json"])
         ("https://www.schemastore.org/jekyll.json" . ["_config.yml"])
         ("https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json" . ["*.cf.json" "*.cf.yml" "*.cf.yaml" "cloudformation.json" "cloudformation.yml" "cloudformation.yaml"])
         ("https://raw.githubusercontent.com/helm-unittest/helm-unittest/refs/heads/main/schema/helm-testsuite.json" . ["**/charts/*/tests/*.yaml"])
         ("https://www.schemastore.org/github-action.json" . ["action.yml" "action.yaml"])
         ("https://www.schemastore.org/github-workflow.json" . ["**/.github/workflows/*.yml" "**/.github/workflows/*.yaml" "**/.gitea/workflows/*.yml" "**/.gitea/workflows/*.yaml" "**/.forgejo/workflows/*.yml" "**/.forgejo/workflows/*.yaml"])
         ("https://www.schemastore.org/chart.json" . ["Chart.yaml"])))
       ("format" . (("enable" . t)))
       ("keyOrdering" . :json-false)
       ("schemaStore" . (("enable" . :json-false)
         ("url" . "")))
       ("completion" . t)
       ("hover" . t)
       ("customTags" . ["!fn" "!And" "!If" "!Not" "!Equals" "!Or" "!FindInMap sequence" "!Base64" "!Cidr" "!Ref" "!Ref Scalar" "!Sub" "!GetAtt" "!GetAZs" "!ImportValue" "!Select" "!Split" "!Join sequence"])))
     ("redhat" . (("telemetry" . (("enabled" . :json-false)))))
     ("rust-analyzer" . (("workspace" . (("cargo" . (("autoreload" . t)))
         ("symbol" . (("search" . (("kind" . "only_types")
             ("scope" . "workspace_and_dependencies")))))))))
     ("semanticTokens" . "disable")
     ("formatterMode" . "typstyle")
     ("Lua" . (("completion" . (("callSnippet" . "Replace")))
       ("workspace" . (("checkThirdParty" . :json-false)
         ("ignoreDir" . [".archived"])
         ("library" . ["${NVIM_RUNTIME}" "${3rd}/luv/library" "${NVIM_DATA}/site/pack/core/opt/wezterm-types"])))
       ("hint" . (("enable" . t)))
       ("runtime" . (("version" . "LuaJIT")))
       ("telemetry" . (("enable" . :json-false)))
       ("diagnostics" . (("disable" . ["missing-fields" "missing-parameter"])
         ("globals" . ["vim" "parse" "s" "sn" "t" "f" "i" "c" "fmt" "rep" "wezterm"])
         ("unusedLocalExcludes" . ["_*"])))
       ("format" . (("enable" . t))))))))

(defun nvim-parity-register-settings (settings &optional prefix)
  "Register SETTINGS without mixing object settings with flattened children.
Preserve existing client object boundaries, schema maps, and dotted keys."
  (maphash
   (lambda (key value)
     (let ((path (if prefix (concat prefix "." key) key)))
       (if (and (hash-table-p value)
                (not (member key '("schemas" "associations")))
                (not (and (boundp 'lsp-client-settings)
                          (gethash path lsp-client-settings))))
           (nvim-parity-register-settings value path)
         ;; Also remove stale leaves when reloading a previously flattened map.
         (when (boundp 'lsp-client-settings)
           (maphash (lambda (registered _)
                      (when (string-prefix-p (concat path ".") registered)
                        (remhash registered lsp-client-settings)))
                    lsp-client-settings))
         (lsp-register-custom-settings (list (list path value))))))
   settings))

(defvar lsp--cur-workspace)

(after! lsp-mode
  (cl-labels ((register (id command modes &optional addon options activation)
                (lsp-register-client
                 (make-lsp-client
                  :server-id id :major-modes modes :priority 10 :add-on? addon
                  :activation-fn activation
                  :new-connection (lsp-stdio-connection
                                   (lambda () (nvim-parity-command command))
                                   (lambda ()
                                     (nvim-parity-executable
                                      (car command)
                                      (when (equal (car command) "tsc")
                                        #'nvim-parity-native-typescript-p))))
                  :initialization-options options
                  :initialized-fn
                  (lambda (workspace)
                    (let ((lsp--cur-workspace workspace))
                      (lsp--set-configuration (lsp--default-workspace-configuration))))))))
    (register 'nvim-parity-ty '("ty" "server") '(python-mode python-ts-mode))
    (register 'nvim-parity-ruff '("ruff" "server") '(python-mode python-ts-mode)
              t '(:settings (:logLevel "error")))
    (let ((modes '(js-mode js-ts-mode js2-mode rjsx-mode typescript-mode
                           typescript-ts-mode tsx-ts-mode web-mode)))
      (register 'nvim-parity-tsc '("tsc" "--lsp" "--stdio") modes nil nil
                #'nvim-parity-javascript-buffer-p)
      (register 'nvim-parity-biome '("biome" "lsp-proxy") modes t nil
                #'nvim-parity-javascript-buffer-p))
    (register 'nvim-parity-smithy '("smithy-language-server") '(nvim-parity-smithy-mode))
    (register 'nvim-parity-helm '("helm_ls" "serve") '(yaml-mode yaml-ts-mode)
              nil nil (lambda (&rest _)
                        (and (derived-mode-p 'yaml-mode 'yaml-ts-mode)
                             (nvim-parity-helm-template-p))))
    (register 'nvim-parity-tinymist '("tinymist") '(typst-ts-mode) nil
              '(:formatterMode "typstyle" :exportPdf "onSave" :semanticTokens "disable"))
    (register 'nvim-parity-fish '("fish-lsp" "start") '(fish-mode))
    (register 'nvim-parity-nushell '("nu" "--lsp") '(nushell-mode))
    (register 'nvim-parity-taplo '("taplo" "lsp" "stdio") '(conf-toml-mode toml-ts-mode))
    (register 'nvim-parity-docker '("docker-language-server" "start" "--stdio")
              '(dockerfile-mode dockerfile-ts-mode)))

  (dolist (entry '((nvim-parity-smithy-mode . "smithy") (nushell-mode . "nu")
                   (typst-ts-mode . "typst") (fish-mode . "fish")
                   (conf-toml-mode . "toml") (toml-ts-mode . "toml")))
    (add-to-list 'lsp-language-id-configuration entry))
  (add-to-list 'lsp-file-watch-ignored-directories "[/\\\\]\\.venv\\'")
  (setq lsp-enable-on-type-formatting nil)
  ;; Fill portable library placeholders without requiring a running Neovim.
  (let* ((lua (gethash "Lua" nvim-parity-server-settings))
         (workspace (gethash "workspace" lua))
         (data (expand-file-name "nvim/" (or (getenv "XDG_DATA_HOME") "~/.local/share/")))
         (nvim (executable-find "nvim"))
         (runtime (or (getenv "VIMRUNTIME")
                      (when nvim
                        (expand-file-name "../../share/nvim/runtime" (file-truename nvim))))))
    (puthash "library"
             (vconcat '("${3rd}/luv/library") (cl-remove-if-not
                       #'file-directory-p
                       (delq nil (list runtime (expand-file-name "site/pack/core/opt/wezterm-types" data)))))
             workspace))

  ;; Keep the personal sesh schema association; only add the work schema if usable.
  (when-let* ((_ (equal (getenv "IS_WORK_PC") "true"))
              (file (expand-file-name "~/IdeaProjects/infra/values.schema.json"))
              (_ (file-exists-p file)))
    (puthash (concat "file://" file) ["**/values/*.yaml"]
             (gethash "schemas" (gethash "yaml" nvim-parity-server-settings))))

  ;; Built-in clients register defaults when loaded. Reapply our leaves afterwards.
  (dolist (feature '(lsp-go lsp-lua lsp-yaml lsp-json lsp-rust lsp-metals))
    (require feature nil t))
  (nvim-parity-register-settings nvim-parity-server-settings)

  ;; Metals' Emacs client uses kebab-case keys and has its own installation API.
  (after! lsp-metals
    (setq lsp-metals-install-version "1.6.9"
          lsp-metals-server-args '("-J-Xmx4G" "-J-Xms1G")
          lsp-metals-fallback-scala-version "2.13.16"
          lsp-metals-test-user-interface "Test Explorer"
          lsp-metals-enable-semantic-highlighting t
          lsp-metals-super-method-lenses-enabled nil
          lsp-metals-inlay-hints-enable-inferred-types t
          lsp-metals-inlay-hints-enable-implicit-conversions nil
          lsp-metals-inlay-hints-enable-implicit-arguments t
          lsp-metals-inlay-hints-enable-type-parameters nil
          lsp-metals-inlay-hints-enable-hints-in-pattern-match t)))


;; These modes are outside Doom's standard language LSP hooks.
(dolist (mode '(nvim-parity-smithy-mode nushell-mode typst-ts-mode fish-mode
                conf-toml-mode toml-ts-mode))
  (add-hook (intern (format "%s-local-vars-hook" mode)) #'lsp! t))

(after! projectile
  (dolist (marker '("smithy-build.json" "Chart.yaml" "build.sbt" "pyproject.toml"))
    (add-to-list 'projectile-project-root-files marker)))

(after! apheleia
  ;; Apheleia accepts multiple formatters and pipes their output sequentially.
  ;; Use actual source filenames so Biome/Ruff/Prettier find project settings.
  (dolist (entry
           '((nvim-gofumpt . ("gofumpt"))
             (nvim-gofmt . ("gofmt"))
             (nvim-rustfmt . ("rustfmt" "--emit" "stdout" "--edition" (nvim-parity-rust-edition)))
             (nvim-ruff . ("ruff" "format" "--stdin-filename" filepath "-"))
             (nvim-ruff-imports . ("ruff" "check" "--quiet" "--select" "I" "--fix" "--exit-zero"
                                   "--stdin-filename" filepath "-"))
             (nvim-biome . ("biome" "format" "--stdin-file-path" filepath))
             (nvim-prettier . ("prettier" "--stdin-filepath" filepath))
             (nvim-markdownlint . ("markdownlint-cli2" "--format"))
             ;; `inplace' is an Apheleia scratch file, never the real document.
             (nvim-markdown-toc . ("markdown-toc" "-i" inplace))))
    (setf (alist-get (car entry) apheleia-formatters) (cdr entry)))

  (defun nvim-parity-rust-edition ()
    "Read package/workspace edition from ancestor Cargo.toml files."
    (let ((directory default-directory) edition)
      (while (and directory (not edition) (not (file-remote-p directory)))
        (let ((manifest (expand-file-name "Cargo.toml" directory)))
          (when (file-readable-p manifest)
            (with-temp-buffer
              (insert-file-contents manifest)
              (when (re-search-forward "^[[:space:]]*edition[[:space:]]*=[[:space:]]*\"\\([0-9]+\\)\"" nil t)
                (setq edition (match-string 1))))))
        (let ((parent (file-name-directory (directory-file-name directory))))
          (setq directory (unless (equal directory parent) parent))))
      (or edition "2021")))

  (defconst nvim-parity-formatters
    '((go-mode nvim-gofumpt nvim-gofmt)
      (go-ts-mode nvim-gofumpt nvim-gofmt)
      (rust-mode nvim-rustfmt) (rust-ts-mode nvim-rustfmt) (rustic-mode nvim-rustfmt)
      (python-mode nvim-ruff nvim-ruff-imports) (python-ts-mode nvim-ruff nvim-ruff-imports)
      (js-mode nvim-biome) (js-ts-mode nvim-biome) (js2-mode nvim-biome)
      (rjsx-mode nvim-biome) (typescript-mode nvim-biome)
      (typescript-ts-mode nvim-biome) (tsx-ts-mode nvim-biome)
      (markdown-mode nvim-prettier nvim-markdownlint nvim-markdown-toc)
      (gfm-mode nvim-prettier nvim-markdownlint nvim-markdown-toc)))

  (dolist (entry nvim-parity-formatters)
    (setf (alist-get (car entry) apheleia-mode-alist) (cdr entry)))

  (defun nvim-parity-format-setup ()
    "Assign external chains and keep all other modes on manual formatting."
    (let ((chain (cdr (assq major-mode nvim-parity-formatters))))
      (when (and (eq major-mode 'web-mode) buffer-file-name
                 (string-match-p "\\.[jt]sx\\'" buffer-file-name))
        (setq chain '(nvim-biome)))
      (when chain
        (setq-local apheleia-formatter chain))
      (setq-local nvim-parity-format-on-save (and chain t))))

  (defvar-local nvim-parity-format-on-save nil)
  (defun nvim-parity-inhibit-save-format ()
    "Only enable automatic formatting in modes with an explicit chain."
    ;; Compute this here too: globalized minor modes can run before mode hooks.
    (nvim-parity-format-setup)
    (not nvim-parity-format-on-save))

  ;; Set these before the first LSP connection can select its own formatter.
  (add-hook 'after-change-major-mode-hook #'nvim-parity-format-setup)
  (nvim-parity-format-setup)
  (add-hook 'apheleia-inhibit-functions #'nvim-parity-inhibit-save-format)
  (remove-hook 'lsp-managed-mode-hook #'+format-with-lsp-toggle-h)
  (remove-hook 'eglot-managed-mode-hook #'+format-with-lsp-toggle-h))

