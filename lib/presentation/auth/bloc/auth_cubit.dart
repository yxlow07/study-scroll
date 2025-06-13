import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_scroll/domain/entities/student.dart';
import 'package:study_scroll/domain/repositories/auth_repo.dart';
import 'package:study_scroll/presentation/auth/bloc/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  Student? _student;

  Student? get student => _student;

  AuthCubit({required this.authRepository}) : super(AuthInitial(initialMode: AuthMode.login));

  void toggleAuthMode() {
    final currentState = state;
    if (currentState is AuthSignedOut || currentState is AuthInitial || currentState is AuthError) {
      final newMode = currentState.mode == AuthMode.login ? AuthMode.signUp : AuthMode.login;
      if (state is AuthSignedOut) {
        emit(AuthSignedOut(currentMode: newMode));
      } else {
        emit(AuthInitial(initialMode: newMode));
      }
    }
  }

  void checkAuthStatus() async {
    emit(AuthLoading(currentMode: state.mode));
    try {
      _student = await authRepository.getCurrentUser();
      if (_student != null) {
        emit(AuthSignedIn(_student!));
      } else {
        emit(AuthSignedOut());
      }
    } catch (e) {
      emit(AuthError('Failed to check authentication status: $e', currentMode: state.mode));
    }
  }

  Future<void> signIn(String email, String password) async {
    final currentMode = state.mode;
    emit(AuthLoading(currentMode: currentMode));

    try {
      final student = await authRepository.signInWithEmailAndPassword(email, password);
      _student = student;
      emit(AuthSignedIn(student));
    } catch (e) {
      emit(AuthError('Failed to sign in: $e', currentMode: currentMode));
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    final currentMode = state.mode;
    emit(AuthLoading(currentMode: currentMode));

    try {
      _student = await authRepository.signUpWithEmailAndPassword(email, password, name);
      if (_student != null) {
        emit(AuthSignedIn(_student!));
      } else {
        emit(AuthError('Failed to sign up', currentMode: currentMode));
      }
    } catch (e) {
      emit(AuthError('Failed to sign up: $e', currentMode: currentMode));
    }
  }

  Future<void> signOut() async {
    final currentMode = state.mode;
    emit(AuthLoading(currentMode: currentMode));

    try {
      await authRepository.signOut();
      _student = null;
      emit(AuthSignedOut());
    } catch (e) {
      emit(AuthError('Failed to sign out: $e', currentMode: currentMode));
    }
  }
}
