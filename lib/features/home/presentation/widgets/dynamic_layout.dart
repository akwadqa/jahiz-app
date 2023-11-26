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
      required this.backgroundColor})
      : super(key: key);
  final ViewType viewType;
  final Widget Function(BuildContext, int) itemBuilder;
  final int count;
  final double heightOfHorizontalList;
  final String? title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    switch (viewType) {
      case ViewType.grid:
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: MultiSliver(
            children: [
              _TitledLayout(
                title: title,
                layoutWidget: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                            childAspectRatio: 2 / 3),
                    delegate: SliverChildBuilderDelegate(itemBuilder,
                        childCount: count)),
              ),
            ],
          ),
        );
      case ViewType.circleList:
        return _HorizontalList(
            heightOfHorizontalList: heightOfHorizontalList,
            title: title,
            itemCount: count,
            itemBuilder: itemBuilder);
      case ViewType.horizontalScroll:
        return _HorizontalList(
            heightOfHorizontalList: 320,
            title: title,
            itemCount: count,
            itemBuilder: itemBuilder);
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
                  _TitledLayout(
                    title: title!,
                    layoutWidget: StaggeredGrid.count(
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      crossAxisCount: 6,
                      children: List.generate(count, (index) {
                        return StaggeredGridTile.count(
                            crossAxisCellCount: index % 3 == 0 ? 4 : 2,
                            mainAxisCellCount: index % 3 == 0 ? 5 : 2.5,
                            child: itemBuilder(context, index));
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
    }
  }
}

enum _TitledLayoutType { sliver, boxAdapter }

class _TitledLayout extends StatefulWidget {
  const _TitledLayout(
      {Key? key,
      required this.title,
      required this.layoutWidget,
      this.titlePadding,
      this.type = _TitledLayoutType.sliver})
      : super(key: key);
  final String? title;
  final Widget layoutWidget;
  final EdgeInsetsGeometry? titlePadding;
  final _TitledLayoutType type;

  @override
  State<_TitledLayout> createState() => _TitledLayoutState();
}

class _TitledLayoutState extends State<_TitledLayout> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    if (widget.title == null) return widget.layoutWidget;
    return widget.type == _TitledLayoutType.sliver
        ? MultiSliver(
            children: [_title(context), if (isExpanded) widget.layoutWidget],
          )
        // ? MultiSliver(
        //     children: [
        //       ExpansionTile(
                
        //           title: (widget.title != null)
        //               ? Text(widget.title!,
        //                   style: Theme.of(context)
        //                       .textTheme
        //                       .titleLarge!
        //                       .copyWith(fontWeight: FontWeight.bold))
        //               : SizedBox.shrink(),
        //           initiallyExpanded: true,
        //           children: [widget.layoutWidget],
        //           collapsedShape: null),
        //     ],
        //   )
        : Column(
            children: [_title(context), if (isExpanded) widget.layoutWidget],
          );
        // : ExpansionTile(
        //     title: (widget.title != null)
        //         ? Text(widget.title!,
        // style: Theme.of(context)
        //     .textTheme
        //     .titleLarge!
        //     .copyWith(fontWeight: FontWeight.bold))
        //         : SizedBox.shrink(),
        //     trailing: null,
        //     initiallyExpanded: true,
        //     children: [widget.layoutWidget],
        //   );
        // : ExpansionPanelList(
          
        //     elevation: 1,
        //     expandedHeaderPadding: const EdgeInsets.symmetric(horizontal: 20),
        //     expansionCallback: (int index, bool isExpanded2) {
        //       setState(() {
        //         isExpanded = isExpanded2;
        //       });
        //     },
        //     children: [
        //         ExpansionPanel(
        //           headerBuilder: (BuildContext context, bool isExpanded) {
        //             return (widget.title != null)
        //                 ? Center(
        //                     child: Text(widget.title!,
        //                         style: Theme.of(context)
        //                             .textTheme
        //                             .titleLarge!
        //                             .copyWith(fontWeight: FontWeight.bold)),
        //                   )
        //                 : SizedBox.shrink();
        //           },
        //           body: widget.layoutWidget,
        //           isExpanded: isExpanded,
        //         )
        //       ]);
    // Column(children:[_title(context), if(isExpanded) widget.layoutWidget]),
    // ExpansionPanelList.radio(
    //     elevation: 1,
    //     expandedHeaderPadding: EdgeInsets.all(0),
    //     expansionCallback: (int index, bool isExpanded2) {
    //       setState(() {
    //         isExpanded = isExpanded2;
    //       });
    //     },
    //     children: [
    //       ExpansionPanel(
    //         headerBuilder: (BuildContext context, bool isExpanded) {
    //           return const Text("item.headerValue");
    //         },
    //         body: widget.layoutWidget,
    //         isExpanded: isExpanded,
    //       )
    //     ]);
  }

  Padding _title(BuildContext context) {
    return Padding(
      padding: widget.titlePadding ?? const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.title != null)
            Text(widget.title!,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
          IconButton(
              onPressed: () {
                setState(() {
                  isExpanded = !isExpanded;
                });
              },
              icon: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all()),
                  child: Icon(isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up)))
        ],
      ),
    );
  }
}

class _HorizontalList extends StatelessWidget {
  const _HorizontalList(
      {Key? key,
      required this.heightOfHorizontalList,
      required this.title,
      required this.itemBuilder,
      required this.itemCount})
      : super(key: key);

  final double heightOfHorizontalList;
  final String? title;
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Column(
      children: [
        _TitledLayout(
          title: title,
          type: _TitledLayoutType.boxAdapter,
          titlePadding: const EdgeInsets.symmetric(horizontal: 20),
          layoutWidget: SizedBox(
              height: heightOfHorizontalList,
              child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  itemBuilder: itemBuilder,
                  itemCount: itemCount,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(width: 15))),
        ),
      ],
    ));
  }
}
