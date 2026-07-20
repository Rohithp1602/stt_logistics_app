/// Lightweight failure types for repository / service error handling.
///
/// Controllers map these to user-facing messages instead of throwing raw
/// exceptions into the UI layer.
sealed class Failure {
  const Failure(this.message);

  final String message;
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed']);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failed']);
}

class StorageFailure extends Failure {
  const StorageFailure([super.message = 'Local storage error']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Resource not found']);
}
