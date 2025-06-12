import 'dart:convert';
import 'package:http/http.dart' as http;

class BackBlazeApi {
  final String keyId;
  final String applicationKey;
  String? authorizationToken;
  String? apiUrl;

  BackBlazeApi({required this.keyId, required this.applicationKey});

  Future<void> _authorize() async {
    final credentials = base64.encode(utf8.encode('$keyId:$applicationKey'));
    final response = await http.get(
      Uri.parse('https://api.backblazeb2.com/b2api/v2/b2_authorize_account'),
      headers: {'Authorization': 'Basic $credentials'},
    );

    print(response.body);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      authorizationToken = data['authorizationToken'];
      apiUrl = data['apiUrl'];
    } else {
      throw Exception('Failed to authorize with Backblaze B2');
    }
  }

  Future<String> getUploadUrl(String bucketId) async {
    if (authorizationToken == null || apiUrl == null) {
      await _authorize();
    }

    String url = '$apiUrl/b2api/v2/b2_get_upload_url?bucketId=$bucketId';

    final response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': authorizationToken!, 'Content-Type': 'application/json'},
      body: json.encode({'bucketId': bucketId}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      authorizationToken = data['authorizationToken'];
      return data['uploadUrl'];
    } else {
      print('Error: ${response.statusCode} - ${response.body}');
      throw Exception(json.decode(response.body)['message'] ?? 'Failed to get upload URL');
    }
  }

  Future<String?> uploadFile(String bucketId, String fileName, String mimeType, List<int> fileData) async {
    if (authorizationToken == null || apiUrl == null) {
      await _authorize();
    }
    final uploadUrl = await getUploadUrl(bucketId);
    if (uploadUrl.isEmpty) {
      throw Exception('Upload URL is empty');
    }
    final response = await http.post(
      Uri.parse(uploadUrl),
      headers: {
        'Authorization': authorizationToken!,
        'X-Bz-File-Name': fileName,
        'Content-Type': mimeType,
        'X-Bz-Content-Sha1': 'do_not_verify',
      },
      body: fileData,
    );

    print(response.body);
    print(uploadUrl);

    if (response.statusCode != 200) {
      throw Exception('Failed to upload file');
    } else {
      final data = json.decode(response.body);
      final fileId = data['fileId'];
      return fileId;
    }
  }

  @override
  String toString() {
    return 'BackBlazeApi(keyId: $keyId, applicationKey: $applicationKey, authorizationToken: $authorizationToken, apiUrl: $apiUrl)';
  }
}
