import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_office/constant/constant.dart';
import 'package:smart_office/home_page/widgets/switch_button.dart';
import 'package:smart_office/riverpod/riverpod.dart';

class TabbarTeras extends ConsumerWidget {
  const TabbarTeras({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lampuTerasRef = FirebaseDatabase.instance.ref('relay');
    final powerOn = ref.watch(lampuTerasValueProvider('relay'));
    final auTerasRef = FirebaseDatabase.instance.ref('auTeras');
    final automation = ref.watch(lampuTerasAutomationProvider('auTeras'));
    final lightSensorStatus = ref.watch(lightSensorProvider('lightSensor'));

    if (powerOn.isLoading ||
        automation.isLoading ||
        lightSensorStatus.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SwitchButton(
                    title: 'Power',
                    value: powerOn.asData!.value,
                    activeColor: AppColors.blueLight,
                    thumbColor: const [AppColors.black, AppColors.blueLight],
                    onChanged: (value) {
                      lampuTerasRef.set(value);
                    },
                  ),
                  SizedBox(height: 30.h),
                  SwitchButton(
                    value: automation.asData!.value,
                    title: 'Automation',
                    activeColor: AppColors.blueLight,
                    thumbColor: [AppColors.black, AppColors.blueLight],
                    onChanged: (value) {
                      auTerasRef.set(value);
                    },
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Light sensor',
                    style: GoogleFonts.roboto(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyLight,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Status: ',
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.yellow,
                        ),
                      ),
                      Text(
                        lightSensorStatus.asData!.value,
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.greyLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 50.h),
        // SleekCircularSlider(
        //   innerWidget: (percentage) {
        //     return Center(
        //       child: Text(
        //         '${percentage.toInt()}%',
        //         style: GoogleFonts.poppins(
        //           color: AppColors.greyLight,
        //           fontSize: 40.sp,
        //           fontWeight: FontWeight.w500,
        //         ),
        //       ),
        //     );
        //   },
        //   appearance: CircularSliderAppearance(
        //       size: 300.h,
        //       customWidths: CustomSliderWidths(
        //         handlerSize: 20.h,
        //         progressBarWidth: 15.w,
        //         trackWidth: 5.w,
        //         shadowWidth: 0.w,
        //       ),
        //       customColors: CustomSliderColors(
        //         dotColor: AppColors.greyLight,
        //         trackColors: [
        //           AppColors.blueLight,
        //           AppColors.blueLight,
        //           AppColors.blueLight,
        //           AppColors.blueLight,
        //           Color(0xFF4A4A4A),
        //           Color(0xFF3A3A3A),
        //         ],
        //         progressBarColors: [
        //           AppColors.blueLight,
        //           AppColors.blueLight,
        //           AppColors.blueLight,
        //           AppColors.blueLight,
        //           Color(0xFF4A4A4A),
        //           Color(0xFF3A3A3A),
        //         ],
        //       )),
        //   min: 0,
        //   max: 100,
        //   initialValue: 50,
        //   onChange: (double value) {
        //     final newVal = value / 100;
        //     // if (mainPowerValue) {
        //     //   _dimmerRef.set(value.toInt());
        //     //   setState(() {
        //     //     opacity = newVal;
        //     //   });
        //     // }
        //   },
        //   onChangeStart: (startValue) {},
        //   onChangeEnd: (endValue) {},
        // ),
      ],
    );
  }
}
