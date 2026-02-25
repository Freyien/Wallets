
import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/core/domain/failures/failure.dart';
import 'package:montebit/features/profile/domain/datasources/profile_datasource.dart';
import 'package:montebit/features/profile/domain/entities/profile_entity.dart';
import 'package:montebit/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatasource _datasource;

  ProfileRepositoryImpl(this._datasource);

  @override
  Future<Response<ProfileEntity>> getProfile() async {
    try {
      final result = await _datasource.getProfile();

      return Response.success(result);
    } catch (e) {
     return Response.failed(UnexpectedFailure());
    }
  }
}

