import 'package:equatable/equatable.dart';

class Taxes extends Equatable {
  final String name;
  final String owner;
  final String creation;
  final String modified;
  final String modifiedBy;
  final String parent;
  final String parentfield;
  final String parenttype;
  final int idx;
  final int docstatus;
  final String chargeType;
  final String accountHead;
  final String description;
  final int includedInPrintRate;
  final int includedInPaidAmount;
  final String costCenter;
  final double rate;
  final String accountCurrency;
  final double taxAmount;
  final double total;
  final double taxAmountAfterDiscountAmount;
  final double baseTaxAmount;
  final double baseTotal;
  final double baseTaxAmountAfterDiscountAmount;
  final String itemWiseTaxDetail;
  final int dontRecomputeTax;
  final String doctype;
  final int unsaved;

  const Taxes(
      {required this.name,
      required this.owner,
      required this.creation,
      required this.modified,
      required this.modifiedBy,
      required this.parent,
      required this.parentfield,
      required this.parenttype,
      required this.idx,
      required this.docstatus,
      required this.chargeType,
      required this.accountHead,
      required this.description,
      required this.includedInPrintRate,
      required this.includedInPaidAmount,
      required this.costCenter,
      required this.rate,
      required this.accountCurrency,
      required this.taxAmount,
      required this.total,
      required this.taxAmountAfterDiscountAmount,
      required this.baseTaxAmount,
      required this.baseTotal,
      required this.baseTaxAmountAfterDiscountAmount,
      required this.itemWiseTaxDetail,
      required this.dontRecomputeTax,
      required this.doctype,
      required this.unsaved});

  @override
  List<Object?> get props => [
        name,
        owner,
        creation,
        modified,
        modifiedBy,
        parent,
        parentfield,
        parenttype,
        idx,
        docstatus,
        chargeType,
        accountHead,
        description,
        includedInPrintRate,
        includedInPaidAmount,
        costCenter,
        rate,
        accountCurrency,
        taxAmount,
        total,
        taxAmountAfterDiscountAmount,
        baseTaxAmount,
        baseTotal,
        baseTaxAmountAfterDiscountAmount,
        itemWiseTaxDetail,
        dontRecomputeTax,
        doctype,
        unsaved
      ];
}
