import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';

class OrderContanier extends StatelessWidget {
  const OrderContanier(
      {super.key,
      required this.orderPrice,
      required this.discountAmount,
      required this.taxAmount,
      required this.grandTotal});
  final double? orderPrice;
  final double? discountAmount;
  final double? taxAmount;
  final double grandTotal;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(5.0),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        if (orderPrice != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).orderPrice),
              Text('${orderPrice!.toStringAsFixed(2)} ${S.of(context).qar}'),
            ],
          ),
        ],
        if (discountAmount != null) ...[
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).discount),
              Text(
                  '${discountAmount!.toStringAsFixed(2)} ${S.of(context).qar}'),
            ],
          ),
        ],
        if (taxAmount != null) ...[
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).delivery),
              Text('${taxAmount!.toStringAsFixed(2)} ${S.of(context).qar}'),
            ],
          ),
        ],
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(S.of(context).totalPrice,
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold)),
            Text('${grandTotal.toStringAsFixed(2)} ${S.of(context).qar}',
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ]),
    );
  }
}
