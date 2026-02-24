import 'package:dio/dio.dart';
import 'package:montebit/features/cards/domain/datasources/cards_datasource.dart';
import 'package:montebit/features/cards/domain/entities/card_entity.dart';

class CardsDatasourceImpl implements CardsDatasource {
  final Dio _client;

  CardsDatasourceImpl(this._client);

  @override
  Future<List<CardEntity>> getCards() async {
    final response = await _client.get('/cards');

    final data = response.data as List;
    return data
        .map((e) => CardEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
