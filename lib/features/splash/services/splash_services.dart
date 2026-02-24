import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashServices {
  SplashServices(this._storage);

  final FlutterSecureStorage _storage;

  Future<bool> isLogged() async {
    try {
      final hasToken = await _storage.read(key: 'token') != null;
      return hasToken;
    } catch (e) {
      return false;
    }
  }
}
