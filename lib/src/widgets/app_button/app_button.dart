import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? backgroundColor;
  final double borderRadius;
  final double elevation;
  final double horizontalPad;
  final double verticalPad;
  final TextStyle? textStyle;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.fontSize,
    this.backgroundColor,
    this.borderRadius = 10.0,
    this.horizontalPad = 0.0,
    this.verticalPad = 0.0,
    this.elevation = 4.0,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? ColorApp.primary,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius.r),
          ),
          shadowColor: Colors.black.withValues(alpha: 0.25),
          padding: EdgeInsets.symmetric(horizontal: horizontalPad.w, vertical: verticalPad.h),
        ),
        child: Text(
          text,
          style: textStyle ??
              TextStyle(
                fontSize: fontSize ?? 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}