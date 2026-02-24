import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/core/domain/entities/response.dart';

abstract class CardsRepository {
  Future<Response<List<CardEntity>>> getCards();
  Future<Response<void>> deleteCard(int cardId);
}
