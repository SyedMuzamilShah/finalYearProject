import 'package:my_desktop_app/core/services/local_database_service.dart';
import 'package:my_desktop_app/core/services/token_service.dart';

class LocalDatabaseTesting {
  LocalDatabaseService localDb = LocalDatabaseService();
  TokenService tkService = TokenService();
  
  getDataBaas () {
    return localDb.getUser();
  }

  getValueOfToken () {
    return {
      'token' : tkService.token,
      'organization' : tkService.organization 
    };
  }
}