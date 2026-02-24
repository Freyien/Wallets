import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/signup/domain/datasources/signup_datasource.dart';
import 'package:montebit/features/signup/domain/entities/signup_entity.dart';
import 'package:montebit/features/signup/domain/entities/signup_response_entity.dart';
import 'package:montebit/features/signup/domain/repositories/signup_repository.dart';

class SignupRepositoryImpl implements SignupRepository {
  final SignupDatasource _datasource;
  final FlutterSecureStorage _secureStorage;

  SignupRepositoryImpl(this._datasource, {FlutterSecureStorage? secureStorage})
    : _secureStorage = secureStorage ?? const FlutterSecureStorage();

  @override
  Future<Response<SignUpResponseEntity>> signUp(
    SignupEntity signupEntity,
  ) async {
    try {
      final result = await _datasource.signUp(signupEntity);

      await _secureStorage.write(key: 'token', value: result.token);

      return Response.success(result);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
