import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_desktop_app/core/services/local_database_service.dart';
import 'package:my_desktop_app/core/services/token_service.dart';
import 'package:my_desktop_app/features/auth/data/models/response/user_response_model.dart';

void main() async {
  // Ensure Hive is initialized before running tests
  TestWidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await LocalDatabaseService().init();

  group("🛠 LocalDatabaseService Tests", () {
    late LocalDatabaseService db;
    late TokenService tokenService;
    late UserResponseModel model;

    setUp(() async {
      db = LocalDatabaseService();
      tokenService = TokenService();
      debugPrint(tokenService.token.toString());
      // Parsing test user data
      Map<String, dynamic> data = apiResponse['data'] as Map<String, dynamic>;
      final user = data['user'];
      final token = data['tokens'];
      
      debugPrint(token);
      
      model = UserResponseModel.fromJson(user);
      
      await db.storeUser(model.toJson());
    });

    test("✅ Should store and retrieve user data correctly", () {
      final storedData = db.getUser();
      expect(storedData, isNotNull);
      
      final retrievedModel = UserResponseModel.fromJson(storedData);
      expect(retrievedModel, equals(model));
    });

    test("✅ Should clear user data correctly", () async {
      await db.clearUser();
      final clearedUser = db.getUser();
      expect(clearedUser, isNull);
    });

    test("✅ Should store and retrieve blog data correctly", () async {
      final blogData = {"title": "Test Blog", "content": "This is a test blog"};
      
      await db.storeBlog(blogData);
      final storedBlog = db.getBlog();
      
      expect(storedBlog, isNotNull);
      expect(storedBlog, equals(blogData));
    });

    test("✅ Should clear blog data correctly", () async {
      await db.clearBlog();
      final clearedBlog = db.getBlog();
      expect(clearedBlog, isNull);
    });

    test("✅ Should validate token structure", () {
      Map<String, dynamic>? d = apiResponse['data'] as Map<String, dynamic>;
      
      expect(d, isNotNull);

      final tokenData = d['tokens'];
      
      expect(tokenData, isNotNull);
      expect(tokenData, contains('accessToken'));
      expect(tokenData, contains('refreshToken'));
      expect(tokenData['accessToken'], isA<String>());
      expect(tokenData['refreshToken'], isA<String>());
    });

    tearDown(() async {
      await db.clearUser();
      await db.clearBlog();
    });
  });
}

final apiResponse = {
  "statusCode": 200,
  "message": "Login successful",
  "data": {
    "user": {
      "_id": "67da288172368ab12c8c9983",
      "name": "Muzmail",
      "userName": "Syed",
      "email": "Syed@gmail.com",
      "phoneNumber": "03141516625",
      "isEmailVerified": false,
      "createdAt": "2025-03-19T02:14:25.405Z",
      "updatedAt": "2025-03-19T02:30:52.843Z"
    },
    "tokens": {
      "accessToken":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2N2RhMjg4MTcyMzY4YWIxMmM4Yzk5ODMiLCJpYXQiOjE3NDIzNTE0NTIsImV4cCI6MTc0MjM1ODY1Mn0.foBrX3NYsHadITT7mbbiU06UWMX22vx1tVEeiTwAF50",
      "refreshToken":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2N2RhMjg4MTcyMzY4YWIxMmM4Yzk5ODMiLCJpYXQiOjE3NDIzNTE0NTIsImV4cCI6MTc0MjQzNzg1Mn0.hMx6TBk1G5rCjJkLm1-NQh8k4OG2RTStWGmpdguPuk4"
    }
  }
};
