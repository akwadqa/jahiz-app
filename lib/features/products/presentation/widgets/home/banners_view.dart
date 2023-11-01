import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/shared_functions.dart';
import 'package:jahiz/features/products/domain/entities/banner.dart'
    as banner_entity;
import 'package:jahiz/core/blocs/slider_indicator_cubit.dart';

import '../../../../../core/widgets/app_cached_network_image.dart';
import '../../../domain/entities/home_block.dart';

class BannersView extends StatelessWidget {
  const BannersView(
      {Key? key, required this.bannersBlock, required this.isNotLast})
      : super(key: key);
  final HomeBlock<banner_entity.Banner> bannersBlock;
  final bool isNotLast;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Container(
              height: 144,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: SharedFunctions.getColor(bannersBlock.background)),
              clipBehavior: Clip.antiAlias,
              child: CarouselSlider.builder(
                itemCount: bannersBlock.data.length,
                itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) =>
                    SizedBox(
                        width: double.infinity,
                        child: AppCachedNetworkImage(
                          imageUrl: bannersBlock.data[itemIndex].bannerImage,
                          fit: BoxFit.fitWidth,
                        )),
                options: CarouselOptions(
                  onPageChanged: (page, _) =>
                      context.read<SliderIndicatorCubit>().page = page,
                  viewportFraction: 1.0,
                  autoPlay: true,
                ),
              ),
            ),
            BlocBuilder<SliderIndicatorCubit, int>(builder: (context, state) {
              return DotsIndicator(
                dotsCount: bannersBlock.data.length,
                position: state,
              );
            }),
            if (isNotLast) const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
