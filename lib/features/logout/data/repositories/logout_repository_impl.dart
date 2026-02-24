import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/logout/domain/repositories/logout_repository.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  final FlutterSecureStorage _secureStorage;

  LogoutRepositoryImpl(this._secureStorage);

  @override
  Future<Response<void>> logout() async {
    try {
      await _secureStorage.delete(key: 'token');
      return Response.success(null);
    } catch (e) {
      return Response.failed(UnexpectedFailure());
    }
  }
}
