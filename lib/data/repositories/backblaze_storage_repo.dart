// import 'package:study_scroll/data/datasource/backblaze_api.dart';
// import 'package:study_scroll/domain/repositories/storage_repo.dart';
//
// class BackblazeStorageRepo implements StorageRepository {
//   final BackBlazeApi backBlazeApi;
//
//   BackblazeStorageRepo({required this.backBlazeApi});
//
//   @override
//   Future<String> uploadFile(String bucketId, String fileName, String mimeType, List<int> fileData) async {
//     final uploadUrl = await backBlazeApi.getUploadUrl(bucketId);
//     final uploadAuthToken = backBlazeApi.authorizationToken;
//     if (uploadUrl.isEmpty || uploadAuthToken == null) {
//       throw Exception('Failed to get upload URL or authorization token');
//     }
//
//     await backBlazeApi.uploadFile(uploadUrl, uploadAuthToken, fileName, mimeType, fileData);
//
//     return '$uploadUrl/$fileName'; // Return the URL of the uploaded file
//   }
// }
