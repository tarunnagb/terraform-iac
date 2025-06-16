locals {
  redis_cache = toset(
      [
        "payhub-cache-dem"
      ]
  )
}

