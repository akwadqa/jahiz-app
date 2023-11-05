import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jahiz/core/theme/app_colors.dart';
import 'package:jahiz/features/cart/application/cart_count_cubit.dart';

import '../../../../core/gen/assets.gen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar(
      {Key? key,
      required this.currentIndex,
      required this.onPressed,
      required this.labels})
      : super(key: key);
  final int currentIndex;
  final void Function(int index) onPressed;
  final List<String> labels;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _BnbIcon(
                onPressed: () => onPressed(0),
                label: labels[0],
                icon: Assets.images.outlinedHomeIcon,
                isSelected: currentIndex == 0),
            _BnbIcon(
                onPressed: () => onPressed(1),
                label: labels[1],
                icon: Assets.images.categoriesIcon,
                isSelected: currentIndex == 1),
            BlocBuilder<CartCountCubit, int>(
              builder: (context, state) {
                return Badge(
                  alignment: Alignment.centerRight,
                  backgroundColor: Colors.red,
                  label: Text(state.toString(),
                      style: const TextStyle(color: Colors.white)),
                  offset: const Offset(-4, 2),
                  child: _BnbIcon(
                      onPressed: () => onPressed(2),
                      label: labels[2],
                      icon: Assets.images.cartIcon,
                      isSelected: currentIndex == 2),
                );
              },
            ),
            _BnbIcon(
                onPressed: () => onPressed(3),
                label: labels[3],
                icon: Assets.images.profileIcon,
                isSelected: currentIndex == 3),
          ],
        ),
      ),
    );
  }
}

class _BnbIcon extends StatelessWidget {
  const _BnbIcon(
      {Key? key,
      required this.onPressed,
      required this.label,
      required this.icon,
      required this.isSelected})
      : super(key: key);
  final void Function() onPressed;
  final String label;
  final SvgGenImage icon;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon.svg(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : AppColors.mediumLightGray,
                height: 24,
                width: 24),
            const SizedBox(height: 3),
            Text(label,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10.0,
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : AppColors.mediumLightGray)),
            if (isSelected)
              Icon(Icons.circle,
                  size: 8.0, color: Theme.of(context).primaryColor)
          ],
        ),
        iconSize: 50);
  }
}
