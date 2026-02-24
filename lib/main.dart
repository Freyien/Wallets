import 'package:flutter/material.dart';
import 'package:montebit/core/ui/theme.dart';
import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/router/router.dart';

void main() async {
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter().router;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: MontebitTheme.lightTheme,
    );
  }
}
