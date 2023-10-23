import '../../domain/entities/other_charges_calculation.dart';

class OtherChargesCalculationModel extends OtherChargesCalculation {
  const OtherChargesCalculationModel(
      {required super.chargeType,
      required super.accountHead,
      required super.description,
      required super.taxAmount,
      required super.total});

  factory OtherChargesCalculationModel.fromJson(Map<String, dynamic> json) {
    return OtherChargesCalculationModel(
        chargeType: json['charge_type'],
        accountHead: json['account_head'],
        description: json['description'],
        taxAmount: json['tax_amount'],
        total: json['total']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['charge_type'] = chargeType;
    map['account_head'] = accountHead;
    map['description'] = description;
    map['tax_amount'] = taxAmount;
    map['total'] = total;
    return map;
  }
}
