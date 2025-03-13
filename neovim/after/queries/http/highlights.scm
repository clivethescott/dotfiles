; extends

(request
  (raw_body) @request.body)

(variable_declaration
  (identifier) @variable.identifier)

(variable_declaration
  (value) @variable.value)

(header
  (value) @header.value)

(comment
  (value) @request.name)
