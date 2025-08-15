import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final double? height;
  final Widget childLeft;
  final Widget childRight;
  final Color? backgroundColor;

  const AppContainer({
    super.key,
    this.height,
    required this.childLeft,
    required this.childRight,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? SizeApp.customHeight(120),
      padding: EdgeInsets.symmetric(horizontal: SizeApp.h12, vertical: SizeApp.h16),
      width: SizeApp.customWidth(360),
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorApp.primary,
        borderRadius: BorderRadius.circular(SizeApp.w16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          childLeft,
          childRight,
        ],
      ),
    );
  }
}