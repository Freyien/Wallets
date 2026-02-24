import 'package:montebit/features/login/domain/entities/login_entity.dart';
import 'package:montebit/features/login/domain/entities/login_response_entity.dart';

abstract class LoginDatasource {
  Future<LoginResponseEntity> login(LoginEntity loginEntity);
}
