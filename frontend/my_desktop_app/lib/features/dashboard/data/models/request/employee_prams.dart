// import 'dart:io';
// import 'package:dio/dio.dart';

// class EmployeeCreatePrams {
//   final String userName;
//   final String name;
//   final String email;
//   final String password;
//   final File? image;
//   final String phoneNumber;
//   final String role;
//   final String organizationId;

//   EmployeeCreatePrams({
//     required this.userName,
//     required this.name,
//     required this.email,
//     required this.password,
//     this.image,
//     required this.phoneNumber,
//     required this.role,
//     required this.organizationId,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'userName':userName,
//       'name': name,
//       'email': email,
//       'password': password,
//       'phoneNumber': phoneNumber,
//       'role': role,
//       'organizationId': organizationId,
//     };
//   }

//   /// Converts to FormData for image upload
//   Future<Map<String, dynamic>> toFormData() async {
//     final Map<String, dynamic> data = toJson();

//     if (image != null) {
//       data['image'] =
//           // await MultipartFile.fromFile(image!.path, filename: 'profile.jpg');
//           await MultipartFile.fromFile(image!.path);
//     }

//     return data;
//   }
// }
