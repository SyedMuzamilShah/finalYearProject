import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_desktop_app/features/auth/presentation/providers/basic_auth_provider.dart';


final splashControllerProvider = FutureProvider<bool>((ref) async {
  
  final auth = ref.watch(basicAuthProvider.notifier);
  var response = await auth.isLogin();
  return response.fold(
    (err) => false,
    (succ) => true);
});
