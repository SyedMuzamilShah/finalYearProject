import 'package:fpdart/fpdart.dart';
import 'package:my_desktop_app/core/failure/failure.dart';
import 'package:my_desktop_app/features/auth/data/datasources/login/login_datasources.dart';
import 'package:my_desktop_app/features/auth/data/models/request/login_request_prams.dart';
import 'package:my_desktop_app/features/auth/domain/repositories/auth_repositories_class.dart';

class LoginRepoImpl implements LoginRepository {
  final LoginDatasources _sources;
  LoginRepoImpl(this._sources);


  @override
  Future<Either<Failure, String>> login(LoginRequestPrams prams) {
    return _sources.login(prams);
  }
}