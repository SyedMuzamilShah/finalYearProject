// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:my_desktop_app/core/failure/failure.dart';
// import 'package:my_desktop_app/core/network/network_info.dart';
// import 'package:my_desktop_app/core/services/api_services.dart';
// import 'package:my_desktop_app/core/services/token_service.dart';
// import 'package:my_desktop_app/core/utils/local_storage.dart';
// import 'package:my_desktop_app/features/auth/data/datasources/auth_local_data_source.dart';
// import 'package:my_desktop_app/features/auth/data/datasources/login/login_datasources_impl.dart';
// import 'package:my_desktop_app/features/auth/data/models/request/login_request_prams.dart';
// import 'package:my_desktop_app/features/auth/data/repositories/login_repo_impl.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final object = LoginRepoImpl(
//       sources: LoginDatasourcesImpl(apiServices: ApiServices()),
//       authLocalData: AuthLocalDataSourceImpl(LocalStorageImpl(), TokenService()),
//       networkInfo: NetworkInfoImpl(Connectivity()));

//   test('Login Repo Testing', () async {
//     final data =
//         LoginRequestPrams(email: 'syed12@gmail.com', password: '123456');
//     final response = await object.login(data);

//     response.fold((err) {
//       if (err is ValidationFailure) {
//         print(err.errors);
//         return;
//       }
//       print(err.message);
//     }, (succ) => expect(succ.email, data.email));
//   });
// }
