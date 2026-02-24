import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:montebit/di/dio_di.dart';
import 'package:montebit/features/add_card/di/add_card_di.dart';
import 'package:montebit/features/cards/di/cards_di.dart';
import 'package:montebit/features/login/di/login_di.dart';
import 'package:montebit/features/logout/di/logout_di.dart';
import 'package:montebit/features/signup/di/signup_di.dart';
import 'package:montebit/features/splash/di/splash_di.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  final secureStorage = const FlutterSecureStorage();

  sl.registerLazySingleton<FlutterSecureStorage>(() => secureStorage);

  DioDi.initDependencies();

  SplashDi.initDependencies();
  SignupDi.initDependencies();
  LoginDi.initDependencies();
  CardsDi.initDependencies();
  AddCardDi.initDependencies();
  LogoutDi.initDependencies();
}
