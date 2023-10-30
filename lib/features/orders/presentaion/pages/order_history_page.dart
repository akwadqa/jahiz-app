import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/router/app_router.dart';
import 'package:jahiz/core/widgets/app_error_widget.dart';
import 'package:jahiz/core/widgets/app_pagination_widget.dart';
import 'package:jahiz/core/widgets/contained_button.dart';
import 'package:jahiz/core/widgets/custom_back_button.dart';
import 'package:jahiz/features/orders/presentaion/bloc/sales_orders/cubit/sales_orders_cubit.dart';
import 'package:jahiz/generated/l10n.dart';
import 'package:jahiz/injection_container.dart';

@RoutePage()
class OrderHistoryPage extends StatelessWidget implements AutoRouteWrapper {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(S.of(context).myOrders),
      ),
      body: BlocBuilder<SalesOrdersCubit, SalesOrdersCubitState>(
          builder: (context, state) {
        if (state is SalesOrdersCubitLoadedEmpty) {
          return Center(child: Text(S.of(context).noElements));
        }
        if (state is SalesOrdersCubitLoaded) {
          return AppPaginationWidget(
              onLoading: context.read<SalesOrdersCubit>().onLoadingMore,
              child: ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 20.0),
                  itemBuilder: (context, index) {
                    final order = state.appResponse.data[index];
                    return Container(
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15.0)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              2,
                              (rowIndex) => Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          rowIndex == 0
                                              ? S.of(context).orderNo
                                              : S.of(context).orderDate,
                                          style: _titleTextStyle),
                                      const SizedBox(height: 6),
                                      Text(
                                          rowIndex == 0
                                              ? order.salesOrderId
                                              : order.date,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18.0))
                                    ],
                                  )),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(S.of(context).orderStatus,
                                    style: _titleTextStyle),
                                const SizedBox(height: 6),
                                Text(order.orderStatus,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor))
                              ],
                            ),
                            ContainedButton(
                                margin: const EdgeInsets.all(8.0),
                                icon: const Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(start: 4.0),
                                  child: Icon(Icons.arrow_forward_ios),
                                ),
                                onPressed: () => context.pushRoute(
                                    OrderDetailsRoute(
                                        salesOrderId: order.salesOrderId)))
                          ],
                        )
                      ]),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 20.0,
                    );
                  },
                  itemCount: state.appResponse.data.length));
        }
        if (state is SalesOrdersCubitError) {
          return AppErrorWidget(
              errorText: state.message,
              onRetryClicked: context.read<SalesOrdersCubit>().getSalesOrders);
        }
        return const Center(child: CircularProgressIndicator.adaptive());
      }),
    );
  }

  TextStyle get _titleTextStyle =>
      const TextStyle(color: Colors.black, fontSize: 16.0);

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SalesOrdersCubit>()..getSalesOrders(),
      child: this,
    );
  }
}
