import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/detailed_product.dart';
import '../../../domain/usecases/get_detailed_product.dart';

part 'detailed_product_state.dart';

class DetailedProductCubit extends Cubit<DetailedProductState> {
  DetailedProductCubit(this._getDetailedProductUseCase)
      : super(DetailedProductInitial());

  final GetDetailedProductUseCase _getDetailedProductUseCase;

  Future<void> getDetailedProduct(String productId) async {
    emit(DetailedProductLoadInProgress());
    final failureOrDetailedProduct =
        await _getDetailedProductUseCase(productId);
    failureOrDetailedProduct.fold(
        (failure) => emit(DetailedProductLoadFailure(failure.message)),
        (homeBlocks) => emit(DetailedProductLoadSuccess(homeBlocks)));
  }
}
