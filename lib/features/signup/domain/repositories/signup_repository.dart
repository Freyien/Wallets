import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/features/signup/domain/entities/signup_entity.dart';

abstract class SignupRepository {
  Future<Response<SignupEntity>> signUp(SignupEntity signupEntity);
}
