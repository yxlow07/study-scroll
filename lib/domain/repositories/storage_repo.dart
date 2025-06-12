abstract class StorageRepository {
  Future<String> uploadFile(String bucketId, String fileName, String mimeType, List<int> fileData);
}
