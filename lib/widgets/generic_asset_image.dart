import 'package:flutter/material.dart';

class GenericAssetImageWidget extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final bool? isAntiAlias;
  final double? scale;
  final Animation<double>? opacity;
  final BlendMode? colorBlendMode;
  final AlignmentGeometry? alignment;
  final ImageRepeat? repeat;
  final Rect? centerSlice;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final Widget Function(BuildContext, Widget, int?, bool?)? frameBuilder;
  final String? package;
  final Color? color;
  final bool? matchTextDirection;
  final bool? gaplessPlayback;
  final FilterQuality? filterQuality;
  final int? cacheHeight;
  final int? cacheWidth;
  final bool? excludeFromSemantics;

  const GenericAssetImageWidget({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.isAntiAlias,
    this.scale,
    this.opacity,
    this.colorBlendMode,
    this.alignment,
    this.repeat,
    this.centerSlice,
    this.errorBuilder,
    this.frameBuilder,
    this.package,
    this.matchTextDirection,
    this.gaplessPlayback,
    this.filterQuality,
    this.cacheHeight,
    this.cacheWidth,
    this.excludeFromSemantics,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      width: width,
      image,
      height: height,
      color: color,
      fit: fit,
      isAntiAlias: isAntiAlias ?? false,
      scale: scale ?? 1.0,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      alignment: alignment ?? Alignment.center,
      repeat: repeat ?? ImageRepeat.noRepeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection ?? false,
      gaplessPlayback: gaplessPlayback ?? false,
      package: package,
      filterQuality: filterQuality ?? FilterQuality.low,
      cacheHeight: cacheHeight,
      cacheWidth: cacheWidth,
      excludeFromSemantics: excludeFromSemantics ?? false,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
    );
  }
}
