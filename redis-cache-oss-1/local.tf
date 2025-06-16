locals {
  redis_cache = toset(
      [
        "payhub-ecr",
        "springhub-ecr"
      ]
  )
}

