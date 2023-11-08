import 'package:flutter/material.dart';
import '../../../../generated/l10n.dart';

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget(
      {super.key,
      required this.qty,
      required this.itemName,
      required this.amount});
  final double qty;
  final String itemName;
  final double amount;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: RichText(
          text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
        TextSpan(
            text: qty.toStringAsFixed(0),
            style: const TextStyle(fontSize: 18.0)),
        const TextSpan(text: 'x')
      ])),
      title: Text(itemName,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500)),
      trailing: Text('${amount.toStringAsFixed(2)} ${S.of(context).qar}',
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold)),
    );
  }
}
