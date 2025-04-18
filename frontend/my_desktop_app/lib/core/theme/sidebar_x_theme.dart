import 'package:sidebarx/sidebarx.dart';
import 'package:flutter/material.dart';

final mySidebarXExtendedTheme = SidebarXTheme(
          width: 200,
          decoration: BoxDecoration(
            color: canvasColor,
          ),
);


final mySidebarXTheme = SidebarXTheme(
  margin: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: canvasColor,
    borderRadius: BorderRadius.circular(20),
  ),
  hoverColor: scaffoldBackgroundColor,
  textStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
  selectedTextStyle: const TextStyle(color: Colors.white),
  hoverTextStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w500,
  ),
  itemTextPadding: const EdgeInsets.only(left: 30),
  selectedItemTextPadding: const EdgeInsets.only(left: 30),
  itemDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: canvasColor),
  ),
  selectedItemDecoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: actionColor.withValues(alpha: 0.37),
    ),
    gradient: const LinearGradient(
      colors: [accentCanvasColor, canvasColor],
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.28),
        blurRadius: 30,
      )
    ],
  ),
  iconTheme: IconThemeData(
    color: Colors.white.withValues(alpha: 0.7),
    size: 20,
  ),
  selectedIconTheme: const IconThemeData(
    color: Colors.white,
    size: 20,
  ),
);


const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withValues(alpha: 0.6);
final divider = Divider(color: white.withValues(alpha: 0.3), height: 1);