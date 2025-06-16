locals {
  redis_cache = toset(
      [
        "hubspring-cache",
      ]
  )
}

