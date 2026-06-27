import '../models/challenge_model.dart';

abstract class ChallengeRepository {
  Future<List<ChallengeModel>> getAllChallenges();
  Future<ChallengeModel?> getById(String id);
  Future<void> createChallenge(ChallengeModel model);
  Future<void> updateChallenge(ChallengeModel model);
  Future<void> deleteChallenge(String id);
}
