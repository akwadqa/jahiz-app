import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/features/products/presentation/bloc/home/home_cubit.dart';
import 'package:jahiz/features/products/presentation/widgets/home/dynamic_item.dart';

import '../../../domain/entities/home_block.dart';
import '../../../domain/entities/home_block_data.dart';

class DynamicList extends StatelessWidget {
  const DynamicList({Key? key, required this.homeBlocks}) : super(key: key);
  final List<HomeBlock<HomeBlockData>> homeBlocks;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: context.read<HomeCubit>().getHomeBlocks,
      child: CustomScrollView(
        slivers: homeBlocks
            .map((e) => SliverPadding(
                padding: EdgeInsetsDirectional.only(
                    top: homeBlocks.indexOf(e) == 0 ? 30 : 0,
                    bottom: homeBlocks.indexOf(e) == homeBlocks.length - 1
                        ? 100
                        : 0),
                sliver: DynamicItem(
                    homeBlock: e,
                    isNotLast: homeBlocks.indexOf(e) != homeBlocks.length - 1)))
            .toList(),
      ),
    );
  }
}
