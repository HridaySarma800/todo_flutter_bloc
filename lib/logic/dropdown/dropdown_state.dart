part of 'dropdown_cubit.dart';

/// Represents the state of the dropdown in the application.
/// This abstract class defines different states that the dropdown can be in.

abstract class DropdownState extends Equatable {
  const DropdownState();
}

/// Initial state when the dropdown is first created.

class DropdownInitial extends DropdownState {
  @override
  List<Object> get props => [];
}

/// State indicating that dropdown items are loaded.
/// It includes the selected position and a list of dropdown items.
class DropdownItemsLoaded extends DropdownState {
  final int selected;

  final List<MenuItem> items;

  const DropdownItemsLoaded({required this.selected, required this.items});

  @override
  List<Object?> get props => [selected];
}
