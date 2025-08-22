// create circle button widget
import 'package:flutter/material.dart';
import 'package:calisfun/src/constants/constants.dart';

class AppCircleButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? size;
  final Color? backgroundColor;
  final double borderRadius;
  final double elevation;
  final Widget child;

  const AppCircleButton({
    super.key,
    required this.onPressed,
    this.size,
    this.backgroundColor,
    this.borderRadius = 50.0,
    this.elevation = 4.0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? SizeApp.customWidth(50),
      height: size ?? SizeApp.customWidth(50),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? ColorApp.primary,
          elevation: elevation,
          shape: CircleBorder(),
          shadowColor: Colors.black.withValues(alpha: 0.25),
        ),
        child: child,
      ),
    );
  }
}