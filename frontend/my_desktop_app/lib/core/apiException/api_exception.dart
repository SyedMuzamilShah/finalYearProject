import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  factory ApiException.fromDioError(DioException error){
    switch(error.type){
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException("Request timed out. Please try again.");
      
      case DioExceptionType.cancel:
        return ApiException("Request was cancelled.");
      
      default:
        return ApiException("Something went wrong.");
    }
  }


  @override
  String toString() => message;
}