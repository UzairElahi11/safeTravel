import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:safe/Utils/app_colors.dart';

class GenericTabBar extends StatelessWidget {
  const GenericTabBar(
      {super.key,
      this.controller,
      required this.labels,
      required this.tabChildren,
      this.labelStyle,
      this.selectedLabelColor,
      this.unselectedLabelColor,
      this.indicatorColor,
      this.indicatorWidth, this.height});

  final TabController? controller;
  final List<String?> labels;
  final List<Widget> tabChildren;
  final TextStyle? labelStyle;
  final Color? selectedLabelColor;
  final Color? unselectedLabelColor;
  final Color? indicatorColor;
  final double? indicatorWidth;
  final double ? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(

          physics: const BouncingScrollPhysics(),
          isScrollable: true,
          padding: const EdgeInsets.symmetric(horizontal: 100),
          indicatorPadding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          controller: controller,
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: indicatorColor ?? AppColors.baseColor,
                  width: indicatorWidth ?? 4),
            ),
          ),
          labelColor: selectedLabelColor,
          unselectedLabelColor: unselectedLabelColor,
          labelStyle: labelStyle,
          tabs: labels
              .map(
                (e) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Tab(
                      text: e,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: tabChildren,
          ),
        ),
      ],
    );
  }
}
