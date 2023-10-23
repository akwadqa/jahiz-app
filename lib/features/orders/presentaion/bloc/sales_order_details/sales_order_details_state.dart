part of 'sales_order_details_cubit.dart';

sealed class SalesOrderDetailsState extends Equatable {
  const SalesOrderDetailsState();

  @override
  List<Object> get props => [];
}

final class SalesOrderDetailsInitial extends SalesOrderDetailsState {}

final class SalesOrderDetailsLoading extends SalesOrderDetailsState {}

final class SalesOrderDetailsLoaded extends SalesOrderDetailsState {
  final SalesOrderDetails salesOrderDetails;

  const SalesOrderDetailsLoaded(this.salesOrderDetails);

  @override
  List<Object> get props => [salesOrderDetails];
}

final class SalesOrderDetailsError extends SalesOrderDetailsState {
  final String message;

  const SalesOrderDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
