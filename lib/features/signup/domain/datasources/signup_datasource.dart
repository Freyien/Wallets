import 'package:montebit/features/signup/domain/entities/signup_entity.dart';
import 'package:montebit/features/signup/domain/entities/signup_response_entity.dart';

abstract class SignupDatasource {
  Future<SignUpResponseEntity> signUp(SignupEntity signupEntity);
}
