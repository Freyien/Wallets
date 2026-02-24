import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/splash/services/splash_services.dart';
import 'package:montebit/features/splash/usescases/get_initial_route_usecase.dart';

class SplashDi {
  static void initDependencies() {
    sl.registerLazySingleton<SplashServices>(() => SplashServices(sl()));

    sl.registerFactory<GetInitialRouteUsecase>(
      () => GetInitialRouteUsecase(sl()),
    );
  }
}
