import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/home';
  static const String register = '/register';
  static const String forgot = '/forgot';
  static const String changePassword = '/change-password';



 static Route<Widget> onGenerateRoute(RouteSettings settings) {
   switch (settings.name) {
     case splash:
       return MaterialPageRoute(builder: (_) => Container());
     case login:
       return MaterialPageRoute(builder: (_) => Container());
     case register:
       return MaterialPageRoute(builder: (_) => Container());
     case forgot:
       return MaterialPageRoute(builder: (_) => Container());
     case changePassword:
       return MaterialPageRoute(builder: (_) => Container());
     default:
       return MaterialPageRoute(builder: (_) => Container());
   }
 } 
}