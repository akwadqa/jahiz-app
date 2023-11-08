import '../../domain/entities/product_specification.dart';

class ProductSpecificationModel extends ProductSpecification {
  const ProductSpecificationModel(
      {required super.label, required super.description});

  factory ProductSpecificationModel.fromJson(Map<String, dynamic> json) {
    return ProductSpecificationModel(
      label: json['label'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['label'] = label;
    map['description'] = description;
    return map;
  }
}
