import 'package:get_it/get_it.dart';
// import 'package:my_desktop_app/core/services/api_services.dart';
// import 'package:my_desktop_app/core/usecases/usecases.dart';
// import 'package:my_desktop_app/features/employee/data/datasources/employee_datasources.dart';
// import 'package:my_desktop_app/features/employee/data/repositories/employee_repo_impl.dart';
// import 'package:my_desktop_app/features/employee/domain/repositories/employee_repo.dart';
// import 'package:my_desktop_app/features/employee/domain/usecases/employee_usecase.dart';

final getIt = GetIt.instance;


registerDi(){
  // getIt.registerLazySingleton<ApiServices>(() => ApiServices());
  
  // getIt.registerLazySingleton<EmployeeDataSources>(() => EmployeeCreateDataSources(getIt<ApiServices>()));
  // // getIt.registerLazySingleton<EmployeeDataSources>(() => EmployeeUpdateDataSources(getIt<ApiServices>()));
  // // getIt.registerLazySingleton<EmployeeDataSources>(() => EmployeeDeleteDataSources(getIt<ApiServices>()));
  // // getIt.registerLazySingleton<EmployeeDataSources>(() => EmployeeReadDataSources(getIt<ApiServices>()));


  // getIt.registerLazySingleton<EmployeeCreateRepositories>(() => EmployeeCreateRepoImpl(getIt<EmployeeCreateDataSources>()));
  

  // getIt.registerLazySingleton<UseCaseAbstract>(() => EmployeeCreateUsecase(getIt<EmployeeCreateRepositories>()));
}