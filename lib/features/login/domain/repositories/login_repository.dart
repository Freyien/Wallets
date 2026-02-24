import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/features/login/domain/entities/login_entity.dart';
import 'package:montebit/features/login/domain/entities/login_response_entity.dart';

abstract class LoginRepository {
  Future<Response<LoginResponseEntity>> login(LoginEntity loginEntity);
}
