import 'package:equatable/equatable.dart';
import 'package:jahiz/features/orders/domain/entities/payment_schedule.dart';
import 'package:jahiz/features/orders/domain/entities/taxes.dart';
import 'order_item.dart';

class Order extends Equatable {
  final String name;
  final String owner;
  final String creation;
  final String modified;
  final String modifiedBy;
  final int idx;
  final int docstatus;
  final String title;
  final String namingSeries;
  final String customer;
  final String customerName;
  final String orderType;
  final int skipDeliveryNote;
  final String company;
  final String transactionDate;
  final String akdPostingTime;
  final String customerAddress;
  final String addressDisplay;
  final String contactPerson;
  final String contactDisplay;
  final String contactPhone;
  final String contactMobile;
  final String contactEmail;
  final String shippingAddressName;
  final String shippingAddress;
  final String customerGroup;
  final String territory;
  final String currency;
  final double conversionRate;
  final String sellingPriceList;
  final String priceListCurrency;
  final double plcConversionRate;
  final int ignorePricingRule;
  final double totalQty;
  final double baseTotal;
  final double baseNetTotal;
  final double totalNetWeight;
  final double total;
  final double netTotal;
  final String taxCategory;
  final String? shippingRule;
  final String? otherChargesCalculation;
  final double baseTotalTaxesAndCharges;
  final double totalTaxesAndCharges;
  final int loyaltyPoints;
  final double loyaltyAmount;
  final String applyDiscountOn;
  final double baseDiscountAmount;
  final double additionalDiscountPercentage;
  final double discountAmount;
  final double baseGrandTotal;
  final double baseRoundingAdjustment;
  final double baseRoundedTotal;
  final String baseInWords;
  final double grandTotal;
  final double roundingAdjustment;
  final double roundedTotal;
  final String inWords;
  final double advancePaid;
  final int disableRoundedTotal;
  final int isInternalCustomer;
  final String language;
  final String? letterHead;
  final int groupSameItems;
  final String status;
  final String deliveryStatus;
  final double perDelivered;
  final double perBilled;
  final double perPicked;
  final String billingStatus;
  final double amountEligibleForCommission;
  final double commissionRate;
  final double totalCommission;
  final String doctype;
  final List<OrderItem> items;
  final List<dynamic> packedItems;
  final List<dynamic> pricingRules;
  final List<Taxes> taxes;
  final List<PaymentSchedule> paymentSchedule;
  final List<dynamic> salesTeam;

  const Order({
    required this.name,
    required this.owner,
    required this.creation,
    required this.modified,
    required this.modifiedBy,
    required this.idx,
    required this.docstatus,
    required this.title,
    required this.namingSeries,
    required this.customer,
    required this.customerName,
    required this.orderType,
    required this.skipDeliveryNote,
    required this.company,
    required this.transactionDate,
    required this.akdPostingTime,
    required this.customerAddress,
    required this.addressDisplay,
    required this.contactPerson,
    required this.contactDisplay,
    required this.contactPhone,
    required this.contactMobile,
    required this.contactEmail,
    required this.shippingAddressName,
    required this.shippingAddress,
    required this.customerGroup,
    required this.territory,
    required this.currency,
    required this.conversionRate,
    required this.sellingPriceList,
    required this.priceListCurrency,
    required this.plcConversionRate,
    required this.ignorePricingRule,
    required this.totalQty,
    required this.baseTotal,
    required this.baseNetTotal,
    required this.totalNetWeight,
    required this.total,
    required this.netTotal,
    required this.taxCategory,
    required this.shippingRule,
    required this.otherChargesCalculation,
    required this.baseTotalTaxesAndCharges,
    required this.totalTaxesAndCharges,
    required this.loyaltyPoints,
    required this.loyaltyAmount,
    required this.applyDiscountOn,
    required this.baseDiscountAmount,
    required this.additionalDiscountPercentage,
    required this.discountAmount,
    required this.baseGrandTotal,
    required this.baseRoundingAdjustment,
    required this.baseRoundedTotal,
    required this.baseInWords,
    required this.grandTotal,
    required this.roundingAdjustment,
    required this.roundedTotal,
    required this.inWords,
    required this.advancePaid,
    required this.disableRoundedTotal,
    required this.isInternalCustomer,
    required this.language,
    required this.letterHead,
    required this.groupSameItems,
    required this.status,
    required this.deliveryStatus,
    required this.perDelivered,
    required this.perBilled,
    required this.perPicked,
    required this.billingStatus,
    required this.amountEligibleForCommission,
    required this.commissionRate,
    required this.totalCommission,
    required this.doctype,
    required this.items,
    required this.packedItems,
    required this.pricingRules,
    required this.taxes,
    required this.paymentSchedule,
    required this.salesTeam,
  });

  @override
  List<Object?> get props => [
        name,
        owner,
        creation,
        modified,
        modifiedBy,
        idx,
        docstatus,
        title,
        namingSeries,
        customer,
        customerName,
        orderType,
        skipDeliveryNote,
        company,
        transactionDate,
        akdPostingTime,
        customerAddress,
        addressDisplay,
        contactPerson,
        contactDisplay,
        contactPhone,
        contactMobile,
        contactEmail,
        shippingAddressName,
        shippingAddress,
        customerGroup,
        territory,
        currency,
        conversionRate,
        sellingPriceList,
        priceListCurrency,
        plcConversionRate,
        ignorePricingRule,
        totalQty,
        baseTotal,
        baseNetTotal,
        totalNetWeight,
        total,
        netTotal,
        taxCategory,
        shippingRule,
        otherChargesCalculation,
        baseTotalTaxesAndCharges,
        totalTaxesAndCharges,
        loyaltyPoints,
        loyaltyAmount,
        applyDiscountOn,
        baseDiscountAmount,
        additionalDiscountPercentage,
        discountAmount,
        baseGrandTotal,
        baseRoundingAdjustment,
        baseRoundedTotal,
        baseInWords,
        grandTotal,
        roundingAdjustment,
        roundedTotal,
        inWords,
        advancePaid,
        disableRoundedTotal,
        isInternalCustomer,
        language,
        letterHead,
        groupSameItems,
        status,
        deliveryStatus,
        perDelivered,
        perBilled,
        perPicked,
        billingStatus,
        amountEligibleForCommission,
        commissionRate,
        totalCommission,
        doctype,
        items,
        packedItems,
        pricingRules,
        taxes,
        paymentSchedule,
        salesTeam,
      ];
}
