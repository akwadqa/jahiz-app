import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/blocs/slider_indicator_cubit.dart';
import 'package:jahiz/core/theme/app_colors.dart';
import 'package:jahiz/core/widgets/app_cached_network_image.dart';
import 'package:jahiz/core/widgets/contained_button.dart';
import 'package:jahiz/core/widgets/custom_back_button.dart';
import 'package:jahiz/features/products/domain/entities/additional_image.dart';
import 'package:jahiz/features/products/domain/entities/detailed_product.dart';

class ProductDetailsSliverAppBar extends StatelessWidget {
  const ProductDetailsSliverAppBar({Key? key, required this.detailedProduct})
      : super(key: key);
  final DetailedProduct detailedProduct;

  @override
  Widget build(BuildContext context) {
    final images = [
      ...detailedProduct.additionalImages,
      AdditionalImage(
          image: detailedProduct.websiteImage,
          heading: '',
          description: '',
          url: '')
    ];
    return SliverAppBar(
      leading: const CustomBackButton(),
      backgroundColor: Theme.of(context).primaryColor,
      pinned: true,
      actions: [
        ContainedButton(
          icon: const Icon(Icons.favorite_border),
          margin: const EdgeInsets.all(8.0),
          onPressed: () {},
        ),
        ContainedButton(
          icon: const Icon(Icons.share),
          margin: const EdgeInsets.all(8.0),
          onPressed: () {},
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.expand,
          children: [
            CarouselSlider(
              items: images
                  .map((image) => SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: AppCachedNetworkImage(imageUrl: image.image)))
                  .toList(),
              options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 1,
                  height: double.infinity,
                  onPageChanged: (page, _) =>
                      context.read<SliderIndicatorCubit>().page = page),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocBuilder<SliderIndicatorCubit, int>(
                      builder: (context, state) {
                    return DotsIndicator(
                      dotsCount: images.length,
                      position: state,
                    );
                  }),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadiusDirectional.only(
                            topEnd: Radius.circular(40),
                            topStart: Radius.circular(40)),
                        boxShadow: [
                          BoxShadow(blurRadius: 6, color: AppColors.shadowColor)
                        ]),
                    height: 30,
                  ),
                ],
              ),
            ),
            if (detailedProduct.discountAmount > 0)
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Container(
                  decoration: const BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(10),
                          bottomEnd: Radius.circular(10))),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Text(detailedProduct.discountPercent,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold)),
                ),
              )
          ],
        ),
      ),
      expandedHeight: 370,
    );
  }
}
