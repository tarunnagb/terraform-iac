module "naming" {
  source             = "./modules"
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
    "hubspring-redis" = {
      "redis_cache" = 1,
      "subnet_group"  = 1,
      "security_group" = 1
    }

    "payhub-redis" = {
      "redis_cache" = 1,
      "subnet_group"  = 1,
      "security_group" = 1
    }

    "ocp-app" = {
      "subnet"  = 3,
      "virtual_private_network"  = 1
    }
    
    "redis" = {
      "subnet_group"  = 1,
      "security_group" = 1
    }
    "app-gha"={
      "security_group"     = 1
    }
  }
}

