class UserEntities {
  final String? userName;
  final String id;
  final String? name;
  final String email;
  final bool isEmailVerified;
  final String? phoneNumber;
  final String? avatar;

  UserEntities({
    required this.isEmailVerified,
    required this.userName,
    required this.id,
    this.name,
    required this.email,
    this.phoneNumber,
    this.avatar,
  });
}