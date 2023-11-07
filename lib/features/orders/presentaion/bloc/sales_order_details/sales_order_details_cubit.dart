import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jahiz/features/orders/domain/entities/sales_order_details/sales_order_details.dart';
import 'package:jahiz/features/orders/domain/usecases/get_sales_order_details.dart';

part 'sales_order_details_state.dart';

class SalesOrderDetailsCubit extends Cubit<SalesOrderDetailsState> {
  SalesOrderDetailsCubit(this._getSalesOrderDetailsUseCase)
      : super(SalesOrderDetailsInitial());

  final GetSalesOrderDetailsUseCase _getSalesOrderDetailsUseCase;

  Future<void> getSalesOrderDetails(String orderId) async {
    emit(SalesOrderDetailsLoading());
    final failureOrLoaded = await _getSalesOrderDetailsUseCase(orderId);
    failureOrLoaded.fold(
        (failure) => emit(SalesOrderDetailsError(failure.message)),
        (salesOrderDetails) =>
            emit(SalesOrderDetailsLoaded(salesOrderDetails)));
  }
}
