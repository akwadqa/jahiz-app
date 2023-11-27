import 'package:flutter/material.dart';
import '../bloc/add_update_address/add_update_address_cubit.dart';
import '../../../../generated/l10n.dart';

import '../../../../core/gen/assets.gen.dart';

class AddressTypeSelector extends StatefulWidget {
  const AddressTypeSelector(
      {Key? key, required this.onSelected, this.initialValue})
      : super(key: key);
  final Function(AddressType) onSelected;
  final AddressType? initialValue;

  @override
  State<AddressTypeSelector> createState() => _AddressTypeSelectorState();
}

class _AddressTypeSelectorState extends State<AddressTypeSelector> {
  late AddressType _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.initialValue ?? AddressType.home;
    widget.onSelected(_selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _AvatarItem(
            icon: Assets.images.homeIcon.svg(
                color: _selectedIndex.index == 0
                    ? Colors.white
                    : Theme.of(context).primaryColor),
            labelColor: _selectedIndex.index == 0
                ? Theme.of(context).primaryColor
                : Colors.black,
            label: S.of(context).home,
            selected: _selectedIndex.index == 0,
            onSelected: (value) {
              if (value) {
                setState(() {
                  _selectedIndex = AddressType.home;
                });
                widget.onSelected(_selectedIndex);
              }
            }),
        _AvatarItem(
            icon: Assets.images.bagIcon.svg(
                color: _selectedIndex.index == 1
                    ? Colors.white
                    : Theme.of(context).primaryColor),
            labelColor: _selectedIndex.index == 1
                ? Theme.of(context).primaryColor
                : Colors.black,
            label: S.of(context).office,
            selected: _selectedIndex.index == 1,
            onSelected: (value) {
              if (value) {
                setState(() {
                  _selectedIndex = AddressType.office;
                });
                widget.onSelected(_selectedIndex);
              }
            }),
        _AvatarItem(
            icon: Assets.images.buildingIcon.svg(
                color: _selectedIndex.index == 2
                    ? Colors.white
                    : Theme.of(context).primaryColor),
            label: S.of(context).apartment,
            labelColor: _selectedIndex.index == 2
                ? Theme.of(context).primaryColor
                : Colors.black,
            selected: _selectedIndex.index == 2,
            onSelected: (value) {
              if (value) {
                setState(() {
                  _selectedIndex = AddressType.apartment;
                });
                widget.onSelected(_selectedIndex);
              }
            }),
      ],
    );
  }
}

class _AvatarItem extends StatelessWidget {
  const _AvatarItem(
      {Key? key,
      required this.icon,
      required this.label,
      required this.selected,
      required this.labelColor,
      this.onSelected})
      : super(key: key);
  final Widget icon;
  final String label;
  final Color labelColor;
  final bool selected;
  final void Function(bool)? onSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChoiceChip(
          shadowColor: const Color(0xFF9C9C9C),
          showCheckmark: false,
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
          label: icon,
          selected: selected,
          onSelected: onSelected,
          shape: const CircleBorder(),
          labelPadding: const EdgeInsets.all(16.0),
        ),
        const SizedBox(height: 6.0),
        Text(label,
            style: TextStyle(
                color: labelColor, fontSize: 18, fontWeight: FontWeight.w600))
      ],
    );
  }
}
