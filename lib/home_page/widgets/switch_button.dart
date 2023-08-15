import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_office/constant/constant.dart';

class SwitchButton extends StatelessWidget {
  const SwitchButton({
    Key? key,
    this.onChanged,
    required this.value,
    required this.title,
    this.activeColor = AppColors.yellow,
    this.trackColor = AppColors.greyLight,
    this.thumbColor = const [
      AppColors.black,
      AppColors.yellow,
    ],
  }) : super(key: key);

  final void Function(bool)? onChanged;
  final bool value;
  final String title;
  final Color? activeColor;
  final Color? trackColor;
  final List<Color>? thumbColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.greyLight,
          ),
        ),
        SizedBox(height: 16.h),
        Transform.scale(
          scaleX: 1.3,
          scaleY: 1.1,
          child: CupertinoSwitch(
            activeColor: activeColor,
            thumbColor:
                value ? thumbColor![0] : thumbColor![1].withOpacity(0.6),
            trackColor: trackColor!.withOpacity(0.3),
            value: value,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
