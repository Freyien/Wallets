
import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/signup/data/datasources/signup_datasource_impl.dart';
import 'package:montebit/features/signup/data/repositories/signup_repository_impl.dart';
import 'package:montebit/features/signup/domain/datasources/signup_datasource.dart';
import 'package:montebit/features/signup/domain/repositories/signup_repository.dart';
import 'package:montebit/features/signup/ui/bloc/signup_bloc.dart';

class SignupDi {
  static void initDependencies() {
    // Datasource
    sl.registerLazySingleton<SignupDatasource>(
      () => SignupDatasourceImpl(sl()),
    );

    // Repositories
    sl.registerLazySingleton<SignupRepository>(
      () => SignupRepositoryImpl(sl()),
    );

    // Bloc
    sl.registerFactory<SignupBloc>(() => SignupBloc(sl()));
  }
}

