region = "ap-south-1"              ## Region for which you want to select
ENVIRONMENT= "qa1"
INSTANCE =  "kfone"
location = "mumbai"


vpn_cidrs = ["10.4.0.0/21"]


## Tagging Variables

Line-Of-Business     = "KF Digital"
Applications-Dept    = "One Platform - Core Engine"
Cost-Center          = "US21GPS"
WBS-Code             = "PLATFORM.08"
infra_KFDAppGroup    = "KFOne Platform"
infra_KFDAppSubGroup = "DevOps"
Env                  = "QA"
Owner                = "Seshagiri Nuthalapat"
Accessibility        = "private"
Classification       = "Proprietary"
HasPII               = "TBD"
Compliance           = "TBD"
Tech-Owner           = "Varma Saripalli"

redis_auth_token = {
  hubspring-rc = "ohohrwgjwboeoiwfkrjfj"  
  payhub-rc  = "njfwhouwuohfwjob99jofj"
}