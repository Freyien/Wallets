import 'package:dio/dio.dart';
import 'package:montebit/features/signup/domain/datasources/signup_datasource.dart';
import 'package:montebit/features/signup/domain/entities/signup_entity.dart';

class SignupDatasourceImpl implements SignupDatasource {
  final Dio _client;

  SignupDatasourceImpl(this._client);

  @override
  Future<SignupEntity> signUp(SignupEntity signupEntity) async {
    final data = signupEntity.toJson();

    final response = await _client.post('/auth/register', data: data);

    return SignupEntity.initial();
  }
}
