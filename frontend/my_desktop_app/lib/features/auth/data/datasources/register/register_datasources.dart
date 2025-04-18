import 'package:fpdart/fpdart.dart';
import 'package:my_desktop_app/core/failure/failure.dart';
import 'package:my_desktop_app/features/auth/data/models/request/register_request_prams.dart';

abstract class RegisterDatasources {
  Future<Either<Failure, String>> register(RegisterRequestPrams prams);
}