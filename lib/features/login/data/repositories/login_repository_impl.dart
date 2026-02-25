import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/login/domain/datasources/login_datasource.dart';
import 'package:montebit/features/login/domain/entities/login_entity.dart';
import 'package:montebit/features/login/domain/entities/login_response_entity.dart';
import 'package:montebit/features/login/domain/exceptions/login_exceptions.dart';
import 'package:montebit/features/login/domain/failures/login_failures.dart';
import 'package:montebit/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDatasource _datasource;
  final FlutterSecureStorage _secureStorage;

  LoginRepositoryImpl(this._datasource, this._secureStorage);

  @override
  Future<Response<LoginResponseEntity>> login(LoginEntity loginEntity) async {
    try {
      final result = await _datasource.login(loginEntity);

      await _secureStorage.write(key: 'token', value: result.token);

      return Response.success(result);
    } on InvalidCredentialsException catch (_) {
      return Response.failed(InvalidCredentialsFailure());
    } on UserLockedException catch (_) {
      return Response.failed(UserLockedFailure());
    } on MaxAttemptsExceededException catch (_) {
      return Response.failed(MaxAttemptsExceededFailure());
    } catch (_) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
