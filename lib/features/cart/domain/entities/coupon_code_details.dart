import 'package:equatable/equatable.dart';

import '../../data/models/Coupon_code_details_model.dart';

class CouponCodeDetails extends Equatable {
  final int error;
  final String couponStatus;
  final String couponMessage;

  const CouponCodeDetails(
      {required this.error,
      required this.couponStatus,
      required this.couponMessage});

  CouponCodeDetails copyWith(
      {int? error, String? couponStatus, String? couponMessage}) {
    return CouponCodeDetails(
        error: error ?? this.error,
        couponStatus: couponStatus ?? this.couponStatus,
        couponMessage: couponMessage ?? this.couponMessage);
  }

  CouponCodeDetailsModel toModel() {
    return CouponCodeDetailsModel(
        error: error, couponStatus: couponStatus, couponMessage: couponMessage);
  }

  @override
  List<Object?> get props => [error, couponStatus, couponMessage];
}
