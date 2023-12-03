part of 'time_cubit.dart';

abstract class TimeState extends Equatable {
  const TimeState();
}

class TimeInitial extends TimeState {
  final DateTime? time;
  final DateTime? date;
  final int random;

  const TimeInitial({
    required this.time,
    required this.date,
    required this.random,
  });

  @override
  List<Object> get props => [random];
}
