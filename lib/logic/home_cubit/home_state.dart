part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  final int random;

  const HomeInitial({required this.random});

  @override
  List<Object> get props => [];
}

class HomeTasksLoaded extends HomeState {
  final List<TaskModel> tasks;
  final int random;

  const HomeTasksLoaded({required this.tasks, required this.random});

  @override
  List<Object?> get props => [random];
}

class HomeTaskEmpty extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeTaskLoadFailed extends HomeState {
  final String text;

  const HomeTaskLoadFailed(this.text);

  @override
  List<Object?> get props => [];
}
