import 'package:dio/dio.dart';
import 'package:montebit/features/login/domain/datasources/login_datasource.dart';
import 'package:montebit/features/login/domain/entities/login_entity.dart';
import 'package:montebit/features/login/domain/entities/login_response_entity.dart';

class LoginDatasourceImpl implements LoginDatasource {
  final Dio _client;

  LoginDatasourceImpl(this._client);

  @override
  Future<LoginResponseEntity> login(LoginEntity loginEntity) async {
    final response = await _client.post(
      '/auth/login',
      data: loginEntity.toJson(),
    );

    return LoginResponseEntity.fromJson(response.data);
  }
}
