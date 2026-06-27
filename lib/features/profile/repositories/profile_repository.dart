import '../../profile/models/user_profile_model.dart';

abstract class ProfileRepository {
  Future<UserProfileModel?> getCurrentUser();

  Future<void> saveUser(UserProfileModel user);

  Future<void> clearUser();
}
