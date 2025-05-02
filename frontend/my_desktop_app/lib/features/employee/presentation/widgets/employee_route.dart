import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_desktop_app/core/provider/main_content_provider.dart';
import 'package:my_desktop_app/core/provider/route_provider.dart';
import 'package:my_desktop_app/features/employee/presentation/views/employee_view.dart';
class EmployeeRoute extends ConsumerWidget {
  final String? name;
  const EmployeeRoute({super.key, this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    TextStyle? routeStyle;
    
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Employee',
            style: routeStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {

                // TODO: if you want to show the oganizationView then clear the saved organization
                // from local data base
                // notifier.clearAll();
                // notifier.read();
                ref.read(routeDisplayProvider.notifier).state = RouteDisplayItem(
                    route: Text(
                  'employee',
                  style: routeStyle,
                ));
                mainContentWidget.value = MyEmployeeView();
                return;
              },
          ),
          TextSpan(
            text: ' / ',
            style: routeStyle,
          ),
          TextSpan(
            // text: name ?? state.selectedOrganization?.name ?? 'orgNull', // Organization name
            text: name,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(decoration: TextDecoration.underline),
            // recognizer: TapGestureRecognizer()
            //   ..onTap = () {},
          ),
        ],
      ),
    );
  }
}
