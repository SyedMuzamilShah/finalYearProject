import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_desktop_app/features/organization/presentation/providers/organization_provider.dart';
import 'package:sidebarx/sidebarx.dart';


final isOrganizationProvider = FutureProvider.autoDispose<bool>((ref) async {

  final org = ref.read(organizationProvider).selectedOrganization;
  if (org != null) {
    return true;
  }
  final response = await ref.read(organizationProvider.notifier).isOrganizationSaved();
  return response;
});

// Provider help to change the sidebar index through which we change the main content widget
final sideBarXControllerProvider = StateProvider(
    (ref) => SidebarXController(selectedIndex: 0, extended: true));


// class hold the value to animate the right side content
class SidebarState {
  final double scale;
  final double marginTop;
  final double borderRadius;

  SidebarState({
    required this.scale,
    required this.marginTop,
    required this.borderRadius,
  });
}

// help to change the value
final ValueNotifier<SidebarState> sidebarState = ValueNotifier(
  SidebarState(scale: 1.0, marginTop: 0.0, borderRadius: 0.0),
);




// final mainContentProvider = StateProvider.autoDispose<Widget>((ref) {
//   return MyDashBoradView();
// });

