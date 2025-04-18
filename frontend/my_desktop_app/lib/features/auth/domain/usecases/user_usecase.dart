import 'package:fpdart/fpdart.dart';
import 'package:my_desktop_app/core/failure/failure.dart';
import 'package:my_desktop_app/features/auth/domain/entities/user_entities.dart';
import 'package:my_desktop_app/features/auth/domain/repositories/auth_repositories_class.dart';


abstract class UserUsecase {
  Future<Either<Failure, UserEntities>> getUser();
}

class UserUsecaseImpl extends UserUsecase {

  final UserRepository _userRepo;
  UserUsecaseImpl({required UserRepository userRepo}) : _userRepo = userRepo;

  @override
  Future<Either<Failure, UserEntities>> getUser() async {
    return await _userRepo.getUser();
  }
}