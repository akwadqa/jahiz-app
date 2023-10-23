import '../../domain/entities/coupon_code_details.dart';

class CouponCodeDetailsModel extends CouponCodeDetails {
  const CouponCodeDetailsModel(
      {required super.error,
      required super.couponStatus,
      required super.couponMessage});

  factory CouponCodeDetailsModel.fromJson(Map<String, dynamic> json) {
    return CouponCodeDetailsModel(
        error: json['error'],
        couponStatus: json['coupon_status'],
        couponMessage: json['coupon_message']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = error;
    map['coupon_status'] = couponStatus;
    map['coupon_message'] = couponMessage;
    return map;
  }
}
