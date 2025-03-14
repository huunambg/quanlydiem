class User {
  int? userId;
  String? password;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? role;
  String? createdAt;
  int? status;

  User({
    this.userId,
    this.password,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.role,
    this.status,
  });

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    password = json['password'];
    fullName = json['full_name'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    role = json['role'];
    createdAt = json['created_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['user_id'] = userId.toString();
    data['password'] = password;
    data['full_name'] = fullName;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['role'] = role;
    data['status'] = status.toString();
    return data;
  }

  User copyWith({
    int? userId,
    String? password,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? role,
    String? createdAt,
    int? status,
  }) {
    return User(
      userId: userId ?? this.userId,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      status: status ?? this.status,
    );
  }
}
