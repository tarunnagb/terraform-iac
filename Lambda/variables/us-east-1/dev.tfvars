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

lambda_configs = [
  {
    name              = "kfcore-caas-publications-proxy-dev"
    runtime           = "nodejs22.x"
    handler           = "index.handler"
    memory_size       = 1536
    timeout           = 300
    architecture      = "x86_64"
    ephemeral_storage = 512
    use_vpc           = false

    s3_triggers = [
    ]

    sqs_triggers = []
    
    apigateway_triggers = [
    ]

    environment = {
      allowedDomains              = "https://assessments.kfproducts.com"
      apiCustomDomain             = "coreaas-api.kfproducts.com"
      apiGatewayExecuteApiResource = "arn:aws:execute-api:us-east-1:595302228523:j735yqg24g/*"
      apiGatewayHost              = "j735yqg24g.execute-api.us-east-1.amazonaws.com"
      cert                        = "AQECAHgSjKcPtT5OQVw/ANxo+0yFHFz3vO4Z1vwHElANxwT9yQAABwwwggcI..."
      contentLambdaFunction       = "arn:aws:lambda:us-east-1:595302228523:function:kfcore-caas-publications-proxy-prod"
      kmsKeyArn                   = "arn:aws:kms:us-east-1:595302228523:key/b26d63ff-7b99-44bb-ac48-912f2d13c689"
      kpId                        = "AQECAHgSjKcPtT5OQVw/ANxo+0yFHFz3vO4Z1vwHElANxwT9yQAAAHIwcAYJ..."
      launchBucket                = "prod-reflexaas-launch"
      launchHost                  = "assessments-launch.kfproducts.com"
      region                      = "us"
      responsesBucket             = "prod.reflexaas.responses"
      sec                         = "AQECAHgSjKcPtT5OQVw/ANxo+0yFHFz3vO4Z1vwHElANxwT9yQAAAIMwgYAG..."
      snapshot                    = "2024-11-07T09:54:13Z"
      trackerBucket               = "prod.reflexaas.tracker"
      userRoleArn                 = "arn:aws:iam::595302228523:role/core_as_a_service_lambda_basic_execution"
      webHost                     = "assessments.kfproducts.com"
    }
  },

  {
    name              = "kfcore-raas-proxy-dev"
    runtime           = "nodejs22.x"
    handler           = "index.handler"
    memory_size       = 3008
    timeout           = 30
    architecture      = "x86_64"
    ephemeral_storage = 512
    use_vpc           = false
    s3_triggers       = []
    sqs_triggers      = []
    environment       = {}
    apigateway_triggers = [
    ]
  },
  {
    name              = "kfcore-caas-authoring-proxy-dev"
    runtime           = "nodejs22.x"
    handler           = "index.handler"
    memory_size       = 3008
    timeout           = 30
    architecture      = "x86_64"
    ephemeral_storage = 512
    use_vpc           = false
    s3_triggers       = []
    sqs_triggers      = []
    environment       = {}
    apigateway_triggers = []
  },
  {
    name              = "kfcore-job-router-lambda-proxy-dev"
    runtime           = "nodejs22.x"
    handler           = "index.handler"
    memory_size       = 3008
    timeout           = 30
    architecture      = "x86_64"
    ephemeral_storage = 512
    use_vpc           = false
    s3_triggers       = []
    sqs_triggers      = []
    environment       = {}
    apigateway_triggers = []
  },
  {
    name              = "kfcore-rptaas-proxy-dev"
    runtime           = "nodejs22.x"
    handler           = "index.handler"
    memory_size       = 3008
    timeout           = 30
    architecture      = "x86_64"
    ephemeral_storage = 512
    use_vpc           = false
    s3_triggers       = []
    sqs_triggers      = []
    environment       = {}
    apigateway_triggers = []
  },
  {
    name              = "kfcore-rptaas-printer-pdf-proxy-dev"
    runtime           = "nodejs22.x"
    handler           = "index.handler"
    memory_size       = 3008
    timeout           = 30
    architecture      = "x86_64"
    ephemeral_storage = 512
    use_vpc           = false
    s3_triggers       = []
    sqs_triggers      = []
    environment       = {}
    apigateway_triggers = []
  },
  {
    name              = "kfcore-scaas-proxy-dev"
    runtime           = "nodejs22.x"
    handler           = "index.handler"
    memory_size       = 3008
    timeout           = 30
    architecture      = "x86_64"
    ephemeral_storage = 512
    use_vpc           = false
    s3_triggers       = []
    sqs_triggers      = []
    environment       = {}
    apigateway_triggers = []
  },
  {
    name              = "kfcore-sass-auth-lambda-proxy-dev"
    runtime           = "nodejs22.x"
    handler           = "index.handler"
    memory_size       = 3008
    timeout           = 30
    architecture      = "x86_64"
    ephemeral_storage = 512
    use_vpc           = false
    s3_triggers       = []
    sqs_triggers      = []
    environment       = {}
    apigateway_triggers = []
  }
]


