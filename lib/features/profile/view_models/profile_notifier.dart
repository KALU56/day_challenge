import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_profile_model.dart';
import '../repositories/profile_repository.dart';
import '../repositories/profile_repository_impl.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl();
});

final profileNotifierProvider = StateNotifierProvider<ProfileNotifier, AsyncValue<UserProfileModel?>>((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return ProfileNotifier(repo);
});

class ProfileNotifier extends StateNotifier<AsyncValue<UserProfileModel?>> {
  ProfileNotifier(this._repo) : super(const AsyncValue.loading()) {
    _load();
  }

  final ProfileRepository _repo;

  Future<void> _load() async {
    try {
      final user = await _repo.getCurrentUser();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> save(UserProfileModel user) async {
    state = const AsyncValue.loading();
    await _repo.saveUser(user);
    state = AsyncValue.data(user);
  }

  Future<void> clear() async {
    await _repo.clearUser();
    state = const AsyncValue.data(null);
  }
}
