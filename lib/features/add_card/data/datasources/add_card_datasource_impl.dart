import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:montebit/core/domain/entities/card_entity.dart';
import 'package:montebit/features/add_card/domain/datasources/add_card_datasource.dart';

class AddCardDatasourceImpl implements AddCardDatasource {
  final Dio _client;

  AddCardDatasourceImpl(this._client);

  @override
  Future<CardEntity> saveCard() async {
    final data = json.encode({});

    final response = await _client.post('', data: data);

    return CardEntity.initial();
  }
}
