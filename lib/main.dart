import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:montebit/core/ui/theme.dart';
import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/splash/usescases/get_initial_route_usecase.dart';
import 'package:montebit/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  final initialRoute = await sl<GetInitialRouteUsecase>().call();
  final router = AppRouter(initialRoute).router;

  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: MontebitTheme.lightTheme,
    );
  }
}
