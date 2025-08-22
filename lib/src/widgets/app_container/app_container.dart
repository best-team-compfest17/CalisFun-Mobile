import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final double? height;
  final Widget childLeft;
  final Widget childRight;
  final Color? backgroundColor;
  final bool showBorder;
  final bool showShadow;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadiusValue;

  const AppContainer({
    super.key,
    this.height,
    required this.childLeft,
    required this.childRight,
    this.backgroundColor,
    this.showBorder = false,
    this.showShadow = false,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadiusValue = 7.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? SizeApp.customHeight(120),
      padding: EdgeInsets.symmetric(
        horizontal: SizeApp.h12,
        vertical: SizeApp.h16,
      ),
      width: SizeApp.customWidth(360),
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorApp.primary,
        borderRadius: BorderRadius.circular(borderRadiusValue),
        border: showBorder
            ? Border.all(
          color: borderColor ?? ColorApp.border,
          width: borderWidth,
        )
            : null,
        boxShadow: showShadow
            ? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ]
            : null,
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
