import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_scroll/data/datasource/backblaze_api.dart';
import 'package:study_scroll/domain/entities/profile.dart';
import 'package:study_scroll/domain/repositories/profile_repo.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;
  final BackBlazeApi backblazeApi;

  String? _currentProfilePictureBase64;

  ProfileCubit({required this.backblazeApi, required this.profileRepo}) : super(ProfileInitial());

  Future<String> _getProfilePictureUrl(String fileId) async {
    return backblazeApi.getDownloadUrl(fileId);
  }

  Future<void> loadProfile(String uid) async {
    try {
      emit(ProfileLoading());
      final profile = await profileRepo.getProfile(uid);
      if (profile != null) {
        String? imageBase64;

        if (profile.profilePictureUrl.isNotEmpty) {
          if (_currentProfilePictureBase64 != null) {
            imageBase64 = _currentProfilePictureBase64;
          } else {
            imageBase64 = await _getProfilePictureUrl(profile.profilePictureUrl);
            _currentProfilePictureBase64 = imageBase64;
          }
        }

        emit(ProfileLoaded(profile, profilePictureBase64: _currentProfilePictureBase64));
      } else {
        emit(ProfileError('Profile not found'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfile(
    String uid,
    String name,
    String email,
    String bio,
    String profilePictureUrl,
    List<String> subjects,
  ) async {
    try {
      Profile newProfile = Profile.fromMap({
        'uid': uid,
        'name': name,
        'email': email,
        'bio': bio,
        'profilePictureUrl': profilePictureUrl,
        'subjects': subjects,
      });

      final updatedProfile = await profileRepo.updateProfile(newProfile);
      if (updatedProfile != null) {
        emit(ProfileUpdateSuccess(updatedProfile));
      } else {
        emit(ProfileError('Failed to update profile'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void clearProfileCache() {
    _currentProfilePictureBase64 = null;
    emit(ProfileInitial());
  }
}
