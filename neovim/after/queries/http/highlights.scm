; extends

; https://github.com/nvim-treesitter/nvim-treesitter/blob/master/queries/http/highlights.scm

(request
  (raw_body) @request.body)

(request
  (target_url) @request.url)

(variable_declaration
  (identifier) @variable.declaration)

(variable
  (identifier) @variable.identifier)

(variable_declaration
  (value) @variable.value)

(header
  (value) @header.value)

(comment
  (value) @request.name)
