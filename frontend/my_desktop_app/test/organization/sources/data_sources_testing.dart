// import 'package:my_desktop_app/core/failure/failure.dart';
// import 'package:my_desktop_app/core/services/api_services.dart';
// import 'package:my_desktop_app/features/auth/data/datasources/login/login_datasources_impl.dart';
// import 'package:my_desktop_app/features/auth/data/models/request/login_request_prams.dart';

// void main () async {
//   final object = LoginDatasourcesImpl(apiServices: ApiServices());
//   final data = LoginRequestPrams(email: 'syed12@gmail.com', password: '123457');
//   final response = await object.login(data);

//   response.fold(
//     (err){
//       if (err is ValidationFailure){
//         print(err.errors);
//         return;
//       }
//       print(err.message);
//     }, 
//     (succ) => print(succ));
// }