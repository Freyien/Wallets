import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/add_card/data/datasources/add_card_datasource_impl.dart';
import 'package:montebit/features/add_card/data/repositories/add_card_repository_impl.dart';
import 'package:montebit/features/add_card/domain/datasources/add_card_datasource.dart';
import 'package:montebit/features/add_card/domain/repositories/add_card_repository.dart';
import 'package:montebit/features/add_card/ui/bloc/add_card_bloc.dart';

class AddCardDi {
  static void initDependencies() {
    // Datasource
    sl.registerLazySingleton<AddCardDatasource>(
      () => AddCardDatasourceImpl(sl()),
    );

    // Repositories
    sl.registerLazySingleton<AddCardRepository>(
      () => AddCardRepositoryImpl(sl()),
    );

    // Bloc
    sl.registerFactory<AddCardBloc>(() => AddCardBloc(sl()));
  }
}
