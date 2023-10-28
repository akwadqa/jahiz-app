import 'package:jahiz/features/orders/data/models/payment_schedule_model.dart';
import 'package:jahiz/features/orders/data/models/taxes_model.dart';
import 'package:jahiz/features/orders/domain/entities/order.dart';
import 'order_item_model.dart';

class OrderModel extends Order {
  const OrderModel(
      {required super.name,
      required super.owner,
      required super.creation,
      required super.modified,
      required super.modifiedBy,
      required super.idx,
      required super.docstatus,
      required super.title,
      required super.namingSeries,
      required super.customer,
      required super.customerName,
      required super.orderType,
      required super.skipDeliveryNote,
      required super.company,
      required super.transactionDate,
      required super.akdPostingTime,
      required super.customerAddress,
      required super.addressDisplay,
      required super.contactPerson,
      required super.contactDisplay,
      required super.contactPhone,
      required super.contactMobile,
      required super.contactEmail,
      required super.shippingAddressName,
      required super.shippingAddress,
      required super.customerGroup,
      required super.territory,
      required super.currency,
      required super.conversionRate,
      required super.sellingPriceList,
      required super.priceListCurrency,
      required super.plcConversionRate,
      required super.ignorePricingRule,
      required super.totalQty,
      required super.baseTotal,
      required super.baseNetTotal,
      required super.totalNetWeight,
      required super.total,
      required super.netTotal,
      required super.taxCategory,
      required super.shippingRule,
      required super.otherChargesCalculation,
      required super.baseTotalTaxesAndCharges,
      required super.totalTaxesAndCharges,
      required super.loyaltyPoints,
      required super.loyaltyAmount,
      required super.applyDiscountOn,
      required super.baseDiscountAmount,
      required super.additionalDiscountPercentage,
      required super.discountAmount,
      required super.baseGrandTotal,
      required super.baseRoundingAdjustment,
      required super.baseRoundedTotal,
      required super.baseInWords,
      required super.grandTotal,
      required super.roundingAdjustment,
      required super.roundedTotal,
      required super.inWords,
      required super.advancePaid,
      required super.disableRoundedTotal,
      required super.isInternalCustomer,
      required super.language,
      required super.letterHead,
      required super.groupSameItems,
      required super.status,
      required super.deliveryStatus,
      required super.perDelivered,
      required super.perBilled,
      required super.perPicked,
      required super.billingStatus,
      required super.amountEligibleForCommission,
      required super.commissionRate,
      required super.totalCommission,
      required super.doctype,
      required super.items,
      required super.packedItems,
      required super.pricingRules,
      required super.taxes,
      required super.paymentSchedule,
      required super.salesTeam});

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      name: json['name'],
      owner: json['owner'],
      creation: json['creation'],
      modified: json['modified'],
      modifiedBy: json['modified_by'],
      idx: json['idx'],
      docstatus: json['docstatus'],
      title: json['title'],
      namingSeries: json['naming_series'],
      customer: json['customer'],
      customerName: json['customer_name'],
      orderType: json['order_type'],
      skipDeliveryNote: json['skip_delivery_note'],
      company: json['company'],
      transactionDate: json['transaction_date'],
      akdPostingTime: json['akd_posting_time'],
      customerAddress: json['customer_address'],
      addressDisplay: json['address_display'],
      contactPerson: json['contact_person'],
      contactDisplay: json['contact_display'],
      contactPhone: json['contact_phone'],
      contactMobile: json['contact_mobile'],
      contactEmail: json['contact_email'],
      shippingAddressName: json['shipping_address_name'],
      shippingAddress: json['shipping_address'],
      customerGroup: json['customer_group'],
      territory: json['territory'],
      currency: json['currency'],
      conversionRate: json['conversion_rate'],
      sellingPriceList: json['selling_price_list'],
      priceListCurrency: json['price_list_currency'],
      plcConversionRate: json['plc_conversion_rate'],
      ignorePricingRule: json['ignore_pricing_rule'],
      totalQty: json['total_qty'],
      baseTotal: json['base_total'],
      baseNetTotal: json['base_net_total'],
      totalNetWeight: json['total_net_weight'],
      total: json['total'],
      netTotal: json['net_total'],
      taxCategory: json['tax_category'],
      shippingRule: json['shipping_rule'],
      otherChargesCalculation: json['other_charges_calculation'],
      baseTotalTaxesAndCharges: json['base_total_taxes_and_charges'],
      totalTaxesAndCharges: json['total_taxes_and_charges'],
      loyaltyPoints: json['loyalty_points'],
      loyaltyAmount: json['loyalty_amount'],
      applyDiscountOn: json['apply_discount_on'],
      baseDiscountAmount: json['base_discount_amount'],
      additionalDiscountPercentage: json['additional_discount_percentage'],
      discountAmount: json['discount_amount'],
      baseGrandTotal: json['base_grand_total'],
      baseRoundingAdjustment: json['base_rounding_adjustment'],
      baseRoundedTotal: json['base_rounded_total'],
      baseInWords: json['base_in_words'],
      grandTotal: json['grand_total'],
      roundingAdjustment: json['rounding_adjustment'],
      roundedTotal: json['rounded_total'],
      inWords: json['in_words'],
      advancePaid: json['advance_paid'],
      disableRoundedTotal: json['disable_rounded_total'],
      isInternalCustomer: json['is_internal_customer'],
      language: json['language'],
      letterHead: json['letter_head'],
      groupSameItems: json['group_same_items'],
      status: json['status'],
      deliveryStatus: json['delivery_status'],
      perDelivered: json['per_delivered'],
      perBilled: json['per_billed'],
      perPicked: json['per_picked'],
      billingStatus: json['billing_status'],
      amountEligibleForCommission: json['amount_eligible_for_commission'],
      commissionRate: json['commission_rate'],
      totalCommission: json['total_commission'],
      doctype: json['doctype'],
      items: (json['items'] as List)
          .map((e) => OrderItemModel.fromJson(e))
          .toList(),
      packedItems: json['packed_items'],
      pricingRules: json['pricing_rules'],
      taxes:
          (json['taxes'] as List).map((e) => TaxesModel.fromJson(e)).toList(),
      paymentSchedule: (json['payment_schedule'] as List)
          .map((e) => PaymentScheduleModel.fromJson(e))
          .toList(),
      salesTeam: json['sales_team'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['owner'] = owner;
    map['creation'] = creation;
    map['modified'] = modified;
    map['modified_by'] = modifiedBy;
    map['idx'] = idx;
    map['docstatus'] = docstatus;
    map['title'] = title;
    map['naming_series'] = namingSeries;
    map['customer'] = customer;
    map['customer_name'] = customerName;
    map['order_type'] = orderType;
    map['skip_delivery_note'] = skipDeliveryNote;
    map['company'] = company;
    map['transaction_date'] = transactionDate;
    map['akd_posting_time'] = akdPostingTime;
    map['customer_address'] = customerAddress;
    map['address_display'] = addressDisplay;
    map['contact_person'] = contactPerson;
    map['contact_display'] = contactDisplay;
    map['contact_phone'] = contactPhone;
    map['contact_mobile'] = contactMobile;
    map['contact_email'] = contactEmail;
    map['shipping_address_name'] = shippingAddressName;
    map['shipping_address'] = shippingAddress;
    map['customer_group'] = customerGroup;
    map['territory'] = territory;
    map['currency'] = currency;
    map['conversion_rate'] = conversionRate;
    map['selling_price_list'] = sellingPriceList;
    map['price_list_currency'] = priceListCurrency;
    map['plc_conversion_rate'] = plcConversionRate;
    map['ignore_pricing_rule'] = ignorePricingRule;
    map['total_qty'] = totalQty;
    map['base_total'] = baseTotal;
    map['base_net_total'] = baseNetTotal;
    map['total_net_weight'] = totalNetWeight;
    map['total'] = total;
    map['net_total'] = netTotal;
    map['tax_category'] = taxCategory;
    map['shipping_rule'] = shippingRule;
    map['other_charges_calculation'] = otherChargesCalculation;
    map['base_total_taxes_and_charges'] = baseTotalTaxesAndCharges;
    map['total_taxes_and_charges'] = totalTaxesAndCharges;
    map['loyalty_points'] = loyaltyPoints;
    map['loyalty_amount'] = loyaltyAmount;
    map['apply_discount_on'] = applyDiscountOn;
    map['base_discount_amount'] = baseDiscountAmount;
    map['additional_discount_percentage'] = additionalDiscountPercentage;
    map['discount_amount'] = discountAmount;
    map['base_grand_total'] = baseGrandTotal;
    map['base_rounding_adjustment'] = baseRoundingAdjustment;
    map['base_rounded_total'] = baseRoundedTotal;
    map['base_in_words'] = baseInWords;
    map['grand_total'] = grandTotal;
    map['rounding_adjustment'] = roundingAdjustment;
    map['rounded_total'] = roundedTotal;
    map['in_words'] = inWords;
    map['advance_paid'] = advancePaid;
    map['disable_rounded_total'] = disableRoundedTotal;
    map['is_internal_customer'] = isInternalCustomer;
    map['language'] = language;
    map['letter_head'] = letterHead;
    map['group_same_items'] = groupSameItems;
    map['status'] = status;
    map['delivery_status'] = deliveryStatus;
    map['per_delivered'] = perDelivered;
    map['per_billed'] = perBilled;
    map['per_picked'] = perPicked;
    map['billing_status'] = billingStatus;
    map['amount_eligible_for_commission'] = amountEligibleForCommission;
    map['commission_rate'] = commissionRate;
    map['total_commission'] = totalCommission;
    map['doctype'] = doctype;
    map['items'] = items.map((v) => (v as OrderItemModel).toJson()).toList();
    map['packed_items'] = packedItems.map((v) => v.toJson()).toList();
    map['pricing_rules'] = pricingRules.map((v) => v.toJson()).toList();
    map['taxes'] = taxes.map((v) => (v as TaxesModel).toJson()).toList();
    map['payment_schedule'] = paymentSchedule
        .map((v) => (v as PaymentScheduleModel).toJson())
        .toList();
    map['sales_team'] = salesTeam.map((v) => v.toJson()).toList();
    return map;
  }
}
