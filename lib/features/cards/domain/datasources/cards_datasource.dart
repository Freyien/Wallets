import 'package:montebit/core/domain/entities/card_entity.dart';

abstract class CardsDatasource {
  Future<List<CardEntity>> getCards();
  Future<void> deleteCard(String cardId);
}
