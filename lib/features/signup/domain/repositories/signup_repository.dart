import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/features/signup/domain/entities/signup_entity.dart';
import 'package:montebit/features/signup/domain/entities/signup_response_entity.dart';

abstract class SignupRepository {
  Future<Response<SignUpResponseEntity>> signUp(SignupEntity signupEntity);
}
