import 'package:equatable/equatable.dart';

class PaymentSchedule extends Equatable {
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
  final String dueDate;
  final double invoicePortion;
  final String discountType;
  final double discount;
  final double paymentAmount;
  final double outstanding;
  final double paidAmount;
  final double discountedAmount;
  final double basePaymentAmount;
  final String doctype;
  final int unsaved;

  const PaymentSchedule(
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
      required this.dueDate,
      required this.invoicePortion,
      required this.discountType,
      required this.discount,
      required this.paymentAmount,
      required this.outstanding,
      required this.paidAmount,
      required this.discountedAmount,
      required this.basePaymentAmount,
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
        dueDate,
        invoicePortion,
        discountType,
        discount,
        paymentAmount,
        outstanding,
        paidAmount,
        discountedAmount,
        basePaymentAmount,
        doctype,
        unsaved
      ];
}
