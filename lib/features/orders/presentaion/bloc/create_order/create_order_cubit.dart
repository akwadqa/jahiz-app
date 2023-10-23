import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jahiz/features/orders/domain/usecases/create_order.dart';

import '../../../domain/entities/order.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  CreateOrderCubit(this._createOrderUseCase) : super(CreateOrderInitial());
  final CreateOrderUseCase _createOrderUseCase;

  Future<void> createOrder(String quotationId, String paymentMethodId) async {
    emit(CreateOrderLoading());
    final failureOrOrder =
        await _createOrderUseCase(quotationId, paymentMethodId);
    failureOrOrder.fold(
        (failure) => emit(CreateOrderError(message: failure.message)),
        (order) => emit(CreateOrderLoaded(order)));
  }
}
