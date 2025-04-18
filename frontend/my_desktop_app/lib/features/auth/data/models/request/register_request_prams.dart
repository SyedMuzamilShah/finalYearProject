class RegisterRequestPrams {
  final String email;
  final String password;
  final String name;
  final String phone;

  RegisterRequestPrams({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'phone': phone,
    };
  }
}