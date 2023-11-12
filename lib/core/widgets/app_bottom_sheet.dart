import 'package:flutter/material.dart';
import 'custom_back_button.dart';

import '../theme/app_colors.dart';

Future<dynamic> showAppBottomSheet(
    {required BuildContext context,
    required Widget child,
    double? height,
    bool enableDrag = true}) async {
  return await showModalBottomSheet(
    enableDrag: enableDrag,
    context: context,
    builder: (context) {
      return SizedBox(
        height: height ?? MediaQuery.of(context).size.height * 0.90,
        child: child,
      );
    },
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40))),
    clipBehavior: Clip.antiAlias,
    isScrollControlled: true,
  );
}

class AppBottomSheetSkeleton extends StatelessWidget {
  const AppBottomSheetSkeleton(
      {Key? key,
      required this.title,
      this.subtitle,
      required this.content,
      this.submitButton,
      this.isShowBackButton = true,
      this.scrollPhysics,
      this.isSliverContent = false,
      this.stackedSubmitButton})
      : super(key: key);
  final String title;
  final String? subtitle;
  final Widget content;
  final Widget? submitButton;
  final bool isShowBackButton;
  final ScrollPhysics? scrollPhysics;
  final bool isSliverContent;
  final Widget? stackedSubmitButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          const SizedBox(height: 20.0),
          Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3.0)),
                color: AppColors.lightShadeOfGray),
            height: 6.0,
            width: 120,
          ),
          const SizedBox(height: 20.0),
          Expanded(
            child: Stack(
              children: [
                CustomScrollView(
                  physics: scrollPhysics,
                  slivers: [
                    if (isSliverContent) ...[
                      SliverToBoxAdapter(
                          child: _Header(
                              title: title,
                              subtitle: subtitle,
                              isShowBackButton: isShowBackButton)),
                      SliverFillRemaining(
                        child: Column(
                          children: [
                            Expanded(child: content),
                            if (submitButton != null) submitButton!,
                            const SizedBox(height: 20)
                          ],
                        ),
                      ),
                      if (submitButton != null)
                        SliverToBoxAdapter(child: submitButton!),
                      const SliverToBoxAdapter(child: SizedBox(height: 20.0)),
                    ] else
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Column(
                          children: [
                            _Header(
                                isShowBackButton: isShowBackButton,
                                title: title,
                                subtitle: subtitle),
                            Expanded(child: content),
                            if (submitButton != null) submitButton!,
                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                  ],
                ),
                if (stackedSubmitButton != null)
                  Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: stackedSubmitButton!,
                      ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(
      {Key? key,
      required this.isShowBackButton,
      required this.title,
      required this.subtitle})
      : super(key: key);
  final bool isShowBackButton;
  final String title;
  final String? subtitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isShowBackButton
            ? Row(
                children: [
                  const Expanded(child: CustomBackButton()),
                  Expanded(flex: 3, child: _TitleText(title: title)),
                  const Spacer()
                ],
              )
            : _TitleText(title: title),
        if (subtitle != null) ...[
          const SizedBox(height: 16.0),
          Text(subtitle!,
              style: const TextStyle(fontSize: 18, color: Colors.black)),
        ],
      ],
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(title,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black)));
  }
}
