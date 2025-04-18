class RegisterParams {
  final String userName;
  final String? name;
  final String email;
  final String password;
  final String? phoneNumber;

  RegisterParams({
    required this.userName,
    required this.email,
    required this.password,
    this.name,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() {

    
    return {
      'userName': userName,
      'email': email,
      'password': password,
      'name': name,
      if (phoneNumber != null) 'phoneNumber': phoneNumber,
    };
  }
}