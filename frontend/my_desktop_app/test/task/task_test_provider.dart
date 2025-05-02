import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_desktop_app/core/services/local_database_service.dart';

import '../local_database_testing.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalDatabaseTesting lDb = LocalDatabaseTesting();

  await Hive.initFlutter();
  await LocalDatabaseService().init();
  var response = lDb.getDataBaas();


  print("Testing the UI $response");
}