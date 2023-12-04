part of 'time_cubit.dart';

/// Abstract class representing the various states for the TimeCubit.
/// Every state class that extends TimeState should implement the Equatable mixin
/// to allow for easy state comparison.

abstract class TimeState extends Equatable {
  const TimeState();
}

/// Initial state for the TimeCubit.
/// The `TimeInitial` state includes information about the current time, date,
/// and a random value for refreshing the UI. It extends the `TimeState` class
/// and overrides the `props` method to define the properties considered for
/// state comparison.
class TimeInitial extends TimeState {
  final DateTime? time;
  final DateTime? date;
  final int random;

  const TimeInitial({
    required this.time,
    required this.date,
    required this.random,
  });

  /// Override the props method to define the properties considered for
  /// state comparison. In this case, it includes only the `random` value.

  @override
  List<Object> get props => [random];
}
