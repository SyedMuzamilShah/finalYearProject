import 'package:my_desktop_app/features/auth/domain/entities/user_entities.dart';

class UserResponseModel extends UserEntities {
  UserResponseModel(
      {required super.id, super.name, required super.email, super.avatar, super.phoneNumber, required super.userName, required super.isEmailVerified});

  factory UserResponseModel.fromJson(json) {
    return UserResponseModel(
        id: json["_id"] ?? json["id"], 
        name: json["name"], 
        email: json["email"],
        avatar: json["avatar"],
        phoneNumber: json["phoneNumber"], 
        userName: json["userName"], 
        isEmailVerified: json['isEmailVerified'],
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'userName' : userName,
      'isEmailVerified' : isEmailVerified,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
    };
  }
}
