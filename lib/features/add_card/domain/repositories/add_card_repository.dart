import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/core/domain/entities/response.dart';

abstract class AddCardRepository {
  Future<Response<CardEntity>> saveCard(CardEntity card);
}
