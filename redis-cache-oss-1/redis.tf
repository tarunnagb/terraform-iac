
resource "random_password" "redis_auth_token" {
  for_each = local.redis_cache

  length  = 32
  special = true
  upper   = true
  lower   = true
  numeric = true
  override_special = "_%@"
}

resource "aws_secretsmanager_secret" "redis_secret" {
  for_each = local.redis_cache

  name = "${var.INSTANCE}/redis/${each.key}/${var.ENVIRONMENT}/auth"
}


resource "aws_secretsmanager_secret_version" "redis_secret_version" {
  for_each = local.redis_cache

  secret_id     = aws_secretsmanager_secret.redis_secret[each.key].id
  secret_string = jsonencode({
    password = random_password.redis_auth_token[each.key].result
  })
}

resource "aws_elasticache_user" "redis_user" {
  for_each = local.redis_cache

  engine        = "REDIS"
  user_id       = "${var.INSTANCE}-${each.key}-${var.ENVIRONMENT}-user"
  user_name     = "${var.INSTANCE}-${each.key}-${var.ENVIRONMENT}-user"
  access_string = "on ~* +@all"

  authentication_mode {
    type      = "password"
    passwords = [
      random_password.redis_auth_token[each.key].result
    ]
  }

  depends_on = [aws_secretsmanager_secret_version.redis_secret_version]
}


resource "aws_elasticache_user_group" "redis_cache_user_group" {
  for_each = local.redis_cache

  engine        = "REDIS"
  user_group_id = "${each.key}-${var.ENVIRONMENT}-group"
  user_ids = [
    "default",
    aws_elasticache_user.redis_user[each.key].user_id
  ]
}



locals {
  subnet_ids = concat([data.aws_subnet.redis_subnets_1a.id], [data.aws_subnet.redis_subnets_1b.id])
}



resource "aws_elasticache_serverless_cache" "redis" {
  for_each  = toset(local.redis_cache)
  engine = "redis"
  name   = module.naming.generated_names[each.value].redis_cache[0]
  cache_usage_limits {
    data_storage {
      maximum = 10
      unit    = "GB"
    }
    ecpu_per_second {
      maximum = 5000
    }
  }
  daily_snapshot_time      = "09:00"
  description              = "hub Server"
  #kms_key_id              = aws_kms_key.test.arn
  major_engine_version     = "7"
  snapshot_retention_limit = 1
  security_group_ids       = [aws_security_group.redis_security_group[each.key].id]
  subnet_ids               = local.subnet_ids
  user_group_id            = aws_elasticache_user_group.redis_cache_user_group[each.key].user_group_id
  #depends_on              = [aws_security_group.redis_security_group]
}

