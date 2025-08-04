##### creating the dummy file #########

data "archive_file" "dummy" {
  type        = "zip"
  output_path = "${path.module}/lambda_function_payload.zip"
  source {
    content  = "hello"
    filename = "dummy.txt"
  }
}

######### VPC and Subnets #######


data "aws_vpc" "app_svc2_vpc" {
  filter {
    name   = "tag:Name"
    values = [module.naming.generated_names.app-svc2.virtual_private_network[0]]
  }
}

#data "aws_subnets" "app-private" {

#  filter {
#    name   = "tag:Name"
#    values = [module.naming.generated_names.app-svc.subnet[0]]
#  }
#}


#data "aws_subnets" "app-private-2" {

#  filter {
#    name   = "tag:Name"
#    values = [module.naming.generated_names.app-svc.subnet[1]]
#  }
#}


data "aws_subnets" "app-private" {

  filter {
    name   = "tag:Name"
    values = ["${module.naming.generated_names.reflex-lambda.subnet[0]}a"]
  }
}


data "aws_subnets" "app-private-2" {

  filter {
    name   = "tag:Name"
    values = ["${module.naming.generated_names.reflex-lambda.subnet[0]}b"]
  }
}

data "aws_caller_identity" "current" {}

####### IAM   ################


data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}


resource "aws_iam_role" "kfone_iam_lambda_role_reflex" {
  name               = "core_as_a_service_lambda_execution"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

locals {
  lambda_managed_policies = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaENIManagementAccess",
    "arn:aws:iam::aws:policy/service-role/AWSLambdaSQSQueueExecutionRole",
    "arn:aws:iam::aws:policy/AWSLambdaExecute",         
    "arn:aws:iam::aws:policy/service-role/AWSLambdaRole" 
  ]
}

resource "aws_iam_role_policy_attachment" "lambda_policies" {
  for_each   = toset(local.lambda_managed_policies)
  role       = aws_iam_role.kfone_iam_lambda_role_reflex.name
  policy_arn = each.key
}


#########################
# Locals
#########################

locals {
  all_private_subnet_ids = concat(
    data.aws_subnets.app-private.ids,
    data.aws_subnets.app-private-2.ids
  )

}


resource "aws_security_group" "reflex_lambda_sg" {
  name        = module.naming.generated_names.reflex_lambda.security_group[0]
  description = "Allow HTTP and HTTPS traffic"
  vpc_id      = data.aws_vpc.app_svc2_vpc.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    tags = merge(
    {
      Name = module.naming.generated_names.reflex_lambda.security_group[0]
    },
    module.naming.tags)
}



resource "aws_lambda_function" "lambda_functions" {
  for_each = {
    for lambda in var.lambda_configs :
    lambda.name => lambda
  }

  function_name = each.value.name
  runtime       = each.value.runtime
  handler       = each.value.handler
  memory_size   = each.value.memory_size
  timeout       = each.value.timeout
  role          = aws_iam_role.kfone_iam_lambda_role_reflex.arn
#  role          =  data.aws_iam_role.lambda_roles[each.key].arn
#  role          = var.lambda_role_arn
  filename      = data.archive_file.dummy.output_path
  architectures = [each.value.architecture]

  ephemeral_storage {
    size = each.value.ephemeral_storage
  }

  dynamic "vpc_config" {
    for_each = each.value.use_vpc ? [1] : []
    content {
      subnet_ids         = local.all_private_subnet_ids
#      security_group_ids = data.aws_security_groups.lambda_sgs[each.key].ids
      security_group_ids = [aws_security_group.reflex_lambda_sg.id]
    }
  }

  dynamic "environment" {
    for_each = lookup(each.value, "environment", null) != null ? [1] : []
    content {
      variables = each.value.environment
    }
  }

  tags = merge ({
    Name = each.value.name
  },
  module.naming.tags )

 depends_on = [
    aws_iam_role.kfone_iam_lambda_role_reflex,
    aws_iam_role_policy_attachment.lambda_policies,
    aws_security_group.reflex_lambda_sg
  ]
}




################ S3 Triggers for Lambda #######################


locals {
  s3_lambda_triggers = flatten([
    for lambda in var.lambda_configs : (
      lambda.s3_triggers != null ? [
        for idx, s3 in lambda.s3_triggers : {
          lambda_name  = lambda.name
          bucket_name  = s3.bucket_name
          events       = s3.events
          prefix       = lookup(s3, "filter_prefix", null)
          suffix       = lookup(s3, "filter_suffix", null)
          unique_id    = "${lambda.name}-${s3.bucket_name}-${idx}"
        }
      ] : []
    )
  ])

  s3_notification_grouped = {
    for trigger in local.s3_lambda_triggers :
    trigger.bucket_name => trigger ...           ### it does groupby list 
  }
}

resource "aws_lambda_permission" "s3" {
  for_each = {
    for trigger in local.s3_lambda_triggers :
    trigger.unique_id => trigger
  }

  statement_id  = "AllowExecutionFromS3-${replace(each.key, "_", "-")}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_functions[each.value.lambda_name].function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${each.value.bucket_name}"
}



resource "aws_s3_bucket_notification" "lambda" {
  for_each = local.s3_notification_grouped

  bucket = each.key

  dynamic "lambda_function" {
    for_each = each.value
    content {
      lambda_function_arn = aws_lambda_function.lambda_functions[lambda_function.value.lambda_name].arn
      events              = lambda_function.value.events
      filter_prefix       = lambda_function.value.prefix
      filter_suffix       = lambda_function.value.suffix
    }
  }

  depends_on = [aws_lambda_permission.s3]
}


#################### SQS Trigger  ######################

locals {
  sqs_queue_names = distinct(flatten([
    for lambda in var.lambda_configs : (
      lambda.sqs_triggers != null ? [
        for sqs in lambda.sqs_triggers : sqs.queue_name
      ] : []
    )
  ]))
}

data "aws_sqs_queue" "trigger_queues" {
  for_each = toset(local.sqs_queue_names)
  name     = each.key
}

locals {
  lambda_sqs_triggers = flatten([
    for lambda in var.lambda_configs : (
      lambda.sqs_triggers != null ? [
        for idx, sqs in lambda.sqs_triggers : {
          lambda_name         = lambda.name
          queue_name          = sqs.queue_name
          queue_arn           = data.aws_sqs_queue.trigger_queues[sqs.queue_name].arn
          batch_size          = lookup(sqs, "batch_size", 10)
          enabled             = lookup(sqs, "enabled", true)
          maximum_concurrency = lookup(sqs, "maximum_concurrency", null)
          filter_pattern      = lookup(sqs, "filter_pattern", null)
          unique_id           = "${lambda.name}-${idx}"
        }
      ] : []
    )
  ])
}

resource "aws_lambda_event_source_mapping" "sqs" {
  for_each = {
    for trigger in local.lambda_sqs_triggers :
    trigger.unique_id => trigger
  }

  event_source_arn      = each.value.queue_arn
  function_name         = aws_lambda_function.lambda_functions[each.value.lambda_name].arn
  batch_size            = each.value.batch_size
  enabled               = each.value.enabled
#  maximum_concurrency   = each.value.maximum_concurrency

  dynamic "filter_criteria" {
    for_each = each.value.filter_pattern != null ? [1] : []
    content {
      filter {
        pattern = each.value.filter_pattern
      }
    }
  }
}



locals {
  all_apigw_triggers = flatten([
    for lambda in var.lambda_configs : [
      for idx, trigger in lookup(lambda, "apigateway_triggers", []) : {
        lambda_name   = lambda.name
        rest_api_id   = trigger.rest_api_id
        region        = var.region
        account_id    = data.aws_caller_identity.current.account_id
        method        = upper(trigger.method)
        path          = trim(trigger.path, "/")  
        authorization = lookup(trigger, "authorization", null)
        authorizer_id = lookup(trigger, "authorizer_id", null)
        source_arn    = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${trigger.rest_api_id}/*/${upper(trigger.method)}/${trim(trigger.path, "/")}"
        unique_id     = "${lambda.name}-${idx}"
      }
    ]
  ])
}


resource "aws_lambda_permission" "apigateway" {
  for_each = {
    for trigger in local.all_apigw_triggers :
    trigger.unique_id => trigger
  }

  statement_id  = "AllowExecutionFromAPIGateway-${replace(each.key, "_", "-")}"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_functions[each.value.lambda_name].function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = each.value.source_arn
}
