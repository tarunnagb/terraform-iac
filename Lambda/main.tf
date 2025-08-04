module "lambda_functions" {
  source = "./modules/"

  lambda_configs        = var.lambda_configs
  ENVIRONMENT           = var.ENVIRONMENT
  INSTANCE              = var.INSTANCE
  location              = var.location
  region                = var.region
  Env                   = var.Env
  Accessibility         = var.Accessibility
  Classification        = var.Classification
  HasPII                = var.HasPII
  Compliance            = var.Compliance
  Owner                 = var.Owner
  infra_KFDAppGroup     = var.infra_KFDAppGroup
  infra_KFDAppSubGroup  = var.infra_KFDAppSubGroup
  WBS-Code              = var.WBS-Code
  Cost-Center           = var.Cost-Center
  Applications-Dept     = var.Applications-Dept
  Line-Of-Business      = var.Line-Of-Business
  Tech-Owner            = var.Tech-Owner
  map-migrated          = var.map-migrated
}
