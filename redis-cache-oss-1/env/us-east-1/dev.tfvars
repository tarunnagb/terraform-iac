region = "ap-south-1"              ## Region for which you want to select
ENVIRONMENT= "dev"
INSTANCE =  "kfone"
location = "mumbai"

# kms_key_id       = "your-kms-key-id"       # Replace with your actual KMS key ID
# redis_auth_token = "your-auth-token"       # Replace with your actual Redis authentication token

vpn_cidrs = ["10.4.0.0/21"]


## Tagging Variables

Line-Of-Business     = "KF Digital"
Applications-Dept    = "One Platform - Core Engine"
Cost-Center          = "US21GPS"
WBS-Code             = "PLATFORM.08"
infra_KFDAppGroup    = "KFOne Platform"
infra_KFDAppSubGroup = "DevOps"
Env                  = "Dev"
Owner                = "Seshagiri Nuthalapat"
Accessibility        = "private"
Classification       = "Proprietary"
HasPII               = "TBD"
Compliance           = "TBD"
Tech-Owner           = "Varma Saripalli"

redis_auth_token = {
  hubspring-rc = "ohohrwgjwboeoiwfk"
  payhub-rc  = "njfwhouwuohfwjob99"
}
