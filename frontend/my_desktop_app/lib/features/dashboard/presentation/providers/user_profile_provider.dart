import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_desktop_app/features/auth/domain/entities/user_entities.dart';
import 'package:my_desktop_app/features/auth/presentation/providers/basic_auth_provider.dart';


// feach the user info from local first if not then feach from server
final userDataProvider = FutureProvider.autoDispose<UserEntities>((ref) async {
  final response = await ref.read(basicAuthProvider.notifier).getUser();
  return response.fold(
    (err) => throw Exception(err.message), 
    (succ) => succ);
});