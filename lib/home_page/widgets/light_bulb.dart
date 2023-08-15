import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_office/constant/constant.dart';

class LightBulb extends StatelessWidget {
  const LightBulb({
    super.key,
    required this.powerOn,
    required this.opacity,
    this.cableColor = Colors.amber,
    this.powerOnColor = AppColors.yellow,
    this.powerOffColor = AppColors.greyLight,
  });

  final bool powerOn;
  final double opacity;
  final Color? cableColor;
  final Color? powerOnColor;
  final Color? powerOffColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 220.h,
            width: 2.w,
            color: cableColor,
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()..scale(1.0, -1.0, 1.0),
            child: Icon(
              powerOn
                  ? CupertinoIcons.lightbulb_fill
                  : CupertinoIcons.lightbulb,
              size: 200.h,
              color: powerOn
                  ? powerOnColor!.withOpacity(opacity)
                  : powerOffColor!.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
