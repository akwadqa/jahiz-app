import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/app_error_widget.dart';
import '../../../../core/widgets/custom_back_button.dart';
import '../../../../core/widgets/dashed_line.dart';
import '../bloc/sales_order_details/sales_order_details_cubit.dart';
import '../widgets/order_container.dart';
import '../widgets/order_item_widget.dart';
import '../widgets/your_order_text.dart';
import '../../../../generated/l10n.dart';
import '../../../../injection_container.dart';

@RoutePage()
class OrderDetailsPage extends StatelessWidget implements AutoRouteWrapper {
  const OrderDetailsPage({super.key, required this.salesOrderId});
  final String salesOrderId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(S.of(context).orderDetails),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: BlocBuilder<SalesOrderDetailsCubit, SalesOrderDetailsState>(
            builder: (context, state) {
          if (state is SalesOrderDetailsLoaded) {
            final orderDetails = state.salesOrderDetails;
            final orderItems = orderDetails.itemsDetail;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const YourOrderText(),
                const SizedBox(height: 30),
                ListView.separated(
                  itemBuilder: (context, index) {
                    final orderItem = orderItems[index];
                    return OrderItemWidget(
                        qty: orderItem.qty,
                        itemName: orderItem.websiteItemName,
                        amount: orderItem.netAmount);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20.0),
                  itemCount: orderItems.length,
                  shrinkWrap: true,
                ),
                DashedLine(
                    color: Theme.of(context).primaryColor.withOpacity(0.4)),
                const SizedBox(height: 14.0),
                OrderContanier(
                    orderPrice: orderDetails.orderPrice,
                    discountAmount: orderDetails.discountAmount,
                    taxAmount: orderDetails.extraCharges,
                    grandTotal: orderDetails.grandTotal),
              ],
            );
          } else if (state is SalesOrderDetailsError) {
            return AppErrorWidget(
                errorText: state.message,
                onRetryClicked: () => context
                    .read<SalesOrderDetailsCubit>()
                    .getSalesOrderDetails(salesOrderId));
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        }),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            getIt<SalesOrderDetailsCubit>()..getSalesOrderDetails(salesOrderId),
        child: this);
  }
}
