import 'package:hive/hive.dart';

import '../../../core/constants/app_keys.dart';
import '../models/user_profile_model.dart';
import 'profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl();

  Box<UserProfileModel> get _box => Hive.box<UserProfileModel>(AppKeys.userProfileBox);

  @override
  Future<UserProfileModel?> getCurrentUser() async {
    try {
      return _box.get(AppKeys.currentUser);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveUser(UserProfileModel user) async {
    await _box.put(AppKeys.currentUser, user);
  }

  @override
  Future<void> clearUser() async {
    await _box.delete(AppKeys.currentUser);
  }
}
