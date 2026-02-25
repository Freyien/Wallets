import 'package:dio/dio.dart';
import 'package:montebit/features/signup/domain/datasources/signup_datasource.dart';
import 'package:montebit/features/signup/domain/entities/signup_entity.dart';
import 'package:montebit/features/signup/domain/entities/signup_response_entity.dart';
import 'package:montebit/features/signup/domain/failures/signup_failures.dart';

class SignupDatasourceImpl implements SignupDatasource {
  final Dio _client;

  SignupDatasourceImpl(this._client);

  @override
  Future<SignUpResponseEntity> signUp(SignupEntity signupEntity) async {
    try {
      final data = signupEntity.toJson();

      final response = await _client.post('/auth/register', data: data);

      final responseData = Map<String, dynamic>.from(response.data['data']);
      return SignUpResponseEntity.fromJson(responseData);
    } on DioException catch (e) {
      if (e.response?.statusCode == 412) {
        throw EmailOrPhoneAlreadyInUseFailure();
      }

      rethrow;
    } on Exception catch (e) {
      rethrow;
    }
  }
}
