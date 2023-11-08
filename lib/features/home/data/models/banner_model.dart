import '../../../../core/shared_functions.dart';
import '../../domain/entities/banner.dart';

import 'home_block_data_model.dart';

class BannerModel extends Banner implements HomeBlockDataModel {
  const BannerModel(
      {required super.bannerImage,
      required super.bannerType,
      required super.bannerView,
      required super.viewId,
      required super.bannerLink});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
        bannerImage: SharedFunctions.getImageUrl(json['banner_image']),
        bannerType: json['banner_type'],
        bannerView: json['banner_view'],
        viewId: json['view_id'],
        bannerLink: json['banner_link']);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['banner_image'] = bannerImage;
    map['banner_type'] = bannerType;
    map['banner_view'] = bannerView;
    map['view_id'] = viewId;
    map['banner_link'] = bannerLink;
    return map;
  }
}
