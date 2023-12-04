import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/data/impl/datat_repo_impl.dart';
import 'package:todo/data/models/task_model.dart';
import 'package:todo/logic/home_cubit/home_cubit.dart';
import 'package:todo/presentation/resources/strings_manager.dart';

import 'task_cubit_test/task_test_cubit.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  // await Hive.initFlutter();
  var path = Directory.current.path;
  Hive.init('$path/test/hive_testing_path');

  Hive.registerAdapter<TaskModel>(TaskModelAdapter());
  if (!Hive.isBoxOpen(StringsManager.boxName)) {
    await Hive.openBox<TaskModel>(StringsManager.boxName);
  }

  group('HomeCubit', () {
    test('Initial state is HomeInitial', () {
      final HomeCubit homeCubit = HomeCubit();
      expect(homeCubit.state, isA<HomeInitial>());
    });

    test('loadAllTasks updates state to HomeTasksLoaded', () async {
      final homeCubit = HomeCubit();
      await homeCubit.loadAllTasks();
      expect(
          homeCubit.state, anyOf(isA<HomeTasksLoaded>(), isA<HomeTaskEmpty>()));
    });
  });
  group('TaskTestCubit', () {
    late TaskTestCubit taskTestCubit;

    setUp(() {
      taskTestCubit = TaskTestCubit();
    });

    tearDown(() {
      taskTestCubit.close();
    });

    blocTest<TaskTestCubit, TaskTestState>(
      'emits [TaskTestInitial, TaskAdded] when add is called successfully',
      build: () {
        // Initialize the dataRepoImpl mock or use a real implementation
        taskTestCubit.dataRepoImpl = DataRepoImpl();
        return taskTestCubit;
      },
      act: (cubit) => cubit.add(
          'Test Title', 'Test Subtitle', DateTime.now(), DateTime.now()),
      expect: () => [TaskTestAdded()],
    );

    blocTest<TaskTestCubit, TaskTestState>(
      'emits [TaskTestInitial, TaskUpdated] when update is called successfully',
      build: () {
        taskTestCubit.dataRepoImpl =
            DataRepoImpl(); // You may use a mock library for better testing
        return taskTestCubit;
      },
      act: (cubit) async {
        var task = TaskModel.create(
          title: 'Test Title',
          createdAtTime: DateTime.now(),
          createdAtDate: DateTime.now(),
          subtitle: 'Test Subtitle',
        );
        await taskTestCubit.dataRepoImpl.addTask(task: task);

        cubit.update('Updated Title', 'Updated Subtitle', task, DateTime.now(),
            DateTime.now());
      },
      expect: () => [ TaskTestUpdated()],
    );
    blocTest<TaskTestCubit, TaskTestState>(
      'emits [TaskTestInitial, TaskDeleted] when deleteTask is called successfully',
      build: () {
        // Initialize the dataRepoImpl mock or use a real implementation
        taskTestCubit.dataRepoImpl =
            DataRepoImpl(); // You may use a mock library for better testing
        return taskTestCubit;
      },
      act: (cubit) async {
        // Create a task and add it
        var task = TaskModel.create(
          title: 'Test Title',
          createdAtTime: DateTime.now(),
          createdAtDate: DateTime.now(),
          subtitle: 'Test Subtitle',
        );
        await cubit.dataRepoImpl.addTask(task: task);

        // Delete the task using the cubit
        cubit.deleteTask(task);
      },
      expect: () => [TaskTestDeleted()],
    );
  });
}
