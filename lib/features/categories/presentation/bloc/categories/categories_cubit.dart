import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jahiz/core/app_constants.dart';
import 'package:jahiz/features/categories/domain/entities/category.dart';
import 'package:jahiz/features/categories/domain/usecases/get_categories.dart';
part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this._getCategoriesUseCase) : super(CategoriesInitial()) {
    getCategories();
  }

  final GetCategoriesUseCase _getCategoriesUseCase;

  Future<void> getCategories() async {
    emit(CategoriesLoadInProgress());
    final failureOrCategory =
        await _getCategoriesUseCase(AppConstants.mainCategoriesId);
    failureOrCategory.fold(
        (failure) => emit(CategoriesLoadFailure(failure.message)),
        (category) =>
            category.subCategories == null || category.subCategories!.isEmpty
                ? emit(CategoriesLoadEmpty())
                : emit(CategoriesLoadSuccess(category)));
  }
}
