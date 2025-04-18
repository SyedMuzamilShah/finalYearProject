// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:my_desktop_app/core/failure/failure.dart';
// import 'package:my_desktop_app/core/network/network_info.dart';
// import 'package:my_desktop_app/core/services/api_services.dart';
// import 'package:my_desktop_app/core/utils/local_storage.dart';
// import 'package:my_desktop_app/features/auth/data/datasources/auth_local_data_source.dart';
// import 'package:my_desktop_app/features/auth/data/datasources/login/login_datasources_impl.dart';
// import 'package:my_desktop_app/features/auth/data/models/request/login_request_prams.dart';
// import 'package:my_desktop_app/features/auth/data/repositories/login_repo_impl.dart';
// import 'package:my_desktop_app/features/auth/domain/usecases/login_usecase.dart';

// void main () {
//   WidgetsFlutterBinding.ensureInitialized();
//   test("Login usecase testing", () async {
//     final usecase = RegisterUseCaseImpl(
//       loginRepo: RegisterRepoImpl(
//       sources: RegisterDatasourcesImpl(apiServices: ApiServices()),
//       authLocalData: AuthLocalDataSourceImpl(LocalStorageImpl()),
//       networkInfo: NetworkInfoImpl(Connectivity())));

//       final data =
//         RegisterRequestPrams(email: 'syed12@gmail.com', password: '123457');
//       final response = await usecase.register(prams: data);

//       response.fold(
//         (err){
//           if (err is ValidationFailure){
//             print(err.errors);
//             print(err.message);
//             return;
//           }
//           print(err.message);
//         },
//         (succ) => print(succ.email),);
//   });
// }