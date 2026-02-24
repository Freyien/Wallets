
import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/features/login/domain/entities/login_entity.dart';

abstract class LoginRepository {  
  Future<Response<LoginEntity>> getLogin();
}
