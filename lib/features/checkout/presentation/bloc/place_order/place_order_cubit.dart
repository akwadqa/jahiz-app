import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/usecases/place_order.dart';

part 'place_order_state.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit(this._placeOrderUseCase) : super(PlaceOrderInitial());
  final PlaceOrderUseCase _placeOrderUseCase;

  Future<void> placeOrder(String quotationId, [int? isSuccess]) async {
    emit(PlaceOrderLoading());
    final failureOrOrder = await _placeOrderUseCase(quotationId, isSuccess);
    failureOrOrder.fold(
        (failure) => emit(PlaceOrderError(message: failure.message)),
        (order) => emit(PlaceOrderLoaded(order)));
  }
}
