import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_scroll/domain/entities/student.dart';
import 'package:study_scroll/domain/repositories/auth_repo.dart';

// Implements auth methods with Firebase.

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<Student?> getCurrentUser() async {
    final firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser != null) {
      DocumentSnapshot doc = await firebaseFirestore.collection('students').doc(firebaseUser.uid).get();
      return Future.value(Student(uid: firebaseUser.uid, name: doc['name'], email: firebaseUser.email!));
    } else {
      return Future.value(null);
    }
  }

  @override
  Future<bool> isSignedIn() {
    return Future.value(firebaseAuth.currentUser != null);
  }

  @override
  Future<Student> resetPassword(String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Student> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot doc = await firebaseFirestore.collection('students').doc(userCredential.user!.uid).get();

      Student? student = Student(uid: userCredential.user!.uid, name: doc['name'], email: email);
      return student;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  @override
  Future<Student> signUpWithEmailAndPassword(String email, String password, String name) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Student student = Student(uid: userCredential.user!.uid, name: name, email: email);

      await firebaseFirestore.collection('students').doc(userCredential.user!.uid).set(student.toJson());
      return student;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
