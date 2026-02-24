import 'package:montebit/features/signup/domain/entities/signup_entity.dart';

abstract class SignupDatasource {
  Future<SignupEntity> signUp(SignupEntity signupEntity);
}
