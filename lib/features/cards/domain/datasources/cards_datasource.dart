import 'package:montebit/features/cards/domain/entities/card_entity.dart';

abstract class CardsDatasource {
  Future<List<CardEntity>> getCards();
}
