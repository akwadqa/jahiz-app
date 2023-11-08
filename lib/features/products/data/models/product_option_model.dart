import '../../domain/entities/product_option.dart';

class ProductOptionModel extends ProductOption {
  const ProductOptionModel(
      {required super.optionName,
      required super.optionType,
      required super.isMandatory,
      required super.weightage,
      required super.isPriceModifier,
      required super.hint,
      required super.textInput,
      required super.numberInputValue,
      required super.radioGroupOption});

  factory ProductOptionModel.fromJson(Map<String, dynamic> json) {
    return ProductOptionModel(
      optionName: json['option_name'],
      optionType: json['option_type'],
      isMandatory: json['is_mandatory'],
      weightage: json['weightage'],
      isPriceModifier: json['is_price_modifier'],
      hint: json['hint'],
      textInput: json['text_input'],
      numberInputValue: json['number_input_value'],
      radioGroupOption:
          List<String>.from(json['radio_group_option'].map((e) => e['name1'])),
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['option_name'] = optionName;
    data['option_type'] = optionType;
    data['is_mandatory'] = isMandatory;
    data['weightage'] = weightage;
    data['is_price_modifier'] = isPriceModifier;
    data['hint'] = hint;
    data['text_input'] = textInput;
    data['number_input_value'] = numberInputValue;
    data['radio_group_option'] = radioGroupOption;
    return data;
  }
}
