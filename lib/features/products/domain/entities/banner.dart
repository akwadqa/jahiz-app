import 'package:equatable/equatable.dart';
import 'package:jahiz/features/products/domain/entities/home_block_data.dart';

class Banner extends Equatable implements HomeBlockData {
  final String bannerImage;
  final String bannerType;
  final String? bannerView;
  final String? viewId;
  final String? bannerLink;

  const Banner(
      {required this.bannerImage,
      required this.bannerType,
      required this.bannerView,
      required this.viewId,
      required this.bannerLink});

  Banner copyWith({
    String? bannerImage,
    String? bannerType,
    String? bannerView,
    String? viewId,
    String? bannerLink,
  }) =>
      Banner(
        bannerImage: bannerImage ?? this.bannerImage,
        bannerType: bannerType ?? this.bannerType,
        bannerView: bannerView ?? this.bannerView,
        viewId: viewId ?? this.viewId,
        bannerLink: bannerLink ?? this.bannerLink,
      );

  @override
  List<Object?> get props =>
      [bannerImage, bannerType, bannerView, viewId, bannerLink];
}
