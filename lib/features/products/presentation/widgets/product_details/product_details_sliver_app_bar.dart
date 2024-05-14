import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/features/products/domain/entities/product.dart';
import 'package:jahiz/features/products/presentation/bloc/detailed_product/detailed_product_cubit.dart';
import '../../../../../core/app_constants.dart';
import '../../../../../core/blocs/slider_indicator_cubit.dart';
import '../../../../../core/gen/assets.gen.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/app_cached_network_image.dart';
import '../../../../../core/widgets/contained_button.dart';
import '../../../../../core/widgets/custom_back_button.dart';
import '../../../../home/domain/entities/additional_image.dart';
import '../../../domain/entities/detailed_product.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailsSliverAppBar extends StatelessWidget {
  const ProductDetailsSliverAppBar(
      {super.key,
      required this.detailedProductState,
      required this.product,
      required this.heroTag});
  final DetailedProductState detailedProductState;
  final Product product;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).primaryColor,
      pinned: true,
      actions: [_ShareButton()],
      flexibleSpace: FlexibleSpaceBar(
          background: detailedProductState is DetailedProductLoadSuccess
              ? Hero(
                  tag: heroTag,
                  child: _CarouselWithDots(
                      detailedProduct:
                          (detailedProductState as DetailedProductLoadSuccess)
                              .detailedProduct),
                )
              : Hero(
                  tag: heroTag,
                  child: AppCachedNetworkImage(
                      imageUrl: product.productImage, fit: BoxFit.cover),
                )),
      expandedHeight: 400,
    );
  }
}

class _ShareButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContainedButton(
      icon: Assets.images.shareSvg.svg(),
      margin: const EdgeInsets.all(9.0),
      onPressed: () => Share.share(AppConstants.hostUrl),
    );
  }
}

class _CarouselWithDots extends StatelessWidget {
  final DetailedProduct detailedProduct;

  const _CarouselWithDots({required this.detailedProduct});

  @override
  Widget build(BuildContext context) {
    final images = _buildImageList();
    return Stack(
      alignment: AlignmentDirectional.center,
      fit: StackFit.expand,
      children: [
        _ImageCarousel(images: images),
        _DotsIndicatorWidget(images: images),
        if (detailedProduct.discountAmount > 0)
          _DiscountBadge(discountPercent: detailedProduct.discountPercent),
      ],
    );
  }

  List<Widget> _buildImageList() {
    return [
      AdditionalImage(
        image: detailedProduct.websiteImage,
        heading: '',
        description: '',
        url: '',
      ),
      ...detailedProduct.additionalImages.map(
        (e) => AdditionalImage(
          image: "${AppConstants.hostUrl}${e.image}",
          heading: null,
          description: '',
          url: '',
        ),
      ),
    ]
        .map((image) => SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: AppCachedNetworkImage(
                  imageUrl: image.image, fit: BoxFit.cover),
            ))
        .toList();
  }
}

class _ImageCarousel extends StatelessWidget {
  final List<Widget> images;

  const _ImageCarousel({required this.images});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: images,
      options: CarouselOptions(
        autoPlay: images.length > 1 ? true : false,
        enableInfiniteScroll: images.length > 1 ? true : false,
        viewportFraction: 1,
        height: double.infinity,
        onPageChanged: (page, _) =>
            context.read<SliderIndicatorCubit>().page = page,
      ),
    );
  }
}

class _DotsIndicatorWidget extends StatelessWidget {
  final List<Widget> images;

  const _DotsIndicatorWidget({required this.images});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomCenter,
      child: BlocBuilder<SliderIndicatorCubit, int>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 100,
            ),
            child: DotsIndicator(
              dotsCount: images.length,
              position: state,
            ),
          );
        },
      ),
    );
  }
}

class _DiscountBadge extends StatelessWidget {
  final String discountPercent;

  const _DiscountBadge({required this.discountPercent});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(10),
            bottomEnd: Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Text(
          discountPercent,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
