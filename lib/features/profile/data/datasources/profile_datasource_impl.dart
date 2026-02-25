import 'package:dio/dio.dart';
import 'package:montebit/features/profile/domain/datasources/profile_datasource.dart';
import 'package:montebit/features/profile/domain/entities/profile_entity.dart';

class ProfileDatasourceImpl implements ProfileDatasource {
  final Dio _client;

  ProfileDatasourceImpl(this._client);

  @override
  Future<ProfileEntity> getProfile() async {
    final response = await _client.get(
      '/profile',
    );

    return ProfileEntity.fromJson(
      Map<String, dynamic>.from(response.data['data']),
    );
  }
}
