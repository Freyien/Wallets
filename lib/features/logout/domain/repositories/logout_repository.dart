import 'package:montebit/core/domain/entities/response.dart';

abstract class LogoutRepository {
  Future<Response<void>> logout();
}
