import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:montebit/di/injection_modules.dart';

class DioDi {
  static void initDependencies() {
    final dio = Dio();
    dio.options.baseUrl = 'https://api-cards-g971.onrender.com';
    dio.options.headers['Content-Type'] = 'application/json';

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final secureStorage = sl<FlutterSecureStorage>();
          final token = await secureStorage.read(key: 'token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );

    sl.registerLazySingleton<Dio>(() => dio);
  }
}
