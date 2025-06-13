import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_scroll/data/datasource/backblaze_api.dart';
import 'package:study_scroll/domain/repositories/profile_repo.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_pic_state.dart';

class ProfilePicCubit extends Cubit<ProfilePicState> {
  final BackBlazeApi backblazeApi;
  final ProfileRepo profileRepo;
  final ImagePicker _picker = ImagePicker();
  File? _pickedFile;

  ProfilePicCubit({required this.backblazeApi, required this.profileRepo}) : super(ProfilePicInitial());

  Future<void> pickFile() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _pickedFile = File(pickedFile.path);
        emit(ProfilePicFilePicked(_pickedFile!));
      } else {
        emit(ProfilePicError('No file selected'));
      }
    } catch (e) {
      emit(ProfilePicError(e.toString()));
    }
  }

  Future<void> uploadFile(String bucketId, String uid) async {
    if (_pickedFile == null) {
      emit(ProfilePicError('No file picked'));
      return;
    }

    emit(ProfilePicLoading());

    try {
      final fileData = await _pickedFile!.readAsBytes();
      final mimeType = 'image/jpeg';
      String? fileId = await backblazeApi.uploadFile(bucketId, uid, mimeType, fileData);
      if (fileId == null) {
        emit(ProfilePicError('BackBlaze upload failed'));
        return;
      }
      await profileRepo.updateProfilePicture(uid, fileId);
      emit(ProfilePicUpdateSuccess(fileId));
      _pickedFile = null;
    } catch (e) {
      emit(ProfilePicError(e.toString()));
    }
  }
}
