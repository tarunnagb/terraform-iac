region = "us-east-1"              ## Region for which you want to select
ENVIRONMENT= "dev"
INSTANCE =  "kfone"
location = "northvirginia"


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

#lambda_configs = [
#  {
#    name              = "kfcore-caas-publications-proxy-dev"
##    runtime           = "nodejs22.x"
 #   handler           = "index.handler"
 #   memory_size       = 1536
 #   timeout           = 300
 #   architecture      = "x86_64"
 #   ephemeral_storage = 512
 #   use_vpc           = false

 #   s3_triggers = [
 #   ]

 #   sqs_triggers = []
 #   
 #   apigateway_triggers = [
 #   ]

 #   environment = {
 #   }
 # },

 # {
 #   name              = "kfcore-raas-proxy-dev"
 ##   runtime           = "nodejs22.x"
  #  handler           = "index.handler"
  #  memory_size       = 3008
  #  timeout           = 30
  #  architecture      = "x86_64"
  #  ephemeral_storage = 512
  #  use_vpc           = false
  #  s3_triggers       = []
  #  sqs_triggers      = []
  #  environment       = {}
  #  apigateway_triggers = [
  #  ]
  #},
  #{
   # name              = "kfcore-caas-authoring-proxy-dev"
   # runtime           = "nodejs22.x"
   # handler           = "index.handler"
   # memory_size       = 3008
   # timeout           = 30
   # architecture      = "x86_64"
   # ephemeral_storage = 512
   # use_vpc           = false
   # s3_triggers       = []
   # sqs_triggers      = []
   # environment       = {}
   # apigateway_triggers = []
  #},
  #{
  #  name              = "kfcore-job-router-lambda-proxy-dev"
   # runtime           = "nodejs22.x"
   # handler           = "index.handler"
   # memory_size       = 3008
   # timeout           = 30
   # architecture      = "x86_64"
   # ephemeral_storage = 512
   # use_vpc           = false
   # s3_triggers       = []
   # sqs_triggers      = []
   # environment       = {}
   # apigateway_triggers = []
  ##},
  #{
  #  name              = "kfcore-rptaas-proxy-dev"
  #  runtime           = "nodejs22.x"
  #  handler           = "index.handler"
  #  memory_size       = 3008
  #  timeout           = 30
  #  architecture      = "x86_64"
  #  ephemeral_storage = 512
  #  use_vpc           = false
  #  s3_triggers       = []
  #  sqs_triggers      = []
  #  environment       = {}
  #  apigateway_triggers = []
  #},
  #{
  #  name              = "kfcore-rptaas-printer-pdf-proxy-dev"
  #  runtime           = "nodejs22.x"
  #  handler           = "index.handler"
  #  memory_size       = 3008
  #  timeout           = 30
  #  architecture      = "x86_64"
  #  ephemeral_storage = 512
  #  use_vpc           = false
  #  s3_triggers       = []
  #  sqs_triggers      = []
  #  environment       = {}
  #  apigateway_triggers = []
  #},
  #{
  #  name              = "kfcore-scaas-proxy-dev"
  #  runtime           = "nodejs22.x"
  #  handler           = "index.handler"
# memory_size       = 3008
   # timeout           = 30
   # architecture      = "x86_64"
   # ephemeral_storage = 512
   # use_vpc           = false
   # s3_triggers       = []
   # sqs_triggers      = []
   # environment       = {}
   # apigateway_triggers = []
  #},
  #{
  #  name              = "kfcore-sass-auth-lambda-proxy-dev"
  #  runtime           = "nodejs22.x"
  #  handler           = "index.handler"
  #  memory_size       = 3008
  #  timeout           = 30
  #  architecture      = "x86_64"
  #  ephemeral_storage = 512
  #  use_vpc           = false
  #  s3_triggers       = []
  #  sqs_triggers      = []
  #  environment       = {}
  #  apigateway_triggers = []
  #}
#]



