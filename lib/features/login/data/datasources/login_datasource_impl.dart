
import 'dart:convert';

import 'package:montebit/features/login/domain/datasources/login_datasource.dart';
import 'package:montebit/features/login/domain/entities/login_entity.dart';
import 'package:dio/dio.dart';

class LoginDatasourceImpl implements LoginDatasource {
  final Dio _client;

  LoginDatasourceImpl(this._client);

  @override
  Future<LoginEntity> getLogin() async {
    final data = json.encode({});

    final response = await _client.post(
      '',
      data: data,
    );

    return LoginEntity.initial();
  }
}
