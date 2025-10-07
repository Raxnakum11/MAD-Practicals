class User {
  final int? id;
  final String fullName;
  final String email;
  final String password;
  final String phoneNumber;
  final DateTime createdAt;

  User({
    this.id,
    required this.fullName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'password': password,
      'phone_number': phoneNumber,
      'created_at': createdAt.millisecondsSinceEpoch,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      fullName: map['full_name'],
      email: map['email'],
      password: map['password'],
      phoneNumber: map['phone_number'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
    );
  }

  User copyWith({
    int? id,
    String? fullName,
    String? email,
    String? password,
    String? phoneNumber,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
