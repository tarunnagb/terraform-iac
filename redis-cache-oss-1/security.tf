resource "aws_security_group" "redis_security_group" {
  for_each  = toset(local.redis_cache)
  name        = module.naming.generated_names[each.value].security_group[0]
  #name        = module.naming.generated_names.redis-spring.security_group[0]
  description = "Security group for Redis cache"
  vpc_id      = data.aws_vpc.eks_vpc.id

  ingress {
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    cidr_blocks     = [data.aws_vpc.eks_vpc.cidr_block]
    description     = "Allow access from OCP App vpc to Redis"
 }

  ingress {
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = var.vpn_cidrs
    description = "Allow access from VPN to Redis" 
  }

  # Egress rule to allow outbound traffic to the internet
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
    
}