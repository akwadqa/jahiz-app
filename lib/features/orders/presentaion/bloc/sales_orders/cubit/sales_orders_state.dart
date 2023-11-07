part of 'sales_orders_cubit.dart';

sealed class SalesOrdersCubitState extends Equatable {
  const SalesOrdersCubitState();

  @override
  List<Object> get props => [];
}

final class SalesOrdersCubitInitial extends SalesOrdersCubitState {}

final class SalesOrdersCubitLoading extends SalesOrdersCubitState {}

final class SalesOrdersCubitLoadedEmpty extends SalesOrdersCubitState {}

final class SalesOrdersCubitLoaded extends SalesOrdersCubitState {
  final AppResponse<List<SalesOrder>> appResponse;

  const SalesOrdersCubitLoaded(this.appResponse);

  @override
  List<Object> get props => [appResponse];
}

final class SalesOrdersCubitError extends SalesOrdersCubitState {
  final String message;

  const SalesOrdersCubitError(this.message);

  @override
  List<Object> get props => [message];
}
