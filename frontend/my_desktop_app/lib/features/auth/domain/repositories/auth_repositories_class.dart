import 'package:fpdart/fpdart.dart';
import 'package:my_desktop_app/core/failure/failure.dart';
import 'package:my_desktop_app/features/auth/data/models/request/login_request_prams.dart';

abstract class LoginRepository {
  Future<Either<Failure, String>> login(LoginRequestPrams prams);
}

abstract class RegisterRepository {
  Future<Either<Failure, String>> register();
}

abstract class ChangePasswordRepository {
  Future<Either<Failure, String>> changePassword();
}

abstract class LogoutRepository {
  Future<Either<Failure, String>> logout();
}

abstract class ForgotPasswordRepository {
  Future<Either<Failure, String>> forgotPassword();
}