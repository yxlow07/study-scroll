import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_scroll/domain/entities/profile.dart';
import 'package:study_scroll/domain/repositories/profile_repo.dart';

class FirebaseProfileRepo implements ProfileRepo {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<void> deleteProfile(String uid) {
    // TODO: implement deleteProfile
    throw UnimplementedError();
  }

  @override
  Future<Profile?> getProfile(String uid) async {
    try {
      final userDoc = firestore.collection('students').doc(uid).get();

      return userDoc.then((doc) {
        if (doc.exists) {
          return Profile.fromMap(doc.data()!);
        } else {
          return null; // No profile found
        }
      });
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Future<Profile?> updateProfile(Profile profile) async {
    try {
      await firestore.collection('students').doc(profile.uid).set(profile.toJson(), SetOptions(merge: true));
      return profile; // Return the updated profile
    } catch (e) {
      print(e);
      throw Exception('Failed to update profile');
    }
  }
}
