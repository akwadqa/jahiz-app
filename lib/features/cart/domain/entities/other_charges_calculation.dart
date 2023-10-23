import 'package:equatable/equatable.dart';
import 'package:jahiz/features/cart/data/models/other_charges_calculation_model.dart';

class OtherChargesCalculation extends Equatable {
  final String chargeType;
  final String accountHead;
  final String description;
  final double taxAmount;
  final double total;

  const OtherChargesCalculation(
      {required this.chargeType,
      required this.accountHead,
      required this.description,
      required this.taxAmount,
      required this.total});

  OtherChargesCalculation copyWith(
      {String? chargeType,
      String? accountHead,
      String? description,
      double? taxAmount,
      double? total}) {
    return OtherChargesCalculation(
        chargeType: chargeType ?? this.chargeType,
        accountHead: accountHead ?? this.accountHead,
        description: description ?? this.description,
        taxAmount: taxAmount ?? this.taxAmount,
        total: total ?? this.total);
  }

  OtherChargesCalculationModel toModel() {
    return OtherChargesCalculationModel(
        chargeType: chargeType,
        accountHead: accountHead,
        description: description,
        taxAmount: taxAmount,
        total: total);
  }

  @override
  List<Object?> get props =>
      [chargeType, accountHead, description, taxAmount, total];
}
