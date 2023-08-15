import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_office/constant/constant.dart';

class PillItem extends StatelessWidget {
  const PillItem({
    super.key,
    required this.text,
    this.isSelected = false,
  });
  final String text;
  final bool? isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected!
            ? AppColors.greyLight
            : AppColors.greyLight.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        text,
        style: GoogleFonts.roboto(
          color: isSelected!
              ? AppColors.black
              : AppColors.greyLight.withOpacity(0.5),
          fontWeight: FontWeight.w400,
          fontSize: 18.sp,
        ),
      ),
    );
  }
}
