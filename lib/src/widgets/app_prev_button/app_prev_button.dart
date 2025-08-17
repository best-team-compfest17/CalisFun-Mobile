import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../constants/constants.dart'; // sesuaikan path



class AppPrevButton extends StatelessWidget{
  final VoidCallback? onTap;
  const AppPrevButton({super.key, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => context.pop(),
      child: Container(
        width: SizeApp.w48,
        height: SizeApp.h48,
        decoration: BoxDecoration(
          color: ColorApp.primary,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/icons/arrow_prev_ic.svg',
            width: SizeApp.w24,
            height: SizeApp.h24,
            colorFilter: const ColorFilter.mode(
              ColorApp.mainWhite,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}