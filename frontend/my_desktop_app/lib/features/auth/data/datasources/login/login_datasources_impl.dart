import 'package:fpdart/fpdart.dart';
import 'package:my_desktop_app/core/failure/failure.dart';
import 'package:my_desktop_app/core/services/api_services.dart';
import 'package:my_desktop_app/features/auth/data/datasources/login/login_datasources.dart';
import 'package:my_desktop_app/features/auth/data/models/request/login_request_prams.dart';

class LoginDatasourcesImpl implements LoginDatasources {
  final ApiServices _apiServices;
  LoginDatasourcesImpl(this._apiServices);
  
  @override
  Future<Either<Failure, String>> login(LoginRequestPrams prams) async{
    var response = await _apiServices.postRequest(
      endPoint: '/login',
      body: prams.toJson()
    );
    return 
      response.fold(
        (err) => Left(Failure(err.message)),
        (succ) {
          if (succ.statusCode == 200){
            return Right('Success');
          } else {
            return Left(Failure('Failed'));
          }
        }
      );
  }

}