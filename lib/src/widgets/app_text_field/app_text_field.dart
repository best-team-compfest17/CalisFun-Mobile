import 'package:calisfun/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final bool obscureText;
  final double? width;
  final double? height;
  final double? fontSize;
  final EdgeInsetsGeometry? contentPadding;

  final Widget? prefixIcon;
  final Widget? suffixIcon;

  final String? Function(String?)? validator;
  final String? errorText;

  final bool? enabled;

  final TextStyle? hintStyle;
  final TextStyle? inputStyle;
  final TextInputType? keyboardType;
  final int? maxLine;

  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.width,
    this.height,
    this.fontSize,
    this.contentPadding,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.errorText,
    this.enabled,
    this.hintStyle,
    this.inputStyle,
    this.keyboardType,
    this.maxLine = 1,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: TextFormField(
        enabled: enabled ?? true,
        maxLines: maxLine,
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        validator: validator,
        style: inputStyle ?? TextStyle(fontSize: fontSize ?? 14.sp),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle ?? TextStyle(color: Colors.grey, fontSize: 14.sp),
          errorText: errorText,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(
                vertical: SizeApp.h16,
                horizontal: SizeApp.w12,
              ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(
              color: ColorApp.border,
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(
              color: ColorApp.mainBlack,
              width: 1.w,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(
              color: ColorApp.error,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
            borderSide: BorderSide(
              color: ColorApp.error,
              width: 2,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
          // errorStyle: AppTextStyle.error,
        ),
      ),
    );
  }
}