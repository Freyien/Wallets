import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/login/ui/login_page.dart';
import 'package:montebit/router/router.dart';

class DioDi {
  static void initDependencies() {
    final dio = Dio();
    dio.options.baseUrl = 'https://montebit-be-production-163b.up.railway.app';
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
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            final secureStorage = sl<FlutterSecureStorage>();
            await secureStorage.delete(key: 'token');

            if (navigatorKey.currentContext != null) {
              navigatorKey.currentContext!.go(LoginPage.route);
            }
          }
          handler.next(e);
        },
      ),
    );

    sl.registerLazySingleton<Dio>(() => dio);
  }
}
