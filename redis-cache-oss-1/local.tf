locals {
  redis_cache = toset(
      [
        "hubspring-cache",
        "payhub-cache-1"
      ]
  )
}

