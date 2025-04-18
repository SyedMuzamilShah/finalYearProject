import 'package:fpdart/fpdart.dart';
import 'package:my_desktop_app/core/failure/failure.dart';
import 'package:my_desktop_app/features/auth/data/models/request/login_request_prams.dart';

abstract class LoginDatasources {
  Future<Either<Failure, String>> login(LoginRequestPrams prams);
}