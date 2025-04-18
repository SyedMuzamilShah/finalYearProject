import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:my_desktop_app/core/apiException/api_exception.dart';
import 'package:my_desktop_app/core/services/token_service.dart';

class ApiServices {

  // Singleton instance
  static final ApiServices _instance = ApiServices._();
  factory ApiServices() => _instance;


  final Dio _dio =
    Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com'));
  final TokenService _tokenStorage = TokenService();

  // Private class constructor
  ApiServices._(){
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = _tokenStorage.token;
        options.receiveDataWhenStatusError = true;
        options.receiveTimeout = Duration(seconds: 15);
        options.connectTimeout = Duration(seconds: 15);

        if (token != null) {
          options.headers["Authorization"] = "Bearer $token";
        }else {
          print("Token Is Null print is in Api Sevices InterceptorsWrapper");
        }
        return handler.next(options);
      },
    ));
  }


  // Post request function
  Future<Either<ApiException, Response>> postRequest({
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _requestHandler(() =>
        _dio.post(endPoint, data: body, queryParameters: queryParameters));
  }

  // get request function
  Future<Either<ApiException, Response>> getRequest({
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _requestHandler(
        () => _dio.get(endPoint, data: body, queryParameters: queryParameters));
  }

  // put request function
  Future<Either<ApiException, Response>> putRequest({
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _requestHandler(
        () => _dio.put(endPoint, data: body, queryParameters: queryParameters));
  }

  // delete request function
  Future<Either<ApiException, Response>> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _requestHandler(() =>
        _dio.delete(endPoint, data: body, queryParameters: queryParameters));
  }

  // patch request function
  Future<Either<ApiException, Response>> patchRequest({
    required String endPoint,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    return await _requestHandler(() =>
        _dio.patch(endPoint, data: body, queryParameters: queryParameters));
  }
}


// RequestHandler
Future<Either<ApiException, Response>> _requestHandler(
    Future<Response> Function() request) async {
  try {
    var response = await request();
    return Right(response);
  } on DioException catch (e){
    return Left(ApiException.fromDioError(e));
  } catch (e) {
    return Left(ApiException("Unexpected error: $e"));
  }
}
