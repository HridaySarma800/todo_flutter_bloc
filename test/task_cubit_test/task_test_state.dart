part of 'task_test_cubit.dart';

abstract class TaskTestState extends Equatable {
  const TaskTestState();
}

class TaskTestInitial extends TaskTestState {
  @override
  List<Object> get props => [];
}

class TaskTestAdded extends TaskTestState {
  @override
  List<Object?> get props => [];
}

class TaskTestUpdated extends TaskTestState{
  @override
  List<Object?> get props => [];
}

class TaskTestDeleted extends TaskTestState{
  @override
  List<Object?> get props => [];

}

class TaskTestFailed extends TaskTestState{
  @override
  List<Object?> get props => [];

}
