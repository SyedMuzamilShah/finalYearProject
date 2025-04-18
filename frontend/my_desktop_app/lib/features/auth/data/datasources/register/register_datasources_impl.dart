import 'package:fpdart/fpdart.dart';
import 'package:my_desktop_app/core/failure/failure.dart';
import 'package:my_desktop_app/core/services/api_services.dart';
import 'package:my_desktop_app/features/auth/data/datasources/register/register_datasources.dart';
import 'package:my_desktop_app/features/auth/data/models/request/register_request_prams.dart';


class RegisterDatasourcesImpl implements RegisterDatasources {
  final ApiServices _apiServices;
  RegisterDatasourcesImpl(this._apiServices);
  
  @override
  Future<Either<Failure, String>> register(RegisterRequestPrams prams) async{
    var response = await _apiServices.postRequest(
      endPoint: '/register',
      body: prams.toJson()
    );
    return 
      response.fold(
        (err) => Left(Failure(err.message)),
        (succ) {
          if (succ.statusCode == 201){
            return Right('Success');
          } else {
            return Left(Failure('Failed'));
          }
        }
      );
  }
}