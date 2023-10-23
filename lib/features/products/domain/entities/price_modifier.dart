import 'package:equatable/equatable.dart';

class PriceModifier extends Equatable {
  final int quantity;
  final double amount;

  const PriceModifier(this.quantity, this.amount);

  PriceModifier copyWith({int? quantity, double? amount}) {
    return PriceModifier(quantity ?? this.quantity, amount ?? this.amount);
  }

  @override
  List<Object?> get props => [quantity, amount];
}
