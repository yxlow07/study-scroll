import 'package:study_scroll/domain/entities/student.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSignedIn extends AuthState {
  final Student student;

  AuthSignedIn(this.student);
}

class AuthSignedOut extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}
