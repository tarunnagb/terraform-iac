locals {
  redis_cache = toset(
      [
        "payhub-redis"
      ]
  )
}

