
import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/profile/data/datasources/profile_datasource_impl.dart';
import 'package:montebit/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:montebit/features/profile/domain/datasources/profile_datasource.dart';
import 'package:montebit/features/profile/domain/repositories/profile_repository.dart';
import 'package:montebit/features/profile/ui/bloc/profile_bloc.dart';

class ProfileDi {
  static void initDependencies() {
    // Datasource
    sl.registerLazySingleton<ProfileDatasource>(
      () => ProfileDatasourceImpl(sl()),
    );

    // Repositories
    sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(sl()),
    );

    // Bloc
    sl.registerFactory<ProfileBloc>(() => ProfileBloc(sl()));
  }
}

