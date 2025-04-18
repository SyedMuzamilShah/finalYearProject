import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static final TokenService _instance = TokenService._internal();
  factory TokenService() => _instance;

  TokenService._internal();

  String? _token;
  SharedPreferences? _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs?.getString('token'); // Load token once initialized
  }

  String? get token => _token;

  Future<void> setToken(String token) async {
    await initialize();
    _token = token;
    await _prefs?.setString('token', token);
  }

  Future<void> removeToken() async {
    _token = null;
    await _prefs?.remove('token');
  }
}
