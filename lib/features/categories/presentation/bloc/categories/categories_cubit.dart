import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/app_constants.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/usecases/get_categories.dart';
part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this._getCategoriesUseCase) : super(CategoriesInitial()) {
    getCategories();
  }

  final GetCategoriesUseCase _getCategoriesUseCase;

  Future<void> searchProduct({String search = ''}) async {
    emit(CategoriesLoadInProgress());
    final failureOrCategory =
        await _getCategoriesUseCase(AppConstants.mainCategoriesId, search);
    failureOrCategory.fold(
        (failure) => emit(CategoriesLoadFailure(failure.message)),
        (category) => category.products == null || category.products!.isEmpty
            ? emit(CategoriesLoadEmpty())
            : emit(CategoriesLoadSuccess(category)));
  }

  Future<void> getCategories() async {
    emit(CategoriesLoadInProgress());
    final failureOrCategory =
        await _getCategoriesUseCase(AppConstants.mainCategoriesId, null);
    failureOrCategory.fold(
        (failure) => emit(CategoriesLoadFailure(failure.message)),
        (category) =>
            category.subCategories == null || category.subCategories!.isEmpty
                ? emit(CategoriesLoadEmpty())
                : emit(CategoriesLoadSuccess(category)));
  }
}
