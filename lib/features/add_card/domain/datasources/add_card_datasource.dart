import 'package:montebit/core/domain/entities/card_entity.dart';

abstract class AddCardDatasource {
  Future<CardEntity> saveCard(CardEntity card);
}
