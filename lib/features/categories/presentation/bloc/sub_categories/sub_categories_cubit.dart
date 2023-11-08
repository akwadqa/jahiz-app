import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/category.dart';
import '../../../../products/domain/entities/product.dart';

import '../../../domain/usecases/get_categories.dart';

part 'sub_categories_state.dart';

class SubCategoriesCubit extends Cubit<SubCategoriesState> {
  SubCategoriesCubit(this._getCategoriesUseCase, this._categoryId)
      : super(SubCategoriesInitial()) {
    getSubCategories();
  }

  final GetCategoriesUseCase _getCategoriesUseCase;

  final String _categoryId;

  Future<void> getSubCategories() async {
    emit(SubCategoriesLoadInProgress());
    final failureOrCategory = await _getCategoriesUseCase(_categoryId);
    failureOrCategory
        .fold((failure) => emit(SubCategoriesLoadFailure(failure.message)),
            (category) async {
      if (category.subCategories!.isNotEmpty && category.products!.isEmpty) {
        emit(SubCategoriesLoadSuccess(
            category: category,
            productsState: ProductsLoadSuccess(category.products!)));
        await loadProductsOfCategory(category.itemGroupId, true);
      } else {
        emit(SubCategoriesLoadSuccess(
            category: category,
            productsState: ProductsLoadSuccess(category.products!)));
      }
    });
  }

  Future<void> loadProductsOfCategory(String categoryId,
      [bool isFirstCategorySelected = false]) async {
    emit((state as SubCategoriesLoadSuccess).copyWith(
        productsState: ProductsLoadInProgress(),
        selectedCategory: isFirstCategorySelected
            ? (state as SubCategoriesLoadSuccess).category.subCategories!.first
            : (state as SubCategoriesLoadSuccess)
                .category
                .subCategories!
                .where((element) => element.itemGroupId == categoryId)
                .toList()
                .first));
    final failureOrCategory = await _getCategoriesUseCase(categoryId);
    failureOrCategory.fold(
        (failure) => emit((state as SubCategoriesLoadSuccess)
            .copyWith(productsState: ProductsLoadFailure(failure.message))),
        (category) => emit((state as SubCategoriesLoadSuccess).copyWith(
            productsState: category.products!.isEmpty
                ? ProductsLoadEmpty()
                : ProductsLoadSuccess(category.products!))));
  }
}
