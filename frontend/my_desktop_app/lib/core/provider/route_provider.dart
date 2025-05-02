// add the routing on main content
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routeDisplayProvider = StateProvider.autoDispose<RouteDisplayItem>((ref) => RouteDisplayItem()
);

// class hold the navigation routing
class RouteDisplayItem {
  final String? name;
  final Widget? route;
  
  RouteDisplayItem({this.name = 'Dashboard', this.route});
}