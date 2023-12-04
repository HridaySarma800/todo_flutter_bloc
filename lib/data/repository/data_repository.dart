import 'package:todo/data/models/task_model.dart';

/// An abstract class representing a data repository for managing tasks.
/// This defines methods for adding, getting, updating, and deleting tasks, as well
/// as listing all tasks. Implementations of this class will provide the actual
/// functionality for interacting with the underlying data storage.

abstract class DataRepository {
  /// Adds a new task to the repository.
  Future<void> addTask({required TaskModel task});

  /// Retrieves a task with the specified ID from the repository.
  /// Returns null if the task is not found.
  Future<TaskModel?> getTask({required String id});

  /// Updates an existing task in the repository.
  Future<void> updateTask({required TaskModel task});

  /// Deletes a task from the repository.
  Future<void> deleteTask({required TaskModel task});

  /// Retrieves a list of all tasks stored in the repository.
  Future<List<TaskModel>> listAllTasks();
}
