class ForgetRequestPrams {
  String email;

  ForgetRequestPrams({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}