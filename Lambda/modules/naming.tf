module "naming" {
  source             = "./Naming/"
  organization       = var.INSTANCE
  environment        = var.ENVIRONMENT
  location           = var.location
  Line-Of-Business   = var.Line-Of-Business
  Applications-Dept  = var.Applications-Dept
  Cost-Center        = var.Cost-Center
  WBS-Code           = var.WBS-Code
  KFDAppSubgroup     = var.infra_KFDAppSubGroup
  KFDAppGroup        = var.infra_KFDAppGroup
  Environment        = var.Env
  Accessibility      = var.Accessibility
  Classification     = var.Classification
  Owner              = var.Owner
  HasPII             = var.HasPII
  Compliance         = var.Compliance
  Tech-Owner         = var.Tech-Owner
  map-migrated       = var.map-migrated
  generator = {   
    "reflex_lambda"={
      "security_group"     = 1
    }
    "reflex-lambda" = {
      "subnet"  = 3
    }
    "app-svc2" = {
      "virtual_private_network" = 1
    }
  }
}