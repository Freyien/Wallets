import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:montebit/features/logout/data/repositories/logout_repository_impl.dart';
import 'package:montebit/features/logout/domain/repositories/logout_repository.dart';
import 'package:montebit/features/logout/ui/bloc/logout_bloc.dart';

class LogoutDi {
  static final sl = GetIt.instance;

  static void initDependencies() {
    sl.registerLazySingleton<LogoutRepository>(
      () => LogoutRepositoryImpl(sl<FlutterSecureStorage>()),
    );

    sl.registerFactory(() => LogoutBloc(sl()));
  }
}
