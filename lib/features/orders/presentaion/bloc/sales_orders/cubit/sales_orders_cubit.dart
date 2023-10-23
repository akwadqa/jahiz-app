import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jahiz/core/domain/entities/app_response.dart';
import 'package:jahiz/features/orders/domain/entities/sales_order/sales_order.dart';
import 'package:jahiz/features/orders/domain/usecases/get_sales_orders.dart';

part 'sales_orders_state.dart';

class SalesOrdersCubit extends Cubit<SalesOrdersCubitState> {
  SalesOrdersCubit(this._getSalesOrdersUserCase)
      : super(SalesOrdersCubitInitial());

  final GetSalesOrdersUseCase _getSalesOrdersUserCase;

  Future<void> getSalesOrders([int? page]) async {
    emit(SalesOrdersCubitLoading());
    final failureOrLoaded = await _getSalesOrdersUserCase(page);
    failureOrLoaded.fold(
        (failure) => emit(SalesOrdersCubitError(failure.message)),
        (salesOrders) => emit(salesOrders.data.isEmpty
            ? SalesOrdersCubitLoadedEmpty()
            : SalesOrdersCubitLoaded(salesOrders)));
  }

  Future<bool> onLoadingMore(int? page) async {
    final failureOrLoaded = await _getSalesOrdersUserCase(page);
    return failureOrLoaded.fold((failure) => false,
        (AppResponse<List<SalesOrder>> appResponse) {
      final List<SalesOrder> currentSalesOrders =
          (state as SalesOrdersCubitLoaded).appResponse.data;
      final List<SalesOrder> newSalesOrders = appResponse.data;
      currentSalesOrders.addAll(newSalesOrders);
      emit(SalesOrdersCubitLoaded((state as SalesOrdersCubitLoaded)
          .appResponse
          .copyWith(
              data: currentSalesOrders, pagination: appResponse.pagination)));
      return true;
    });
  }
}
