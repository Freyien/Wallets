import 'package:montebit/di/injection_modules.dart';
import 'package:montebit/features/cards/data/datasources/cards_datasource_impl.dart';
import 'package:montebit/features/cards/data/repositories/cards_repository_impl.dart';
import 'package:montebit/features/cards/domain/datasources/cards_datasource.dart';
import 'package:montebit/features/cards/domain/repositories/cards_repository.dart';
import 'package:montebit/features/cards/ui/bloc/cards_bloc.dart';

class CardsDi {
  static void initDependencies() {
    // Datasource
    sl.registerLazySingleton<CardsDatasource>(() => CardsDatasourceImpl(sl()));

    // Repositories
    sl.registerLazySingleton<CardsRepository>(() => CardsRepositoryImpl(sl()));

    // Bloc
    sl.registerFactory<CardsBloc>(() => CardsBloc(sl()));
  }
}
