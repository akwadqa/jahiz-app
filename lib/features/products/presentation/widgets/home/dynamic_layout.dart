import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sliver_tools/sliver_tools.dart';

enum ViewType {
  banner('Banner'),
  circleList('Circle List'),
  grid('Grid'),
  horizontalScroll('Horizontal Scroll'),
  premium('Premium');

  const ViewType(this.name);
  final String name;
}

class DynamicLayout extends StatelessWidget {
  const DynamicLayout(
      {Key? key,
      required this.viewType,
      required this.itemBuilder,
      required this.count,
      this.heightOfHorizontalList = 200,
      this.title,
      this.onMoreButtonPressed,
      required this.backgroundColor})
      : super(key: key);
  final ViewType viewType;
  final Widget Function(BuildContext, int) itemBuilder;
  final int count;
  final double heightOfHorizontalList;
  final String? title;
  final VoidCallback? onMoreButtonPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    switch (viewType) {
      case ViewType.grid:
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: MultiSliver(
            children: [
              _TitleHeader(
                  title: title, onMoreButtonPressed: onMoreButtonPressed),
              SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 2 / 3),
                  delegate: SliverChildBuilderDelegate(itemBuilder,
                      childCount: count)),
            ],
          ),
        );
      case ViewType.circleList:
        return _HorizontalList(
            heightOfHorizontalList: heightOfHorizontalList,
            title: title!,
            itemCount: count,
            itemBuilder: itemBuilder,
            onMoreButtonPressed: onMoreButtonPressed!);
      case ViewType.horizontalScroll:
        return _HorizontalList(
            heightOfHorizontalList: 320,
            title: title!,
            itemCount: count,
            itemBuilder: itemBuilder,
            onMoreButtonPressed: onMoreButtonPressed!);
      default:
        return SliverStack(
          children: [
            SliverPositioned.fill(
              child: Container(
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(32)),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: MultiSliver(
                children: [
                  _TitleHeader(
                      title: title!, onMoreButtonPressed: onMoreButtonPressed!),
                  StaggeredGrid.count(
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    crossAxisCount: 6,
                    children: List.generate(count, (index) {
                      return StaggeredGridTile.count(
                          crossAxisCellCount: index % 3 == 0 ? 4 : 2,
                          mainAxisCellCount: index % 3 == 0 ? 6 : 3,
                          child: itemBuilder(context, index));
                    }),
                  )
                ],
              ),
            ),
          ],
        );
    }
  }
}

class _TitleHeader extends StatelessWidget {
  const _TitleHeader(
      {Key? key, required this.title, required this.onMoreButtonPressed})
      : super(key: key);
  final String? title;
  final VoidCallback? onMoreButtonPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (title != null)
          Text(title!,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold)),
        if (onMoreButtonPressed != null)
          IconButton(
              onPressed: onMoreButtonPressed,
              icon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all()),
                  child: const Icon(Icons.keyboard_arrow_down)))
      ],
    );
  }
}

class _HorizontalList extends StatelessWidget {
  const _HorizontalList(
      {Key? key,
      required this.heightOfHorizontalList,
      required this.title,
      required this.onMoreButtonPressed,
      required this.itemBuilder,
      required this.itemCount})
      : super(key: key);

  final double heightOfHorizontalList;
  final String title;
  final VoidCallback onMoreButtonPressed;
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _TitleHeader(
              title: title, onMoreButtonPressed: onMoreButtonPressed),
        ),
        SizedBox(
            height: heightOfHorizontalList,
            child: ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                itemBuilder: itemBuilder,
                itemCount: itemCount,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(width: 15))),
      ],
    ));
  }
}
