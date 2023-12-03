import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

part 'time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  TimeCubit()
      : super(TimeInitial(
            time: null, date: null, random: Random().nextInt(999999)));

  update(
    DateTime? time,
    DateTime? date,
  ) {
    emit(TimeInitial(time: time, date: date, random: Random().nextInt(999999)));
  }

  String showTime(DateTime? time) {
    if (time == null) {
      return DateFormat('hh:mm a').format(DateTime.now()).toString();
    } else {
      return DateFormat('hh:mm a').format(time).toString();
    }
  }

  DateTime showTimeAsDateTime(DateTime? time) {
    if (time == null) {
      return DateTime.now();
    } else {
      return time;
    }
  }

  String showDate(DateTime? date) {
    if (date == null) {
      return DateFormat.yMMMEd().format(DateTime.now()).toString();
    } else {
      return DateFormat.yMMMEd().format(date).toString();
    }
  }

  DateTime showDateAsDateTime(DateTime? date) {
    if (date == null) {
      return DateTime.now();
    } else {
      return date;
    }
  }
}
