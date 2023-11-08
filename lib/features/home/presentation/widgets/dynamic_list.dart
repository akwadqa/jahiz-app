import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/features/home/domain/entities/home_block.dart';
import 'package:jahiz/features/home/domain/entities/home_block_data.dart';
import 'package:jahiz/features/home/presentation/blocs/home_cubit.dart';
import 'dynamic_item.dart';


class DynamicList extends StatelessWidget {
  const DynamicList({Key? key, required this.homeBlocks}) : super(key: key);
  final List<HomeBlock<HomeBlockData>> homeBlocks;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: context.read<HomeCubit>().getHomeBlocks,
      child: CustomScrollView(
        slivers: homeBlocks
            .map((e) => SliverPadding(
                padding: EdgeInsetsDirectional.only(
                    top: homeBlocks.indexOf(e) == 0 ? 10 : 0,
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
