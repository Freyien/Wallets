import 'package:dio/dio.dart' hide Response;
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/cards/domain/datasources/cards_datasource.dart';
import 'package:montebit/features/cards/domain/repositories/cards_repository.dart';

class CardsRepositoryImpl implements CardsRepository {
  final CardsDatasource _datasource;

  CardsRepositoryImpl(this._datasource);

  @override
  Future<Response<List<CardEntity>>> getCards() async {
    try {
      final result = await _datasource.getCards();

      return Response.success(result);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }

  @override
  Future<Response<void>> deleteCard(int cardId) async {
    try {
      await _datasource.deleteCard(cardId);
      return Response.voidSuccess();
    } on DioException catch (_) {
      return Response.failed(UnexpectedFailure());
    } catch (_) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
