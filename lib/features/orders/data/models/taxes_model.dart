import '../../domain/entities/taxes.dart';

class TaxesModel extends Taxes {
  const TaxesModel(
      {required super.name,
      required super.owner,
      required super.creation,
      required super.modified,
      required super.modifiedBy,
      required super.parent,
      required super.parentfield,
      required super.parenttype,
      required super.idx,
      required super.docstatus,
      required super.chargeType,
      required super.accountHead,
      required super.description,
      required super.includedInPrintRate,
      required super.includedInPaidAmount,
      required super.costCenter,
      required super.rate,
      required super.accountCurrency,
      required super.taxAmount,
      required super.total,
      required super.taxAmountAfterDiscountAmount,
      required super.baseTaxAmount,
      required super.baseTotal,
      required super.baseTaxAmountAfterDiscountAmount,
      required super.itemWiseTaxDetail,
      required super.dontRecomputeTax,
      required super.doctype,
      required super.unsaved});

  factory TaxesModel.fromJson(Map<String, dynamic> json) {
    return TaxesModel(
      name: json['name'] as String,
      owner: json['owner'] as String,
      creation: json['creation'] as String,
      modified: json['modified'] as String,
      modifiedBy: json['modified_by'] as String,
      parent: json['parent'] as String,
      parentfield: json['parentfield'] as String,
      parenttype: json['parenttype'] as String,
      idx: json['idx'] as int,
      docstatus: json['docstatus'] as int,
      chargeType: json['charge_type'] as String,
      accountHead: json['account_head'] as String,
      description: json['description'] as String,
      includedInPrintRate: json['included_in_print_rate'] as int,
      includedInPaidAmount: json['included_in_paid_amount'] as int,
      costCenter: json['cost_center'] as String,
      rate: json['rate'] as double,
      accountCurrency: json['account_currency'] as String,
      taxAmount: json['tax_amount'] as double,
      total: json['total'] as double,
      taxAmountAfterDiscountAmount:
          json['tax_amount_after_discount_amount'] as double,
      baseTaxAmount: json['base_tax_amount'] as double,
      baseTotal: json['base_total'] as double,
      baseTaxAmountAfterDiscountAmount:
          json['base_tax_amount_after_discount_amount'] as double,
      itemWiseTaxDetail: json['item_wise_tax_detail'] as String,
      dontRecomputeTax: json['dont_recompute_tax'] as int,
      doctype: json['doctype'] as String,
      unsaved: json['__unsaved'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['owner'] = owner;
    map['creation'] = creation;
    map['modified'] = modified;
    map['modified_by'] = modifiedBy;
    map['parent'] = parent;
    map['parentfield'] = parentfield;
    map['parenttype'] = parenttype;
    map['idx'] = idx;
    map['docstatus'] = docstatus;
    map['charge_type'] = chargeType;
    map['account_head'] = accountHead;
    map['description'] = description;
    map['included_in_print_rate'] = includedInPrintRate;
    map['included_in_paid_amount'] = includedInPaidAmount;
    map['cost_center'] = costCenter;
    map['rate'] = rate;
    map['account_currency'] = accountCurrency;
    map['tax_amount'] = taxAmount;
    map['total'] = total;
    map['tax_amount_after_discount_amount'] = taxAmountAfterDiscountAmount;
    map['base_tax_amount'] = baseTaxAmount;
    map['base_total'] = baseTotal;
    map['base_tax_amount_after_discount_amount'] =
        baseTaxAmountAfterDiscountAmount;
    map['item_wise_tax_detail'] = itemWiseTaxDetail;
    map['dont_recompute_tax'] = dontRecomputeTax;
    map['doctype'] = doctype;
    map['__unsaved'] = unsaved;
    return map;
  }
}
