import 'package:study_scroll/domain/entities/profile.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile profile;
  final String? profilePictureBase64;

  ProfileLoaded(this.profile, {this.profilePictureBase64});

  ProfileLoaded copyWith({Profile? profile, String? profilePictureBase64}) {
    return ProfileLoaded(
      profile ?? this.profile,
      profilePictureBase64: profilePictureBase64 ?? this.profilePictureBase64,
    );
  }

  List<Object> get props => [profile, profilePictureBase64 ?? ''];
}

class ProfileUpdateSuccess extends ProfileState {
  final Profile profile;
  ProfileUpdateSuccess(this.profile);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
