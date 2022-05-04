part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  @override
  List<Category> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<Category> categories;

  CategoriesLoaded(this.categories);
  @override
  List<Category> get props => categories;
}
