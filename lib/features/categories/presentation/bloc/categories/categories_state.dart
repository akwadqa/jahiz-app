part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();
}

class CategoriesInitial extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoadInProgress extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoadSuccess extends CategoriesState {
  final Category category;
  const CategoriesLoadSuccess(this.category);
  @override
  List<Object> get props => [category];
}

class CategoriesLoadEmpty extends CategoriesState {
  @override
  List<Object> get props => [];
}

class CategoriesLoadFailure extends CategoriesState {
  final String error;
  const CategoriesLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}
