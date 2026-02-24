
import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/login/data/datasources/login_datasource_impl.dart';
import 'package:montebit/features/login/data/repositories/login_repository_impl.dart';
import 'package:montebit/features/login/domain/datasources/login_datasource.dart';
import 'package:montebit/features/login/domain/repositories/login_repository.dart';
import 'package:montebit/features/login/ui/bloc/login_bloc.dart';

class LoginDi {
  static void initDependencies() {
    // Datasource
    sl.registerLazySingleton<LoginDatasource>(
      () => LoginDatasourceImpl(sl()),
    );

    // Repositories
    sl.registerLazySingleton<LoginRepository>(
      () => LoginRepositoryImpl(sl()),
    );

    // Bloc
    sl.registerFactory<LoginBloc>(() => LoginBloc(sl()));
  }
}

