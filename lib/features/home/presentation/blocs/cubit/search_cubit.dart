import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jahiz/core/app_constants.dart';
import 'package:jahiz/features/categories/domain/entities/category.dart';
import 'package:jahiz/features/categories/domain/usecases/get_categories.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this._getCategoriesUseCase) : super(SearchInitial());

  
  final GetCategoriesUseCase _getCategoriesUseCase;

  Future<void> searchProduct({String search = ''}) async {
    emit(SearchLoadInProgress());
    final failureOrCategory =
        await _getCategoriesUseCase(AppConstants.mainCategoriesId, search);
    failureOrCategory.fold(
        (failure) => emit(SearchLoadFailure(failure.message)),
        (category) => category.products == null || category.products!.isEmpty
            ? emit(SearchLoadEmpty())
            : emit(SearchLoadSuccess(category)));
  }
}
