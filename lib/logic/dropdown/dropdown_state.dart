part of 'dropdown_cubit.dart';

abstract class DropdownState extends Equatable {
  const DropdownState();
}

class DropdownInitial extends DropdownState {
  @override
  List<Object> get props => [];
}

class DropdownItemsLoaded extends DropdownState {
  final int selected;

  final List<MenuItem> items;

  const DropdownItemsLoaded({required this.selected, required this.items});

  @override
  List<Object?> get props => [selected];
}
