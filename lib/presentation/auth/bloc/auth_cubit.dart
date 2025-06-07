import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_scroll/domain/entities/student.dart';
import 'package:study_scroll/domain/repositories/auth_repo.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  Student? _student;

  Student? get student => _student;

  AuthCubit({required this.authRepository}) : super(AuthInitial());

  void checkAuthStatus() async {
    emit(AuthLoading());
    try {
      _student = await authRepository.getCurrentUser();
      if (_student != null) {
        emit(AuthSignedIn(_student!));
      } else {
        emit(AuthSignedOut());
      }
    } catch (e) {
      emit(AuthError('Failed to check authentication status: $e'));
    }
  }

  Future<void> signIn(String email, String password) async {
    emit(AuthLoading());
    try {
      _student = await authRepository.signInWithEmailAndPassword(email, password);
      if (_student != null) {
        emit(AuthSignedIn(_student!));
      } else {
        emit(AuthSignedOut());
      }
    } catch (e) {
      emit(AuthError('Failed to sign in: $e'));
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    emit(AuthLoading());
    try {
      _student = await authRepository.signUpWithEmailAndPassword(email, password, name);
      if (_student != null) {
        emit(AuthSignedIn(_student!));
      } else {
        emit(AuthSignedOut());
      }
    } catch (e) {
      emit(AuthError('Failed to sign up: $e'));
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await authRepository.signOut();
      _student = null;
      emit(AuthSignedOut());
    } catch (e) {
      emit(AuthError('Failed to sign out: $e'));
    }
  }
}
