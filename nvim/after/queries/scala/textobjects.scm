; extends
(function_definition 
  parameters: (parameters)? @function.params)

(class_definition 
  class_parameters: (class_parameters)? @class.params)

(for_expression
  enumerators: (enumerators)? @for.inner) @for.outer

(object_definition
  body: (template_body)? @object.inner) @object.outer
