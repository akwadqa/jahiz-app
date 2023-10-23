import 'package:equatable/equatable.dart';

class ProductSpecification extends Equatable {
  const ProductSpecification({
    required this.label,
    required this.description,
  });

  final String label;
  final String description;

  ProductSpecification copyWith({
    String? label,
    String? description,
  }) =>
      ProductSpecification(
        label: label ?? this.label,
        description: description ?? this.description,
      );

  @override
  List<Object?> get props => [
        label,
        description,
      ];
}
