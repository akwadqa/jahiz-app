import 'package:flutter/material.dart';
import 'package:jahiz/features/home/domain/entities/home_block.dart';
import '../../../../core/shared_functions.dart';
import '../../../../core/widgets/app_cached_network_image.dart';
import 'package:jahiz/features/home/domain/entities/category.dart';
import 'package:jahiz/features/home/presentation/widgets/home/dynamic_layout.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView(
      {Key? key, required this.categoriesBlock, required this.isNotLast})
      : super(key: key);
  final HomeBlock<Category> categoriesBlock;
  final bool isNotLast;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.zero,
      sliver: DynamicLayout(
        heightOfHorizontalList: 144,
        viewType: ViewType.values
            .firstWhere((element) => element.name == categoriesBlock.view),
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor:
                        SharedFunctions.getColor(categoriesBlock.background),
                  ),
                  AppCachedNetworkImage(
                      imageUrl: categoriesBlock.data[index].categoryImage,
                      width: 72,
                      height: 72)
                ],
              ),
              SizedBox(
                width: 95,
                child: Text(categoriesBlock.data[index].categoryTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black, fontSize: 18)),
              )
            ],
          );
        },
        count: categoriesBlock.data.length,
        backgroundColor: SharedFunctions.getColor(categoriesBlock.background),
      ),
    );
  }
}
