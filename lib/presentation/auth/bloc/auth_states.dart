import 'package:study_scroll/domain/entities/student.dart';

enum AuthMode { login, signUp }

abstract class AuthState {
  final AuthMode mode;
  const AuthState(this.mode);

  get student => null;
}

class AuthInitial extends AuthState {
  AuthInitial({AuthMode initialMode = AuthMode.login}) : super(initialMode);
}

class AuthLoading extends AuthState {
  AuthLoading({required AuthMode currentMode}) : super(currentMode);
}

class AuthSignedIn extends AuthState {
  final Student student;

  AuthSignedIn(this.student) : super(AuthMode.login);
}

class AuthSignedOut extends AuthState {
  AuthSignedOut({AuthMode currentMode = AuthMode.login}) : super(currentMode);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message, {required AuthMode currentMode}) : super(currentMode);
}
