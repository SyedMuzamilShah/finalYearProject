import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_desktop_app/core/provider/main_content_provider.dart';
import 'package:my_desktop_app/core/provider/route_provider.dart';
import 'package:my_desktop_app/features/organization/presentation/providers/organization_provider.dart';
import 'package:my_desktop_app/features/organization/presentation/views/organization_view.dart';

class OrganizationRoute extends ConsumerWidget {
  final String? name;
  const OrganizationRoute({super.key, this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(organizationProvider);
    // final notifier = ref.watch(organizationProvider.notifier);
    TextStyle? routeStyle;
    if (state.selectedOrganization != null) {
      routeStyle = Theme.of(context).textTheme.bodySmall;
    }
    
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'organization', // Organization
            style: routeStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {

                // TODO: if you want to show the oganizationView then clear the saved organization
                // from local data base
                // notifier.clearAll();
                // notifier.read();
                ref.read(routeDisplayProvider.notifier).state = RouteDisplayItem(
                    route: Text(
                  'organization',
                  style: routeStyle,
                ));
                mainContentWidget.value = OrganizationView();
                return;
              },
          ),
          TextSpan(
            text: ' / ',
            style: routeStyle,
          ),
          TextSpan(
            text: name ?? state.selectedOrganization?.name ?? 'orgNull', // Organization name
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
