# Terraform Configuration Language Syntax
- [Terraform Configuration](https://developer.hashicorp.com/terraform/language)
- [Terraform Configuration Syntax](https://developer.hashicorp.com/terraform/language/syntax/configuration)
```
# Template
<BLOCK TYPE> "<BLOCK LABEL>" "<BLOCK LABEL>"   {
  # Block body
  <IDENTIFIER> = <EXPRESSION> # Argument
}

# AWS Example
resource "aws_instance" "ec2demo" { # BLOCK
  ami           = "ami-04d29b6f966df1537" # Argument
  instance_type = var.instance_type # Argument with value as expression (Variable value replaced from varibales.tf
}
```

## Understand about Arguments, Attributes and Meta-Arguments.
- Arguments can be required or optional
- Attribues format looks like resource_type.resource_name.attribute_name
- Meta-Arguments change a resource type's behavior (Example: count, for_each)
- [Resource: AWS Instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#attribute-reference)
- [Resource: Meta-Arguments](https://developer.hashicorp.com/terraform/language/meta-arguments/depends_on)
