import 'package:study_scroll/domain/entities/profile.dart';

abstract class ProfileRepo {
  Future<Profile?> getProfile(String uid);
  Future<Profile?> updateProfile(Profile profile);
  Future<void> deleteProfile(String uid);
  Future<void> updateProfilePicture(String uid, String fileId);
}
