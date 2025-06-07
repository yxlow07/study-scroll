import 'package:study_scroll/domain/entities/student.dart';

abstract class AuthRepository {
  Future<Student> signInWithEmailAndPassword(String email, String password);
  Future<Student> signUpWithEmailAndPassword(String email, String password, String name);
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<Student?> getCurrentUser();
  Future<Student> resetPassword(String email);
}
