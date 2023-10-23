import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppCachedNetworkImage extends StatelessWidget {
  const AppCachedNetworkImage(
      {Key? key, required this.imageUrl, this.height, this.width})
      : super(key: key);

  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.cover,
      width: width,
      height: height,
    );
  }
}
