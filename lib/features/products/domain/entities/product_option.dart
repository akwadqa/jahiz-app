import 'package:equatable/equatable.dart';

class ProductOption extends Equatable {
  const ProductOption({
    required this.optionName,
    required this.optionType,
    required this.isMandatory,
    required this.weightage,
    required this.isPriceModifier,
    required this.hint,
    required this.textInput,
    required this.numberInputValue,
    required this.radioGroupOption,
  });

  final String optionName;
  final String optionType;
  final int isMandatory;
  final String weightage;
  final int isPriceModifier;
  final String hint;
  final int? textInput;
  final double numberInputValue;
  final List<String> radioGroupOption;

  ProductOption copyWith({
    String? optionName,
    String? optionType,
    int? isMandatory,
    String? weightage,
    int? isPriceModifier,
    String? hint,
    int? textInput,
    double? numberInputValue,
    List<String>? radioGroupOption,
  }) =>
      ProductOption(
        optionName: optionName ?? this.optionName,
        optionType: optionType ?? this.optionType,
        isMandatory: isMandatory ?? this.isMandatory,
        weightage: weightage ?? this.weightage,
        isPriceModifier: isPriceModifier ?? this.isPriceModifier,
        hint: hint ?? this.hint,
        textInput: textInput ?? this.textInput,
        numberInputValue: numberInputValue ?? this.numberInputValue,
        radioGroupOption: radioGroupOption ?? this.radioGroupOption,
      );

  @override
  List<Object?> get props => [
        optionName,
        optionType,
        isMandatory,
        weightage,
        isPriceModifier,
        hint,
        textInput,
        numberInputValue,
        radioGroupOption,
      ];
}
