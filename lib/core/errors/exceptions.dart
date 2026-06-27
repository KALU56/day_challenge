class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);

  @override
  String toString() => 'DatabaseException: $message';
}

class NotificationException implements Exception {
  final String message;
  NotificationException(this.message);

  @override
  String toString() => 'NotificationException: $message';
}

class BusinessRuleException implements Exception {
  final String message;
  BusinessRuleException(this.message);

  @override
  String toString() => 'BusinessRuleException: $message';
}
