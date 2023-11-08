import '../../domain/entities/additional_image.dart';

import '../../../../core/shared_functions.dart';

class AdditionalImageModel extends AdditionalImage {
  const AdditionalImageModel(
      {required super.image,
      required super.heading,
      required super.description,
      required super.url});

  factory AdditionalImageModel.fromJson(Map<String, dynamic> json) {
    return AdditionalImageModel(
      image: json['image'],
      heading: json['heading'],
      description: json['description'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = SharedFunctions.getImageUrl(image);
    map['heading'] = heading;
    map['description'] = description;
    map['url'] = url;
    return map;
  }
}
