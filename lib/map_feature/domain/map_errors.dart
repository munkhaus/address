enum LocationError {
  permissionDenied,
  serviceDisabled,
  timeout,
  unknown,
}

enum RouteError {
  invalidPoints,
  routeNotFound,
  networkError,
  serverError,
  serviceUnavailable,
  unknown,
}

enum AddressError {
  networkError,
  serverError,
  searchQueryTooShort,
  noResultsFound,
  rateLimitExceeded,
  unknown,
} 