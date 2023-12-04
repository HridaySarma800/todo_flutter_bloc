part of 'home_cubit.dart';

/// Represents the different states of the home screen.
/// These classes extend the abstract class `HomeState` and provide
/// specific states such as initial loading, loaded tasks, empty task list,
/// and failed task loading.
abstract class HomeState extends Equatable {
  const HomeState();
}

/// Initial state when the home screen is first created.
class HomeInitial extends HomeState {
  final int random;

  const HomeInitial({required this.random});

  @override
  List<Object> get props => [];
}

/// State when tasks are successfully loaded onto the home screen.
class HomeTasksLoaded extends HomeState {
  final List<TaskModel> tasks;
  final int random;

  const HomeTasksLoaded({required this.tasks, required this.random});

  @override
  List<Object?> get props => [random];
}

/// State when there are no tasks to display on the home screen.
class HomeTaskEmpty extends HomeState {
  @override
  List<Object?> get props => [];
}

/// State when there is a failure in loading tasks on the home screen.
class HomeTaskLoadFailed extends HomeState {
  final String text;

  const HomeTaskLoadFailed(this.text);

  @override
  List<Object?> get props => [];
}
