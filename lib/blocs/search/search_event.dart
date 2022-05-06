part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class OnAddCategory extends SearchEvent {
  final Category category;

  OnAddCategory(this.category);

  @override
  List<Object> get props => [category];
}

class OnRemoveCategory extends SearchEvent {
  final int categoryId;
  OnRemoveCategory(this.categoryId);
}
