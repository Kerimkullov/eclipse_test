class CreateComment {
  final String name;
  final String email;
  final String body;

  CreateComment({
    required this.name,
    required this.email,
    required this.body,
  });

  CreateComment copyWith({
    String? name,
    String? email,
    String? body,
  }) {
    return CreateComment(
      name: name ?? this.name,
      email: email ?? this.email,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'body': body,
    };
  }

  factory CreateComment.fromMap(Map<String, dynamic> map) {
    return CreateComment(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      body: map['body'] ?? '',
    );
  }

  @override
  String toString() => 'CreateComment(name: $name, email: $email, body: $body)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateComment &&
        other.name == name &&
        other.email == email &&
        other.body == body;
  }
}
