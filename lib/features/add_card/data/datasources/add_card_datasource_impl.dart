import 'package:dio/dio.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/features/add_card/domain/datasources/add_card_datasource.dart';

class AddCardDatasourceImpl implements AddCardDatasource {
  final Dio _client;

  AddCardDatasourceImpl(this._client);

  @override
  Future<CardEntity> saveCard(CardEntity card) async {
    final data = card.toJson();

    await _client.post('/cards', data: data);

    return CardEntity.initial();
  }
}
