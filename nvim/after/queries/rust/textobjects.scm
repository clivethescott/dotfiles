; extends
(function_item 
  name: (identifier)? @function.name
  parameters: (parameters)? @function.params)

(struct_item 
  body: (field_declaration_list) @struct.inner) @struct.outer

(impl_item 
  body: (declaration_list) @impl.inner) @impl.outer

(let_declaration
  pattern: (identifier) @assignment.lhs
  value: (_)? @val.right) @val.outer

; (call_expression
;   value: (field_expression)? @call.inner) @call.outer
