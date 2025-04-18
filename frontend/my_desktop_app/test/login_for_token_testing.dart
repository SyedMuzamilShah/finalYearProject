import 'package:my_desktop_app/features/auth/data/models/request/login_params.dart';
import 'package:my_desktop_app/features/auth/presentation/providers/basic_auth_provider.dart';

class LoginForTokenSaving {
  BasicAuthProviderNotifier notifier =BasicAuthProviderNotifier();

  login() async {
    final loginParama = LoginParams(email: 'syed@gmail.com', password: '123456');
    await notifier.login(loginParama);
  }
}