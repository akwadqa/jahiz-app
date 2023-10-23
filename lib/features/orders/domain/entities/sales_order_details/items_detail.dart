import 'package:equatable/equatable.dart';

class ItemsDetail extends Equatable {
  final String websiteItemCode;
  final String websiteItemName;
  final double qty;
  final double netRate;
  final double netAmount;
  final String itemGroup;
  final String image;
  final dynamic productOption;
  final String itemImage;
  final String backgroundColor;
  final List<dynamic> productOptions;

  const ItemsDetail({
    required this.websiteItemCode,
    required this.websiteItemName,
    required this.qty,
    required this.netRate,
    required this.netAmount,
    required this.itemGroup,
    required this.image,
    required this.productOption,
    required this.itemImage,
    required this.backgroundColor,
    required this.productOptions,
  });

  @override
  List<Object?> get props {
    return [
      websiteItemCode,
      websiteItemName,
      qty,
      netRate,
      netAmount,
      itemGroup,
      image,
      productOption,
      itemImage,
      backgroundColor,
      productOptions,
    ];
  }
}
