
import 'package:montebit/features/login/domain/entities/login_entity.dart';

abstract class LoginDatasource {
  Future<LoginEntity> getLogin();
}
