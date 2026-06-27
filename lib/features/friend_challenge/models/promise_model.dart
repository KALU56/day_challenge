import 'package:hive/hive.dart';

part 'promise_model.g.dart';

@HiveType(typeId: 3)
class PromiseModel extends HiveObject {
  @HiveField(0)
  final DateTime requestDate;

  @HiveField(1)
  final bool isAccepted;

  @HiveField(2)
  final bool firstTaskCompleted;

  @HiveField(3)
  final bool secondTaskCompleted;

  @HiveField(4)
  final DateTime dueDate;

  PromiseModel({
    required this.requestDate,
    required this.isAccepted,
    required this.firstTaskCompleted,
    required this.secondTaskCompleted,
    required this.dueDate,
  });

  PromiseModel copyWith({
    DateTime? requestDate,
    bool? isAccepted,
    bool? firstTaskCompleted,
    bool? secondTaskCompleted,
    DateTime? dueDate,
  }) {
    return PromiseModel(
      requestDate: requestDate ?? this.requestDate,
      isAccepted: isAccepted ?? this.isAccepted,
      firstTaskCompleted: firstTaskCompleted ?? this.firstTaskCompleted,
      secondTaskCompleted: secondTaskCompleted ?? this.secondTaskCompleted,
      dueDate: dueDate ?? this.dueDate,
    );
  }
}
