import 'package:equatable/equatable.dart';
import 'package:jahiz/features/cart/domain/entities/cart_item.dart';
import 'package:jahiz/features/products/domain/entities/additional_image.dart';
import 'package:jahiz/features/products/domain/entities/product_option.dart';
import 'package:jahiz/features/products/domain/entities/product_specification.dart';

class DetailedProduct extends Equatable {
  const DetailedProduct(
      {required this.websiteItemId,
      required this.itemCode,
      required this.websiteItemName,
      required this.itemGroup,
      required this.stockUom,
      required this.itemDescription,
      required this.backgroundColor,
      required this.published,
      required this.websiteImage,
      required this.shortDescription,
      required this.webLongDescription,
      required this.itemPrice,
      required this.currency,
      required this.discountPercent,
      required this.discountAmount,
      required this.discountedPrice,
      required this.inStock,
      required this.maintaneStock,
      required this.productOptions,
      required this.productSpecifications,
      required this.additionalImages});

  final String websiteItemId;
  final String itemCode;
  final String websiteItemName;
  final String itemGroup;
  final String stockUom;
  final String itemDescription;
  final String? backgroundColor;
  final int published;
  final String websiteImage;
  final String? shortDescription;
  final String? webLongDescription;
  final double itemPrice;
  final String currency;
  final String discountPercent;
  final double discountAmount;
  final double discountedPrice;
  final int inStock;
  final int maintaneStock;
  final List<ProductOption> productOptions;
  final List<ProductSpecification> productSpecifications;
  final List<AdditionalImage> additionalImages;

  DetailedProduct copyWith({
    String? websiteItemId,
    String? itemCode,
    String? websiteItemName,
    String? itemGroup,
    String? stockUom,
    String? mobileDefaultUom,
    String? itemDescription,
    String? backgroundColor,
    int? published,
    String? websiteImage,
    String? shortDescription,
    String? webLongDescription,
    double? itemPrice,
    String? currency,
    String? discountPercent,
    double? discountAmount,
    double? discountedPrice,
    int? inStock,
    int? maintaneStock,
    List<ProductOption>? productOptions,
    List<ProductSpecification>? productSpecifications,
    List<AdditionalImage>? additionalImages,
  }) =>
      DetailedProduct(
        websiteItemId: websiteItemId ?? this.websiteItemId,
        itemCode: itemCode ?? this.itemCode,
        websiteItemName: websiteItemName ?? this.websiteItemName,
        itemGroup: itemGroup ?? this.itemGroup,
        stockUom: stockUom ?? this.stockUom,
        itemDescription: itemDescription ?? this.itemDescription,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        published: published ?? this.published,
        websiteImage: websiteImage ?? this.websiteImage,
        shortDescription: shortDescription ?? this.shortDescription,
        webLongDescription: webLongDescription ?? this.webLongDescription,
        itemPrice: itemPrice ?? this.itemPrice,
        currency: currency ?? this.currency,
        discountPercent: discountPercent ?? this.discountPercent,
        discountAmount: discountAmount ?? this.discountAmount,
        discountedPrice: discountedPrice ?? this.discountedPrice,
        inStock: inStock ?? this.inStock,
        maintaneStock: maintaneStock ?? this.maintaneStock,
        productOptions: productOptions ?? this.productOptions,
        productSpecifications:
            productSpecifications ?? this.productSpecifications,
        additionalImages: additionalImages ?? this.additionalImages,
      );

  CartItem toCartItem() => CartItem(
      itemCode: websiteItemId,
      itemName: websiteItemName,
      itemGroup: itemGroup,
      image: websiteImage,
      qty: 0.0,
      uom: stockUom,
      priceListRate: discountedPrice,
      discountPercentage: 0.0,
      discountAmount: discountAmount,
      rate: 0.0,
      amount: 0.0,
      productOptions: const []);

  @override
  List<Object?> get props => [
        websiteItemId,
        itemCode,
        websiteItemName,
        itemGroup,
        stockUom,
        itemDescription,
        backgroundColor,
        published,
        websiteImage,
        shortDescription,
        webLongDescription,
        itemPrice,
        currency,
        discountPercent,
        discountAmount,
        discountedPrice,
        inStock,
        maintaneStock,
        productOptions,
        productSpecifications,
        additionalImages,
      ];
}
