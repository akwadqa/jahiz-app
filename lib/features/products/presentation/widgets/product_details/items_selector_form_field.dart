import 'package:flutter/material.dart';
import '../../../../../core/widgets/error_text.dart';

class ItemsSelectorFormField extends FormField<String?> {
  ItemsSelectorFormField({
    super.key,
    required final List<String> items,
    super.onSaved,
    super.validator,
  }) : super(builder: (FormFieldState<String?> state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ItemsSelector(
                  items: items,
                  onItemSelected: (value) => state.didChange(value)),
              if (state.hasError) ErrorText(text: state.errorText!)
            ],
          );
        });
}

class _ItemsSelector extends StatefulWidget {
  const _ItemsSelector(
      {Key? key, required this.items, required this.onItemSelected})
      : super(key: key);

  final List<String> items;
  final void Function(String? value) onItemSelected;

  @override
  State<_ItemsSelector> createState() => _ItemsSelectorState();
}

class _ItemsSelectorState extends State<_ItemsSelector> {
  late List<bool> selectionStates;

  @override
  void initState() {
    selectionStates = List.generate(widget.items.length, (_) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 6,
        children: widget.items
            .map((e) => ChoiceChip(
                  label: Text(e),
                  labelStyle: TextStyle(
                      color: selectionStates[widget.items.indexOf(e)]
                          ? Colors.white
                          : null),
                  selected: selectionStates[widget.items.indexOf(e)],
                  onSelected: (value) {
                    if (value) {
                      setState(() {
                        selectionStates =
                            List.generate(widget.items.length, (_) => false);
                        selectionStates[widget.items.indexOf(e)] = value;
                      });
                      widget.onItemSelected(e);
                    }
                  },
                ))
            .toList());
  }
}
