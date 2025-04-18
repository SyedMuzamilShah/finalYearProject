class ChangePasswordRequestPrams {
  final String oldPassword;
  final String newPassword;
  ChangePasswordRequestPrams({
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