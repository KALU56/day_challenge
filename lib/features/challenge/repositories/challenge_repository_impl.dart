import 'package:hive/hive.dart';

import '../../../core/constants/app_keys.dart';
import '../models/challenge_model.dart';
import 'challenge_repository.dart';

class ChallengeRepositoryImpl implements ChallengeRepository {
  ChallengeRepositoryImpl();

  Box<ChallengeModel> get _box =>
      Hive.box<ChallengeModel>(AppKeys.challengesBox);

  @override
  Future<void> createChallenge(ChallengeModel model) async {
    await _box.put(model.id, model);
  }

  @override
  Future<void> deleteChallenge(String id) async {
    await _box.delete(id);
  }

  @override
  Future<List<ChallengeModel>> getAllChallenges() async {
    return _box.values.cast<ChallengeModel>().toList();
  }

  @override
  Future<ChallengeModel?> getById(String id) async {
    return _box.get(id);
  }

  @override
  Future<void> updateChallenge(ChallengeModel model) async {
    await _box.put(model.id, model);
  }
}
