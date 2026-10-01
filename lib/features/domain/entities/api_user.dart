class ApiUser {
  final String id;
  final String avatar;
  final String account;
  final String name;
  final String email;
  final String phoneNumber;
  final String departmentNumber;

  const ApiUser({
    required this.id,
    this.avatar = '',
    required this.account,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.departmentNumber,
  });

  factory ApiUser.fromJson(Map<String, dynamic> json) {
    final department = json['department'];
    return ApiUser(
        id: json['_id']?.toString() ?? '',
        avatar: json['avatar']?.toString() ?? '',
        account: json['account']?.toString() ?? '',
        name: json['name']?.toString() ?? '',
        email: json['email']?.toString() ?? '',
        phoneNumber: json['phoneNumber']?.toString() ?? '',
        departmentNumber: department is Map ? department['name']?.toString() ?? '' : '',
    );
  }
}
