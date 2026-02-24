import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/signup/domain/datasources/signup_datasource.dart';
import 'package:montebit/features/signup/domain/entities/signup_entity.dart';
import 'package:montebit/features/signup/domain/repositories/signup_repository.dart';

class SignupRepositoryImpl implements SignupRepository {
  final SignupDatasource _datasource;

  SignupRepositoryImpl(this._datasource);

  @override
  Future<Response<SignupEntity>> signUp(SignupEntity signupEntity) async {
    try {
      final result = await _datasource.signUp(signupEntity);

      return Response.success(result);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
