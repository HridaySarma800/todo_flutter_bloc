import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/logic/home_cubit/home_cubit.dart';
import 'package:todo/presentation/models/menu_item.dart';

part 'dropdown_state.dart';

class DropdownCubit extends Cubit<DropdownState> {
  DropdownCubit() : super(DropdownInitial()) {
    loadItems();
  }

  void loadItems() {
    const all = MenuItem(text: 'All', icon: Icons.list_alt_sharp);
    const done = MenuItem(text: 'Done', icon: Icons.done_all_outlined);
    const pending = MenuItem(text: 'Pending', icon: Icons.pending);
    emit(const DropdownItemsLoaded(selected: 0, items: [all, done, pending]));
  }

  void toggle(int pos, List<MenuItem> items) {
    emit(DropdownItemsLoaded(selected: pos, items: items));
  }
}
