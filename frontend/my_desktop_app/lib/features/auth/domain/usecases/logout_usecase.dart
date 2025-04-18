import 'package:fpdart/fpdart.dart';
import 'package:my_desktop_app/core/failure/failure.dart';
import 'package:my_desktop_app/features/auth/domain/repositories/auth_repositories_class.dart';

abstract class LogoutUsecase {
  Future<Either<Failure, String>> logout();
}

class LogoutUsecaseImpl extends LogoutUsecase {
  final LogoutRepository _logoutRepo;
  LogoutUsecaseImpl({required LogoutRepository repo})
      : _logoutRepo = repo;

  @override
  Future<Either<Failure, String>> logout() async {
    return await _logoutRepo.logout();
  }
}
