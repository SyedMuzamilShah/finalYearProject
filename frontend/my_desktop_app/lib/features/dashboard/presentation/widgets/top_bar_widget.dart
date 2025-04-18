import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_desktop_app/core/routes/routes.dart';
import 'package:my_desktop_app/core/widgets/loading_widget.dart';
import 'package:my_desktop_app/core/widgets/my_drawer.dart';
import 'package:my_desktop_app/features/auth/presentation/providers/basic_auth_provider.dart';
import 'package:my_desktop_app/features/dashboard/presentation/providers/user_profile_provider.dart';

class MyTopBarWidget extends ConsumerWidget {
  const MyTopBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfile = ref.watch(userDataProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        userProfile.when(
          data: (user) => Text.rich(
            TextSpan(
              text: "Hello! ",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.grey),
              children: [
                TextSpan(
                  text: user.userName,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                )
              ],
            ),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text(
            "Failed to load user",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.red),
          ),
        ),

        // Right Side
        Row(
          children: [
            userProfile.when(
              data: (user) => CircleAvatar(
                backgroundImage:
                    user.avatar != null ? NetworkImage(user.avatar!) : null,
                child: user.avatar == null ? const Icon(Icons.person) : null,
              ),
              loading: () =>
                  const CircleAvatar(child: CircularProgressIndicator()),
              error: (_, __) => const CircleAvatar(child: Icon(Icons.error)),
            ),
            const SizedBox(width: 10),

            // Dropdown Button
            PopupMenuButton<String>(
              // icon: const Icon(CupertinoIcons.square_arrow_down, size: 20),
              icon: ref.read(basicAuthProvider).isLoading
                  ? MyLoadingWidget()
                  : const Icon(CupertinoIcons.square_arrow_down, size: 20),
              onSelected: (value) async {
                if (value == 'Settings') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyDrawerWidget()));
                } else if (value == 'Logout') {
                  final response = await ref.read(basicAuthProvider.notifier).logout();
                  if (response || !response) {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text("User Logout Successfully"),
                          backgroundColor: Colors.red,
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    // ignore: use_build_context_synchronously
                    Navigator.popAndPushNamed(context, AppRoutes.login);
                  }
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                    value: "Profile",
                    child: Text(
                      "Profile",
                      style: Theme.of(context).textTheme.bodySmall,
                    )),
                PopupMenuItem(
                    value: "Settings",
                    child: Text(
                      "Settings",
                      style: Theme.of(context).textTheme.bodySmall,
                    )),
                PopupMenuItem(
                    value: "Logout",
                    child: Text(
                      "Logout",
                      style: Theme.of(context).textTheme.bodySmall,
                    )),
              ],
            ),
          ],
        )
      ],
    );
  }
}
