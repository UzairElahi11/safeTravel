import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../Utils/app_colors.dart';

class GenericSvgImage extends StatelessWidget {
  final String svgPath;
  final double? height;
  final double? width;
  final Color? color;

  const GenericSvgImage({
    Key? key,
    required this.svgPath,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (width != null)
        ? SvgPicture.asset(
            theme: SvgTheme(currentColor: color ?? AppColors.whiteColor),
            svgPath,
            width: width,
          )
        : (height != null)
            ? SvgPicture.asset(
                svgPath,
                height: height,
                theme: SvgTheme(currentColor: color ?? AppColors.whiteColor),
              )
            : (width != null && height != null)
                ? SvgPicture.asset(
                    svgPath,
                    width: width,
                    height: height,
                    theme:
                        SvgTheme(currentColor: color ?? AppColors.whiteColor),
                  )
                : SvgPicture.asset(
                    svgPath,
                    theme:
                        SvgTheme(currentColor: color ?? AppColors.whiteColor),
                  );
  }
}
