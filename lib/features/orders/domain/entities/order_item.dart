import 'package:equatable/equatable.dart';

class OrderItem extends Equatable {
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
  final String itemCode;
  final int ensureDeliveryBasedOnProducedSerialNo;
  final String itemName;
  final String description;
  final String itemGroup;
  final String image;
  final double qty;
  final String stockUom;
  final double pickedQty;
  final String uom;
  final double conversionFactor;
  final double stockQty;
  final double priceListRate;
  final double basePriceListRate;
  final String? marginType;
  final double marginRateOrAmount;
  final double rateWithMargin;
  final double discountPercentage;
  final double discountAmount;
  final double baseRateWithMargin;
  final double rate;
  final double amount;
  final double baseRate;
  final double baseAmount;
  final double stockUomRate;
  final int isFreeItem;
  final int grantCommission;
  final double netRate;
  final double netAmount;
  final double baseNetRate;
  final double baseNetAmount;
  final double billedAmt;
  final double valuationRate;
  final double grossProfit;
  final int deliveredBySupplier;
  final double weightPerUnit;
  final double totalWeight;
  final String warehouse;
  final String prevdocDocname;
  final int againstBlanketOrder;
  final double blanketOrderRate;
  final double projectedQty;
  final double actualQty;
  final double orderedQty;
  final double plannedQty;
  final double workOrderQty;
  final double producedQty;
  final double deliveredQty;
  final double returnedQty;
  final int pageBreak;
  final String itemTaxRate;
  final String transactionDate;
  final String doctype;
  final int unsaved;

  const OrderItem(
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
      required this.itemCode,
      required this.ensureDeliveryBasedOnProducedSerialNo,
      required this.itemName,
      required this.description,
      required this.itemGroup,
      required this.image,
      required this.qty,
      required this.stockUom,
      required this.pickedQty,
      required this.uom,
      required this.conversionFactor,
      required this.stockQty,
      required this.priceListRate,
      required this.basePriceListRate,
      required this.marginType,
      required this.marginRateOrAmount,
      required this.rateWithMargin,
      required this.discountPercentage,
      required this.discountAmount,
      required this.baseRateWithMargin,
      required this.rate,
      required this.amount,
      required this.baseRate,
      required this.baseAmount,
      required this.stockUomRate,
      required this.isFreeItem,
      required this.grantCommission,
      required this.netRate,
      required this.netAmount,
      required this.baseNetRate,
      required this.baseNetAmount,
      required this.billedAmt,
      required this.valuationRate,
      required this.grossProfit,
      required this.deliveredBySupplier,
      required this.weightPerUnit,
      required this.totalWeight,
      required this.warehouse,
      required this.prevdocDocname,
      required this.againstBlanketOrder,
      required this.blanketOrderRate,
      required this.projectedQty,
      required this.actualQty,
      required this.orderedQty,
      required this.plannedQty,
      required this.workOrderQty,
      required this.producedQty,
      required this.deliveredQty,
      required this.returnedQty,
      required this.pageBreak,
      required this.itemTaxRate,
      required this.transactionDate,
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
        itemCode,
        ensureDeliveryBasedOnProducedSerialNo,
        itemName,
        description,
        itemGroup,
        image,
        qty,
        stockUom,
        pickedQty,
        uom,
        conversionFactor,
        stockQty,
        priceListRate,
        basePriceListRate,
        marginType,
        marginRateOrAmount,
        rateWithMargin,
        discountPercentage,
        discountAmount,
        baseRateWithMargin,
        rate,
        amount,
        baseRate,
        baseAmount,
        stockUomRate,
        isFreeItem,
        grantCommission,
        netRate,
        netAmount,
        baseNetRate,
        baseNetAmount,
        billedAmt,
        valuationRate,
        grossProfit,
        deliveredBySupplier,
        weightPerUnit,
        totalWeight,
        warehouse,
        prevdocDocname,
        againstBlanketOrder,
        blanketOrderRate,
        projectedQty,
        actualQty,
        orderedQty,
        plannedQty,
        workOrderQty,
        producedQty,
        deliveredQty,
        returnedQty,
        pageBreak,
        itemTaxRate,
        transactionDate,
        doctype,
        unsaved
      ];
}
