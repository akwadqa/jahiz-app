import '../../domain/entities/order_item.dart';

class OrderItemModel extends OrderItem {
  const OrderItemModel(
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
      required super.itemCode,
      required super.ensureDeliveryBasedOnProducedSerialNo,
      required super.itemName,
      required super.description,
      required super.itemGroup,
      required super.image,
      required super.qty,
      required super.stockUom,
      required super.pickedQty,
      required super.uom,
      required super.conversionFactor,
      required super.stockQty,
      required super.priceListRate,
      required super.basePriceListRate,
      required super.marginType,
      required super.marginRateOrAmount,
      required super.rateWithMargin,
      required super.discountPercentage,
      required super.discountAmount,
      required super.baseRateWithMargin,
      required super.rate,
      required super.amount,
      required super.baseRate,
      required super.baseAmount,
      required super.stockUomRate,
      required super.isFreeItem,
      required super.grantCommission,
      required super.netRate,
      required super.netAmount,
      required super.baseNetRate,
      required super.baseNetAmount,
      required super.billedAmt,
      required super.valuationRate,
      required super.grossProfit,
      required super.deliveredBySupplier,
      required super.weightPerUnit,
      required super.totalWeight,
      required super.warehouse,
      required super.prevdocDocname,
      required super.againstBlanketOrder,
      required super.blanketOrderRate,
      required super.projectedQty,
      required super.actualQty,
      required super.orderedQty,
      required super.plannedQty,
      required super.workOrderQty,
      required super.producedQty,
      required super.deliveredQty,
      required super.returnedQty,
      required super.pageBreak,
      required super.itemTaxRate,
      required super.transactionDate,
      required super.doctype,
      required super.unsaved});

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      name: json['name'],
      owner: json['owner'],
      creation: json['creation'],
      modified: json['modified'],
      modifiedBy: json['modified_by'],
      parent: json['parent'],
      parentfield: json['parentfield'],
      parenttype: json['parenttype'],
      idx: json['idx'],
      docstatus: json['docstatus'],
      itemCode: json['item_code'],
      ensureDeliveryBasedOnProducedSerialNo:
          json['ensure_delivery_based_on_produced_serial_no'],
      itemName: json['item_name'],
      description: json['description'],
      itemGroup: json['item_group'],
      image: json['image'],
      qty: json['qty'],
      stockUom: json['stock_uom'],
      pickedQty: json['picked_qty'],
      uom: json['uom'],
      conversionFactor: json['conversion_factor'],
      stockQty: json['stock_qty'],
      priceListRate: json['price_list_rate'],
      basePriceListRate: json['base_price_list_rate'],
      marginType: json['margin_type'],
      marginRateOrAmount: json['margin_rate_or_amount'],
      rateWithMargin: json['rate_with_margin'],
      discountPercentage: json['discount_percentage'],
      discountAmount: json['discount_amount'],
      baseRateWithMargin: json['base_rate_with_margin'],
      rate: json['rate'],
      amount: json['amount'],
      baseRate: json['base_rate'],
      baseAmount: json['base_amount'],
      stockUomRate: json['stock_uom_rate'],
      isFreeItem: json['is_free_item'],
      grantCommission: json['grant_commission'],
      netRate: json['net_rate'],
      netAmount: json['net_amount'],
      baseNetRate: json['base_net_rate'],
      baseNetAmount: json['base_net_amount'],
      billedAmt: json['billed_amt'],
      valuationRate: json['valuation_rate'],
      grossProfit: json['gross_profit'],
      deliveredBySupplier: json['delivered_by_supplier'],
      weightPerUnit: json['weight_per_unit'],
      totalWeight: json['total_weight'],
      warehouse: json['warehouse'],
      prevdocDocname: json['prevdoc_docname'],
      againstBlanketOrder: json['against_blanket_order'],
      blanketOrderRate: json['blanket_order_rate'],
      projectedQty: json['projected_qty'],
      actualQty: json['actual_qty'],
      orderedQty: json['ordered_qty'],
      plannedQty: json['planned_qty'],
      workOrderQty: json['work_order_qty'],
      producedQty: json['produced_qty'],
      deliveredQty: json['delivered_qty'],
      returnedQty: json['returned_qty'],
      pageBreak: json['page_break'],
      itemTaxRate: json['item_tax_rate'],
      transactionDate: json['transaction_date'],
      doctype: json['doctype'],
      unsaved: json['__unsaved'],
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
    map['item_code'] = itemCode;
    map['ensure_delivery_based_on_produced_serial_no'] =
        ensureDeliveryBasedOnProducedSerialNo;
    map['item_name'] = itemName;
    map['description'] = description;
    map['item_group'] = itemGroup;
    map['image'] = image;
    map['qty'] = qty;
    map['stock_uom'] = stockUom;
    map['picked_qty'] = pickedQty;
    map['uom'] = uom;
    map['conversion_factor'] = conversionFactor;
    map['stock_qty'] = stockQty;
    map['price_list_rate'] = priceListRate;
    map['base_price_list_rate'] = basePriceListRate;
    map['margin_type'] = marginType;
    map['margin_rate_or_amount'] = marginRateOrAmount;
    map['rate_with_margin'] = rateWithMargin;
    map['discount_percentage'] = discountPercentage;
    map['discount_amount'] = discountAmount;
    map['base_rate_with_margin'] = baseRateWithMargin;
    map['rate'] = rate;
    map['amount'] = amount;
    map['base_rate'] = baseRate;
    map['base_amount'] = baseAmount;
    map['stock_uom_rate'] = stockUomRate;
    map['is_free_item'] = isFreeItem;
    map['grant_commission'] = grantCommission;
    map['net_rate'] = netRate;
    map['net_amount'] = netAmount;
    map['base_net_rate'] = baseNetRate;
    map['base_net_amount'] = baseNetAmount;
    map['billed_amt'] = billedAmt;
    map['valuation_rate'] = valuationRate;
    map['gross_profit'] = grossProfit;
    map['delivered_by_supplier'] = deliveredBySupplier;
    map['weight_per_unit'] = weightPerUnit;
    map['total_weight'] = totalWeight;
    map['warehouse'] = warehouse;
    map['prevdoc_docname'] = prevdocDocname;
    map['against_blanket_order'] = againstBlanketOrder;
    map['blanket_order_rate'] = blanketOrderRate;
    map['projected_qty'] = projectedQty;
    map['actual_qty'] = actualQty;
    map['ordered_qty'] = orderedQty;
    map['planned_qty'] = plannedQty;
    map['work_order_qty'] = workOrderQty;
    map['produced_qty'] = producedQty;
    map['delivered_qty'] = deliveredQty;
    map['returned_qty'] = returnedQty;
    map['page_break'] = pageBreak;
    map['item_tax_rate'] = itemTaxRate;
    map['transaction_date'] = transactionDate;
    map['doctype'] = doctype;
    map['__unsaved'] = unsaved;
    return map;
  }
}
