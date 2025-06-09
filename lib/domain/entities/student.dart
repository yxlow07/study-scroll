class Student {
  final String uid;
  late final String name;
  final String email;

  Student({required this.uid, required this.name, required this.email});

  @override
  String toString() {
    return 'User(uid: $uid, name: $name, email: $email)';
  }

  // Factory constructor to create a User from a map
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(uid: map['uid'] as String, name: map['name'] as String, email: map['email'] as String);
  }

  // Method to convert User to a map
  Map<String, dynamic> toJson() {
    return {'uid': uid, 'name': name, 'email': email};
  }
}
