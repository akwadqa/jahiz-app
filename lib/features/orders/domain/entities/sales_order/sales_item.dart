import 'package:equatable/equatable.dart';

class SalesItem extends Equatable {
  final String websiteItemCode;
  final String websiteItemName;
  final num qty;
  final double netRate;
  final double netAmount;
  final String itemGroup;
  final String image;
  final String websiteImage;

  const SalesItem({
    required this.websiteItemCode,
    required this.websiteItemName,
    required this.qty,
    required this.netRate,
    required this.netAmount,
    required this.itemGroup,
    required this.image,
    required this.websiteImage,
  });

  @override
  List<Object> get props {
    return [
      websiteItemCode,
      websiteItemName,
      qty,
      netRate,
      netAmount,
      itemGroup,
      image,
      websiteImage
    ];
  }
}
