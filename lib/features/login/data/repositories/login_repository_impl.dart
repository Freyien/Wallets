
import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/login/domain/datasources/login_datasource.dart';
import 'package:montebit/features/login/domain/entities/login_entity.dart';
import 'package:montebit/features/login/domain/repositories/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDatasource _datasource;

  LoginRepositoryImpl(this._datasource);

  @override
  Future<Response<LoginEntity>> getLogin() async {
    try {
      final result = await _datasource.getLogin();

      return Response.success(result);
    } catch (e) {
     return Response.failed(UnexpectedFailure());
    }
  }
}

