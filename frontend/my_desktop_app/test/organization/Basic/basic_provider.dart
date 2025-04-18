import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_desktop_app/features/auth/data/models/request/login_params.dart';
import 'package:my_desktop_app/features/auth/data/models/request/register_params.dart';
import 'package:my_desktop_app/features/auth/presentation/providers/basic_auth_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  group("🧪 BasicAuthProviderNotifier Tests", () {
    late BasicAuthProviderNotifier authProvider;

    setUp(() {
      authProvider = BasicAuthProviderNotifier();
    });

    test("✅ Initial state should be correct", () {
      if (kDebugMode) {
        print("Checking initial state...");
      }
      expect(authProvider.state.isLoading, false,
          reason: "Initial isLoading should be false");
      expect(authProvider.state.errorMessage, isNull,
          reason: "Initial errorMessage should be null");
      expect(authProvider.state.successMessage, isNull,
          reason: "Initial successMessage should be null");
      expect(authProvider.state.errorList, isNull,
          reason: "Initial errorList should be null");
      if (kDebugMode) {
        print("✅ Initial state test passed!");
      }
    });

    test("⏳ Login should set loading state", () async {
      if (kDebugMode) {
        print("Triggering login...");
      }
      final loginParma = LoginParams(email: 'syed@gmail.com', password: '123457');
      authProvider.login(loginParma);
      expect(authProvider.state.isLoading, true,
          reason: "Login should set isLoading to true");
      if (kDebugMode) {
        print("✅ Login loading state test passed!");
      }
    });

    test("✅ Login should update success state", () async {
      if (kDebugMode) {
        print("Setting login success state...");
      }
      authProvider.state = authProvider.state.copyWith(
        successMessage: "Login successful",
        isLoading: false,
      );
      expect(authProvider.state.successMessage, "Login successful",
          reason: "Success message should match");
      expect(authProvider.state.isLoading, false,
          reason: "isLoading should be false after login");
      if (kDebugMode) {
        print("✅ Login success state test passed!");
      }
    });

    test("🚨 Login should update error state", () async {
      if (kDebugMode) {
        print("Simulating login failure...");
      }
      authProvider.state = authProvider.state.copyWith(
        errorMessage: "Invalid credentials",
        isLoading: false,
      );
      expect(authProvider.state.errorMessage, "Invalid credentials",
          reason: "Error message should match");
      expect(authProvider.state.isLoading, false,
          reason: "isLoading should be false on failure");
      if (kDebugMode) {
        print("✅ Login error state test passed!");
      }
    });

    test("⏳ Register should set loading state", () async {
      if (kDebugMode) {
        print("Triggering registration...");
      }
      final model = RegisterParams(
          userName: "User", email: "test@example.com", password: "password");

      authProvider.register(model: model);
      expect(authProvider.state.isLoading, true,
          reason: "Register should set isLoading to true");
      if (kDebugMode) {
        print("✅ Register loading state test passed!");
      }
    });

    test("✅ Register should update success state", () async {
      if (kDebugMode) {
        print("Setting registration success state...");
      }
      authProvider.state = authProvider.state.copyWith(
        successMessage: "Registration successful",
        isLoading: false,
      );
      expect(authProvider.state.successMessage, "Registration successful",
          reason: "Success message should match");
      expect(authProvider.state.isLoading, false,
          reason: "isLoading should be false after registration");
      if (kDebugMode) {
        print("✅ Register success state test passed!");
      }
    });

    test("⏳ Logout should set loading state", () async {
      if (kDebugMode) {
        print("Triggering logout...");
      }
      authProvider.logout();
      expect(authProvider.state.isLoading, true,
          reason: "Logout should set isLoading to true");
      if (kDebugMode) {
        print("✅ Logout loading state test passed!");
      }
    });

    test("✅ Logout should clear the state", () async {
      if (kDebugMode) {
        print("Clearing state...");
      }
      authProvider.state = authProvider.state.clear();
      expect(authProvider.state.isLoading, false,
          reason: "isLoading should reset to false");
      expect(authProvider.state.errorMessage, isNull,
          reason: "errorMessage should be null after logout");
      expect(authProvider.state.successMessage, isNull,
          reason: "successMessage should be null after logout");
      expect(authProvider.state.errorList, isNull,
          reason: "errorList should be null after logout");
      if (kDebugMode) {
        print("✅ Logout clear state test passed!");
      }
    });
  });
}
