
import 'package:montebit/core/domain/entities/response.dart';
import 'package:montebit/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {  
  Future<Response<ProfileEntity>> getProfile();
}
