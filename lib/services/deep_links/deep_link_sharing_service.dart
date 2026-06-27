import 'package:share_plus/share_plus.dart';

class DeepLinkSharingService {
  static const String appScheme = 'daychallenge://';

  Future<void> shareChallengeInvite({
    required String challengeId,
    required String challengerName,
    required String challengeTitle,
  }) async {
    final deepLink = '${appScheme}invite?id=$challengeId&by=$challengerName&title=${Uri.encodeComponent(challengeTitle)}';
    final shareMessage = 'Join my DayChallenge: "$challengeTitle"! Open this link in the app: $deepLink';
    await Share.share(shareMessage);
  }

  Future<void> sharePromiseRequest({
    required String challengeId,
    required String senderName,
    required int coins,
  }) async {
    final deepLink = '${appScheme}promise?id=$challengeId&from=$senderName&coins=$coins';
    final shareMessage = 'I missed a day! Please accept my Promise request to protect my streak. Click here: $deepLink';
    await Share.share(shareMessage);
  }

  Future<void> shareFreezeGift({
    required String challengeId,
    required String senderName,
  }) async {
    final deepLink = '${appScheme}freeze?id=$challengeId&from=$senderName';
    final shareMessage = 'I sent you a Streak Freeze! Click here to protect your streak today: $deepLink';
    await Share.share(shareMessage);
  }
}
