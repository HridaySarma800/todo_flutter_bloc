import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/presentation/models/menu_item.dart';

part 'dropdown_state.dart';

/// Cubit for managing the state of a dropdown in the application.
/// The `DropdownCubit` extends the `Cubit` class and provides methods to load
/// dropdown items and toggle the selected item. It emits different states based
/// on the loaded items and the selected position in the dropdown.

class DropdownCubit extends Cubit<DropdownState> {
  DropdownCubit() : super(DropdownInitial()) {
    loadItems();
  }

  /// Loads the dropdown items with default values.
  void loadItems() {
    const all = MenuItem(text: 'All', icon: Icons.list_alt_sharp);
    const done = MenuItem(text: 'Done', icon: Icons.done_all_outlined);
    const pending = MenuItem(text: 'Pending', icon: Icons.pending);
    emit(const DropdownItemsLoaded(selected: 0, items: [all, done, pending]));
  }

  /// Toggles the selected position in the dropdown.
  void toggle(int pos, List<MenuItem> items) {
    emit(DropdownItemsLoaded(selected: pos, items: items));
  }
}
