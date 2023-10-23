import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jahiz/features/orders/domain/usecases/update_payment_status.dart';

part 'update_payment_status_state.dart';

class UpdatePaymentStatusCubit extends Cubit<UpdatePaymentStatusState> {
  UpdatePaymentStatusCubit(this._updatePaymentStatusUseCase)
      : super(UpdatePaymentStatusInitial());

  final UpdatePaymentStatusUseCase _updatePaymentStatusUseCase;

  Future<void> updatePaymentStatus(
      String orderId,
      String paymentGateway,
      String invoiceId,
      String amount,
      String payerEmail,
      String payerName,
      String currency) async {
    emit(UpdatePaymentStatusLoading());
    final failureOrLoaded = await _updatePaymentStatusUseCase(orderId,
        paymentGateway, invoiceId, amount, payerEmail, payerName, currency);
    failureOrLoaded.fold(
        (failure) => emit(UpdatePaymentStatusError(message: failure.message)),
        (order) => emit(const UpdatePaymentStatusLoaded()));
  }
}
