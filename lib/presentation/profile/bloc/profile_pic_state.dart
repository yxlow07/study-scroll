import 'dart:io';

abstract class ProfilePicState {}

class ProfilePicInitial extends ProfilePicState {}

class ProfilePicFilePicked extends ProfilePicState {
  final File file;

  ProfilePicFilePicked(this.file);

  List<Object?> get props => [file];
}

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
