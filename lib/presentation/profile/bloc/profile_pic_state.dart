abstract class ProfilePicState {}

class ProfilePicInitial extends ProfilePicState {}

class ProfilePicLoading extends ProfilePicState {}

class ProfilePicLoaded extends ProfilePicState {
  final String profilePictureUrl;

  ProfilePicLoaded(this.profilePictureUrl);
}

class ProfilePicError extends ProfilePicState {
  final String message;

  ProfilePicError(this.message);
}

class ProfilePicUpdateSuccess extends ProfilePicState {
  final String fileId;

  ProfilePicUpdateSuccess(this.fileId);
}
