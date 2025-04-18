class ChangePasswordParams {
  final String oldPassword;
  final String newPassword;
  ChangePasswordParams({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }
}