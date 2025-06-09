import 'student.dart';

class Profile extends Student {
  final String bio;
  final String profilePictureUrl;
  final List<String> subjects;

  Profile(
    this.bio,
    this.profilePictureUrl,
    this.subjects, {
    required super.uid,
    required super.name,
    required super.email,
  });

  Profile copyWith({String? bio, String? profilePictureUrl, List<String>? subjects, String? name, String? email}) {
    return Profile(
      bio ?? this.bio,
      profilePictureUrl ?? this.profilePictureUrl,
      subjects ?? this.subjects,
      uid: uid,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'bio': bio,
      'profilePictureUrl': profilePictureUrl,
      'subjects': subjects,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      map['bio'] as String,
      map['profilePictureUrl'] as String,
      List<String>.from(map['subjects'] as List),
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }

  @override
  String toString() {
    return 'Profile(uid: $uid, name: $name, email: $email, bio: $bio, profilePictureUrl: $profilePictureUrl, subjects: $subjects)';
  }
}
