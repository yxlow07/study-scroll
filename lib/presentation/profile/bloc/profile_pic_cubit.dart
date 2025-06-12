import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_scroll/data/datasource/backblaze_api.dart';
import 'package:study_scroll/domain/repositories/profile_repo.dart';
import 'package:study_scroll/presentation/profile/bloc/profile_pic_state.dart';

class ProfilePicCubit extends Cubit<ProfilePicState> {
  final BackBlazeApi backblazeApi;
  final ProfileRepo profileRepo;
  final ImagePicker _picker = ImagePicker();

  ProfilePicCubit({required this.backblazeApi, required this.profileRepo}) : super(ProfilePicInitial());

  Future<void> pickAndUploadFile(String bucketId, String uid) async {
    emit(ProfilePicLoading());
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        final fileData = await pickedFile.readAsBytes();
        final mimeType = 'image/jpeg';
        String? fileId = await backblazeApi.uploadFile(
          bucketId,
          pickedFile.name,
          mimeType,
          fileData,
        );
        if (fileId == null) {
          emit(ProfilePicError('Failed to upload file'));
          return;
        }
        await profileRepo.updateProfilePicture(uid, fileId);
        emit(ProfilePicUpdateSuccess(fileId));
      } else {
        emit(ProfilePicError('No file selected'));
      }
    } catch (e) {
      emit(ProfilePicError(e.toString()));
    }
  }
}
