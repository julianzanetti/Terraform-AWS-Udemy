variable "aws_region" {
    description = "Region in which AWS Resources to be created"
    type = string
    default = "sa-east-1"
}

variable "business_divsion" {
    description = "Business Division in the large organization this Infrastructure belongs"
    type = string
    default = "SAP"
}

variable "environment" {
    description = "Environment Variable used as a prefix"
    type = string
    default = "Dev"
}