import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_desktop_app/core/services/api_services.dart';
import 'package:my_desktop_app/core/url/url.dart';
import 'package:my_desktop_app/features/auth/data/models/request/login_params.dart';
import 'package:my_desktop_app/features/auth/data/models/request/register_params.dart';

void main() {
  AuthApiTesting app = AuthApiTesting();

  // app.login();
  app.register();
}

class AuthApiTesting {
  login() async {
    test('Login API returns 200 on successful login', () async {
      final ApiServices api =
          ApiServices(); // Create an instance inside the test.

      final data =
          LoginParams(email: 'Syed@gmail.com', password: '123457');
      try {
        final response = await api.postRequest(
          endPoint: ServerUrl.userLoginRoute,
          body: data.toJson(),
        );
        if (kDebugMode) {
          print(response);
        }
      } catch (err) {
        if (kDebugMode) {
          print(err);
        }
      }
    });
  }

  register() async {
    test('Register API returns 201 on successful login', () async {
      final ApiServices api =
          ApiServices(); // Create an instance inside the test.

      final data = RegisterParams(
          userName: 'syed',
          email: 'SYED123@gmail',
          password: '123457',
          name: 'muzamil');

      try {
        final response = await api.postRequest(
          endPoint: ServerUrl.userLoginRoute,
          body: data.toJson(),
        );
        if (kDebugMode) {
          print(response);
        }
      } catch (err) {
        if (kDebugMode) {
          print('API error: $err');
        }
      }
    });
  }
}
