import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:montebit/features/login/di/login_di.dart';
import 'package:montebit/features/signup/di/signup_di.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final secureStorage = FlutterSecureStorage();

  sl.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);

  final Dio dio = Dio();
  dio.options.baseUrl = 'https://api-cards-g971.onrender.com';
  dio.options.headers['Content-Type'] = 'application/json';

  sl.registerLazySingleton<Dio>(() => dio);

  SignupDi.initDependencies();
  LoginDi.initDependencies();
}
