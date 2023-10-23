part of 'sub_categories_cubit.dart';

abstract class SubCategoriesState extends Equatable {
  const SubCategoriesState();
}

class SubCategoriesInitial extends SubCategoriesState {
  @override
  List<Object> get props => [];
}

class SubCategoriesLoadInProgress extends SubCategoriesState {
  @override
  List<Object> get props => [];
}

class SubCategoriesLoadSuccess extends SubCategoriesState {
  final Category category;
  final Category? selectedCategory;
  final ProductsState productsState;
  const SubCategoriesLoadSuccess(
      {required this.category,
      required this.productsState,
      this.selectedCategory});

  SubCategoriesLoadSuccess copyWith(
      {Category? category,
      Category? selectedCategory,
      ProductsState? productsState}) {
    return SubCategoriesLoadSuccess(
        category: category ?? this.category,
        productsState: productsState ?? this.productsState,
        selectedCategory: selectedCategory ?? this.selectedCategory);
  }

  @override
  List<Object?> get props => [category, selectedCategory, productsState];
}

class SubCategoriesLoadFailure extends SubCategoriesState {
  final String error;
  const SubCategoriesLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}

abstract class ProductsState extends Equatable {
  const ProductsState();
}

class ProductsLoadInProgress extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsLoadSuccess extends ProductsState {
  final List<Product> products;

  const ProductsLoadSuccess(this.products);
  @override
  List<Object> get props => [products];
}

class ProductsLoadEmpty extends ProductsState {
  @override
  List<Object> get props => [];
}

class ProductsLoadFailure extends ProductsState {
  final String error;
  const ProductsLoadFailure(this.error);
  @override
  List<Object> get props => [error];
}
