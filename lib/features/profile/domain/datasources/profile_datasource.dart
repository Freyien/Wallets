
import 'package:montebit/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileDatasource {
  Future<ProfileEntity> getProfile();
}
