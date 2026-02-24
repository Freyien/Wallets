import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/features/cards/domain/entities/card_entity.dart';

abstract class CardsRepository {
  Future<Response<List<CardEntity>>> getCards();
}
