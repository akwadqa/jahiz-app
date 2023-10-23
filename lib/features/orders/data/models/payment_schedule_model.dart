import '../../domain/entities/payment_schedule.dart';

class PaymentScheduleModel extends PaymentSchedule {
  const PaymentScheduleModel(
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
      required super.dueDate,
      required super.invoicePortion,
      required super.discountType,
      required super.discount,
      required super.paymentAmount,
      required super.outstanding,
      required super.paidAmount,
      required super.discountedAmount,
      required super.basePaymentAmount,
      required super.doctype,
      required super.unsaved});

  factory PaymentScheduleModel.fromJson(Map<String, dynamic> json) {
    return PaymentScheduleModel(
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
      dueDate: json['due_date'],
      invoicePortion: json['invoice_portion'],
      discountType: json['discount_type'],
      discount: json['discount'],
      paymentAmount: json['payment_amount'],
      outstanding: json['outstanding'],
      paidAmount: json['paid_amount'],
      discountedAmount: json['discounted_amount'],
      basePaymentAmount: json['base_payment_amount'],
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
    map['due_date'] = dueDate;
    map['invoice_portion'] = invoicePortion;
    map['discount_type'] = discountType;
    map['discount'] = discount;
    map['payment_amount'] = paymentAmount;
    map['outstanding'] = outstanding;
    map['paid_amount'] = paidAmount;
    map['discounted_amount'] = discountedAmount;
    map['base_payment_amount'] = basePaymentAmount;
    map['doctype'] = doctype;
    map['__unsaved'] = unsaved;
    return map;
  }
}
