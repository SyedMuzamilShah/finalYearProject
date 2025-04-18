import 'dart:io';

import 'package:my_desktop_app/core/apiException/api_exception.dart';
import 'package:my_desktop_app/core/services/api_services.dart';
import 'package:my_desktop_app/features/employee/data/datasources/employee_datasources.dart';
import 'package:my_desktop_app/features/employee/data/models/request/employee_prams.dart';

void main() async {
  EmployeeRemoteDataSource source =
      EmployeeRemoteDataSourceImpl(apiServices: ApiServices());

  File imageFile = File('C:/Users/PMLS/Pictures/dashborad.jpg');
  bool hasImage = imageFile.existsSync();

  if (hasImage) {
    print("Image path is correct");
  } else {
    print("Image path is NOT correct");
  }

  // Define a list of employees with different data
  List<EmployeeCreateParams> employees = [
    // EmployeeCreateParams(
    //   userName: 'user_1',
    //   name: 'Alice Johnson',
    //   email: 'alice@gmail.com',
    //   password: 'alice123',
    //   phoneNumber: '+911111111111',
    //   role: 'Servent',
    //   organizationId: 'ORG-UXGOLE',
    //   image: hasImage ? imageFile : null,
    // ),
    EmployeeCreateParams(
      userName: 'user_2',
      name: 'Bob Smith',
      email: 'bob@gmail.com',
      password: 'bob123',
      phoneNumber: '+922222222222',
      role: 'Employee',
      organizationId: 'ORG-UXGOLE',
      image: hasImage ? imageFile : null,
    ),
    EmployeeCreateParams(
      userName: 'user_3',
      name: 'Charlie Davis',
      email: 'charlie@gmail.com',
      password: 'charlie123',
      phoneNumber: '+933333333333',
      role: 'Manager',
      organizationId: 'ORG-UXGOLE',
      image: null, // No image
    ),
  ];

  // Loop through each employee and upload
  for (var data in employees) {
    try {
      late Map<String, dynamic> form;

      if (data.image != null) {
        // form = await data.toFormData();
        form = (await data.toFormData()) as Map<String, dynamic>;
      } else {
        form = data.toJson();
      }

      final response = await source.addEmployee(form);
      print('Uploaded: ${data.email} ✅');
      print(response);
    } catch (e) {
      print('Failed: ${data.email} ❌');
      if (e is ValidationException) {
        print(e.errors);
      } else {
        print(e.toString());
      }
    }
  }
}
