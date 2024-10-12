import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_card_list/core/utils/extensions.dart';

class NetworkImageWidget extends StatelessWidget {
  final String? imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;

  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.fit,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width ?? context.screenWidth,
      height: width ?? 300,
      imageUrl: imageUrl ?? "",
      placeholder: (context, url) => const Icon(
        Icons.photo_size_select_actual_rounded,
        size: 66,
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.image_not_supported_rounded,
        size: 66,
      ),
      fit: fit ?? BoxFit.cover,
    );
  }
}
