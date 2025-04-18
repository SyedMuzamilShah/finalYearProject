// String _ip = '192.168.1.126:3000';



class ServerUrl {
  static const String _ip = 'localhost';
  static const String baseUrl = 'http://$_ip:3000/api/v1';

  
  static const String userRegisterRoute = '$baseUrl/admin/auth/register';
  static const String userLoginRoute = '$baseUrl/admin/auth/login';
  static const String userLogoutRoute = '$baseUrl/admin/auth/logout';
  static const String userRefreshToken = '$baseUrl/admin/auth/token';
  static const String userForgotRoute = '';
  static const String userChangePasswordRoute = '';
  static const String userGetProfileRoute = '';
 
  
  static const String employeeCreateRoute = '$baseUrl/combine/add/employee';
  static const String employeeGetRoute = '$baseUrl/combine/get/employee';
  static const String employeeStatusChangeRoute = '$baseUrl/combine/employee/status-change';
  static const String employeeLoginRoute = '$baseUrl/admin/auth/login';
  static const String employeeLogoutRoute = '$baseUrl/admin/auth/logout';
  static const String employeeRefreshToken = '$baseUrl/admin/auth/token';




  static const String userGetOrganization = '$baseUrl/admin/organization/get';
  static const String userCreateOrganization = '$baseUrl/admin/organization/register';
  static const String userUpdateOrganization = '$baseUrl/admin/organization/get';
  static const String userDeleteOrganization = '$baseUrl/admin/organization/delete';

  static const String taskRead = '$baseUrl/admin/organization/task/read';
  static const String taskAssign = '$baseUrl/admin/organization/task/assign';
  static const String taskStatusChange = '$baseUrl/admin/organization/task/status-change';
  static const String taskVerified = '$baseUrl/admin/organization/task/verified';
  static const String taskDeassign = '$baseUrl/admin/organization/task/deassign';
  static const String taskCreate = '$baseUrl/admin/organization/task/create';
  static const String taskUpdate = '$baseUrl/admin/organization/get';
  static const String taskDelete = '$baseUrl/admin/organization/delete';
}