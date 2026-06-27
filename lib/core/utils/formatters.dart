class Formatters {
  Formatters._();

  static String formatCoinAmount(int coins) {
    if (coins >= 1000000) {
      return '${(coins / 1000000).toStringAsFixed(1)}M';
    } else if (coins >= 1000) {
      return '${(coins / 1000).toStringAsFixed(1)}K';
    }
    return coins.toString();
  }

  static String formatDuration(int days) {
    return '$days ${days == 1 ? 'day' : 'days'}';
  }
}
