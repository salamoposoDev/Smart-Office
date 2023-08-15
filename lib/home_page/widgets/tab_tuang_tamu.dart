import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:smart_office/constant/constant.dart';
import 'package:smart_office/home_page/widgets/switch_button.dart';
import 'package:smart_office/riverpod/button_state.dart';
import 'package:smart_office/riverpod/riverpod.dart';

class TabbarRuangTamu extends ConsumerWidget {
  const TabbarRuangTamu({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dimmerRef = FirebaseDatabase.instance.ref('dimmer');
    final automationRef = FirebaseDatabase.instance.ref('auRuangTamu');
    final automation = ref.watch(ruangTamuAutomationProvider('auRuangTamu'));
    final dimmerValue = ref.watch(dimmerProvider('dimmer'));
    final pirStatus = ref.watch(pirSensorProvider('pirSensor'));
    final powerOn = ref.watch(lampuRuangTamuProvider);

    if (dimmerValue.isLoading || automation.isLoading || pirStatus.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (dimmerValue.hasError) {
      return Text(
        'error ${dimmerValue.error}',
        style: const TextStyle(color: Colors.white),
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
                    value: powerOn,
                    onChanged: (value) {
                      ref.read(lampuRuangTamuProvider.notifier).state = value;
                      if (value) {
                        dimmerRef.set(50);
                      } else {
                        dimmerRef.set(0);
                      }
                    },
                  ),
                  SizedBox(height: 30.h),
                  SwitchButton(
                    value: automation.asData!.value,
                    title: 'Automation',
                    onChanged: (value) {
                      automationRef.set(value);
                    },
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Motion sensor',
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
                        pirStatus.asData!.value,
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w300,
                          color: AppColors.greyLight,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 50.h),
        SleekCircularSlider(
          innerWidget: (percentage) {
            return Center(
              child: Text(
                '${percentage.toInt()}%',
                style: GoogleFonts.poppins(
                  color: AppColors.greyLight,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          },
          appearance: CircularSliderAppearance(
              size: 300.h,
              customWidths: CustomSliderWidths(
                handlerSize: 20.h,
                progressBarWidth: 15.w,
                trackWidth: 5.w,
                shadowWidth: 0.w,
              ),
              customColors: CustomSliderColors(
                dotColor: AppColors.greyLight,
                trackColors: [
                  AppColors.yellow,
                  AppColors.yellow,
                  AppColors.yellow,
                  AppColors.yellow,
                  Color(0xFF4A4A4A),
                  Color(0xFF3A3A3A),
                ],
                progressBarColors: [
                  AppColors.yellow,
                  AppColors.yellow,
                  AppColors.yellow,
                  AppColors.yellow,
                  Color(0xFF4A4A4A),
                  Color(0xFF3A3A3A),
                ],
              )),
          min: 0,
          max: 100,
          initialValue: dimmerValue.asData!.value.toDouble(),
          onChange: (double value) {
            if (powerOn) {
              dimmerRef.set(value);
            }
          },
          onChangeStart: (startValue) {},
          onChangeEnd: (endValue) {},
        ),
      ],
    );
  }
}
