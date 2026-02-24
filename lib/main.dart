import 'package:flutter/material.dart';
import 'package:montebit/core/ui/theme.dart';
import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/splash/models/initial_route_model.dart';
import 'package:montebit/features/splash/usescases/get_initial_route_usecase.dart';
import 'package:montebit/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  final initialRoute = await sl<GetInitialRouteUsecase>().call();

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});

  final InitialRouteModel initialRoute;

  @override
  Widget build(BuildContext context) {
    final router = AppRouter(initialRoute).router;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: MontebitTheme.lightTheme,
    );
  }
}
