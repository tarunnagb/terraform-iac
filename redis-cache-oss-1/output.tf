#output "redis_primary_endpoint" {
#  value = aws_elasticache_replication_group.example.primary_endpoint_address
#}

#output "redis_reader_endpoint" {
#  value = aws_elasticache_replication_group.example.reader_endpoint_address
#}


#output "redis_primary_endpoints" {
#  value = {
#    for key, rg in aws_elasticache_replication_group.example :
#    key => rg.primary_endpoint_address
#  }
#}

#output "redis_reader_endpoints" {
##  value = {
#    for key, rg in aws_elasticache_replication_group.example :
#    key => rg.reader_endpoint_address
#  }
#}

output "redis_endpoint" {
  value = {
    for key, rg in aws_elasticache_serverless_cache.redis :
    key => rg.endpoint
  }
}



