// import 'package:fpdart/fpdart.dart';
// import 'package:my_desktop_app/core/failure/failure.dart';
// import 'package:my_desktop_app/core/services/api_services.dart';
// import 'package:my_desktop_app/features/employee/data/models/request/employee_prams.dart';
// import 'package:my_desktop_app/features/employee/domain/entities/employee_entities.dart';


// // ------------------------------------ Abstract Classes --------------------------------
// abstract class EmployeeDataSources<Type, Prams> {
//   Future<Type> call({required Prams prams});
// }




// // ----------------------------------- Concurrent Classes --------------------------------


// // ------------------------------------
// //               Create               -
// // ------------------------------------
// class EmployeeCreateDataSources extends EmployeeDataSources<Either<Failure, EmployeeEntities>, EmployeeCreatePrams> {
//   final ApiServices services;
//   EmployeeCreateDataSources(this.services);

//   @override
//   Future<Either<Failure, EmployeeEntities>> call({required EmployeeCreatePrams prams}) async {
//     throw UnimplementedError();
//     // var response = await services.postRequest(
//     //   endPoint: '/employee-create',
//     //   body: prams.toJson()
//     // );
//     // return 
//     //   response.fold(
//     //     (err) => Left(Failure(message: err.message)),
//     //     (succ) {
//     //       if (succ.statusCode == 201){
//     //         return Right(EmployeeResponseModel.fromJson(succ.data));
//     //       } else {
//     //         return Left(Failure(message: 'Failed'));
//     //       }
//     //     }
//     //   );
//   }

// }


// // ------------------------------------
// //               Update               -
// // ------------------------------------
// class EmployeeUpdateDataSources extends EmployeeDataSources<Either<Failure, EmployeeEntities>, EmployeeUpdatePrams> {
//   final ApiServices services;
//   EmployeeUpdateDataSources(this.services);

//   @override
//   Future<Either<Failure, EmployeeEntities>> call({required EmployeeUpdatePrams prams}) async {
//     throw UnimplementedError();

//     // var response = await services.postRequest(
//     //   endPoint: '/employee-update',
//     //   body: prams.toJson()
//     // );

//     // return 
//     //   response.fold(
//     //     (err) => Left(Failure(message: err.message)),
//     //     (succ) {
//     //       if (succ.statusCode == 200){
//     //         return Right(EmployeeResponseModel.fromJson(succ.data));
//     //       } else {
//     //         return Left(Failure(message: 'Failed'));
//     //       }
//     //     }
//     //   );
//   }

// }


// // ------------------------------------
// //               Delete               -
// // ------------------------------------
// class EmployeeDeleteDataSources extends EmployeeDataSources<Either<Failure, EmployeeEntities>, EmployeeDeletePrams> {
//   final ApiServices services;
//   EmployeeDeleteDataSources(this.services);

//   @override
//   Future<Either<Failure, EmployeeEntities>> call({required EmployeeDeletePrams prams}) async {
//     throw UnimplementedError();

//     // var response = await services.postRequest(
//     //   endPoint: '/employee-delete',
//     //   queryParameters: prams.toJson()
//     // );

//     // return 
//     //   response.fold(
//     //     (err) => Left(Failure(message: err.message)),
//     //     (succ) {
//     //       if (succ.statusCode == 201){
//     //         return Right(EmployeeResponseModel.fromJson(succ.data));
//     //       } else {
//     //         return Left(Failure(message: 'Failed'));
//     //       }
//     //     }
//     //   );
//   }

// }


// // ------------------------------------
// //               Read                 -
// // ------------------------------------
// class EmployeeReadDataSources extends EmployeeDataSources<Either<Failure, List<EmployeeEntities>>, EmployeeReadPrams> {
//   final ApiServices services;
//   EmployeeReadDataSources(this.services);

//   @override
//   Future<Either<Failure, List<EmployeeEntities>>> call({required EmployeeReadPrams prams}) async {
//     throw UnimplementedError();

//     // var response = await services.postRequest(
//     //   endPoint: '/employee-read',
//     //   queryParameters: prams.toJson(),
//     //   body: prams.toJson(),
//     // );

//     // return 
//     //   response.fold(
//     //     (err) => Left(Failure(message: err.message)),
//     //     (succ) {
//     //       if (succ.statusCode == 200){
//     //         List<dynamic> data = succ.data;
//     //         List<EmployeeResponseModel> employees = data
//     //             .map((item) => EmployeeResponseModel.fromJson(item as Map<String, dynamic>))
//     //             .toList();
//     //         return Right(employees);
//     //       } else {
//     //         return Left(Failure(message: 'Failed'));
//     //       }
//     //     }
//     //   );
//   }

// }