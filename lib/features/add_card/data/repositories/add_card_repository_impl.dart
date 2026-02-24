import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/add_card/domain/datasources/add_card_datasource.dart';
import 'package:montebit/features/add_card/domain/repositories/add_card_repository.dart';

class AddCardRepositoryImpl implements AddCardRepository {
  final AddCardDatasource _datasource;

  AddCardRepositoryImpl(this._datasource);

  @override
  Future<Response<CardEntity>> saveCard() async {
    try {
      final result = await _datasource.saveCard();

      return Response.success(result);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
