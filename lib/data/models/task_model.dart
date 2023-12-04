import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

/// Hive data model for representing a task.
/// This class is annotated with HiveType and includes HiveField annotations
/// for each field to specify the serialization and deserialization indices.

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  TaskModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.createdAtTime,
    required this.createdAtDate,
    required this.isCompleted,
  });

  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String subtitle;

  @HiveField(3)
  DateTime createdAtTime;

  @HiveField(4)
  DateTime createdAtDate;

  @HiveField(5)
  bool isCompleted;

  /// Factory method to create a new TaskModel with default values.
  factory TaskModel.create({
    required String? title,
    required String? subtitle,
    DateTime? createdAtTime,
    DateTime? createdAtDate,
  }) =>
      TaskModel(
        id: const Uuid().v1(),
        title: title ?? "",
        subtitle: subtitle ?? "",
        createdAtTime: createdAtTime ?? DateTime.now(),
        isCompleted: false,
        createdAtDate: createdAtDate ?? DateTime.now(),
      );
}
