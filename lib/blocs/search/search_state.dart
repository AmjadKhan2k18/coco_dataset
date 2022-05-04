part of 'search_bloc.dart';

@immutable
abstract class SearchState extends Equatable {
  @override
  List<Category> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {}

class UpdatedCategory extends SearchState {
  final List<Category> categoriesIds;

  UpdatedCategory(this.categoriesIds);
  @override
  List<Category> get props => categoriesIds;
}
