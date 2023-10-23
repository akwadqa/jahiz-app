import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jahiz/features/payment/domain/usecases/get_payment_methods.dart';

import '../../domain/entities/payment_method.dart';
part 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit(this._getPaymentMethodsUseCase)
      : super(PaymentMethodsInitial());

  final GetPaymentMethodsUseCase _getPaymentMethodsUseCase;

  Future<void> getPaymentMethods() async {
    emit(PaymentMethodsLoading());
    final failureOrPaymentMethods = await _getPaymentMethodsUseCase();
    failureOrPaymentMethods.fold(
        (failure) => emit(PaymentMethodsError(failure.message)),
        (paymentMethods) => emit(PaymentMethodsLoaded(paymentMethods)));
  }
}
