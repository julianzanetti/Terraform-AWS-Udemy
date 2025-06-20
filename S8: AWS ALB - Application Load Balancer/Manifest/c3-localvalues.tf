# Example of how to use locals
locals {
  owner = var.business_divsion
  enviroment = var.environment
  name = "${var.business_divsion}-${var.environment}"
  #name = "${local.owners}-${local.environment}"
  commom_tags = {
    owner = local.owner
    enviroment = local.enviroment
  } 
}