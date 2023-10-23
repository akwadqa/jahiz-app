import 'package:equatable/equatable.dart';

class AdditionalImage extends Equatable {
  const AdditionalImage(
      {required this.image,
      required this.heading,
      required this.description,
      required this.url});

  final String image;
  final String heading;
  final String description;
  final String url;

  AdditionalImage copyWith({
    String? image,
    String? heading,
    String? description,
    String? url,
  }) =>
      AdditionalImage(
        image: image ?? this.image,
        heading: heading ?? this.heading,
        description: description ?? this.description,
        url: url ?? this.url,
      );

  @override
  List<Object?> get props => [image, heading, description, url];
}
