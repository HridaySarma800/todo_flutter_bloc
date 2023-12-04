import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'time_state.dart';

/// Cubit responsible for managing the state of time-related information.
/// The `TimeCubit` extends the `Cubit` class and provides methods for updating,
/// and formatting time and date.
class TimeCubit extends Cubit<TimeState> {
  TimeCubit()
      : super(TimeInitial(
            time: null, date: null, random: Random().nextInt(999999)));

  /// Updates the state with the provided time and date values.
  /// The `update` method is used to modify the current state of the cubit.
  /// It takes two optional parameters - `time` and `date`, both of type DateTime.
  /// When called, it emits a new `TimeInitial` state with the updated time, date,
  /// and a random value for refreshing the UI.
  update(
    DateTime? time,
    DateTime? date,
  ) {
    emit(TimeInitial(time: time, date: date, random: Random().nextInt(999999)));
  }

  /// Formats the provided time as a string in the 'hh:mm a' format.
  /// The `showTime` method takes a DateTime object `time` as a parameter
  /// and returns a formatted string representing the time in hours and minutes.
  String showTime(DateTime? time) {
    if (time == null) {
      return DateFormat('hh:mm a').format(DateTime.now()).toString();
    } else {
      return DateFormat('hh:mm a').format(time).toString();
    }
  }

  /// Returns the provided time as a DateTime object.
  /// The `showTimeAsDateTime` method takes a DateTime object `time` as a parameter
  /// and returns the same object if it is not null. If `time` is null, it returns
  /// the current DateTime.
  DateTime showTimeAsDateTime(DateTime? time) {
    if (time == null) {
      return DateTime.now();
    } else {
      return time;
    }
  }

  /// Formats the provided date as a string in the 'yMMMEd' format.
  /// The `showDate` method takes a DateTime object `date` as a parameter
  /// and returns a formatted string representing the date in a specific format.
  String showDate(DateTime? date) {
    if (date == null) {
      return DateFormat.yMMMEd().format(DateTime.now()).toString();
    } else {
      return DateFormat.yMMMEd().format(date).toString();
    }
  }


  /// Returns the provided date as a DateTime object.
  /// The `showDateAsDateTime` method takes a DateTime object `date` as a parameter
  /// and returns the same object if it is not null. If `date` is null, it returns
  /// the current DateTime.
  DateTime showDateAsDateTime(DateTime? date) {
    if (date == null) {
      return DateTime.now();
    } else {
      return date;
    }
  }
}
