import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/challenge_model.dart';
import '../repositories/challenge_repository.dart';
import '../repositories/challenge_repository_impl.dart';

final challengeRepositoryProvider = Provider<ChallengeRepository>((ref) {
  return ChallengeRepositoryImpl();
});

final challengeListProvider =
    StateNotifierProvider<
      ChallengeListNotifier,
      AsyncValue<List<ChallengeModel>>
    >((ref) {
      final repo = ref.watch(challengeRepositoryProvider);
      return ChallengeListNotifier(repo);
    });

class ChallengeListNotifier
    extends StateNotifier<AsyncValue<List<ChallengeModel>>> {
  ChallengeListNotifier(this._repo) : super(const AsyncValue.loading()) {
    _load();
  }

  final ChallengeRepository _repo;

  Future<void> _load() async {
    try {
      final items = await _repo.getAllChallenges();
      state = AsyncValue.data(items);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> refresh() async => _load();

  Future<void> create(ChallengeModel model) async {
    await _repo.createChallenge(model);
    await _load();
  }

  Future<void> update(ChallengeModel model) async {
    await _repo.updateChallenge(model);
    await _load();
  }

  Future<void> delete(String id) async {
    await _repo.deleteChallenge(id);
    await _load();
  }
}
