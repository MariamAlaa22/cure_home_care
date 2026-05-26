abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String message;
  const AuthSuccess(this.message);
}

class AuthError extends AuthState {
  final String errorMessage;
  const AuthError(this.errorMessage);
}