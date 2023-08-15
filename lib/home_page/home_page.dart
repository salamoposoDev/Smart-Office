import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_office/constant/constant.dart';
import 'package:smart_office/home_page/widgets/light_bulb.dart';
import 'package:smart_office/home_page/widgets/tab_teras.dart';
import 'package:smart_office/home_page/widgets/tab_tuang_tamu.dart';
import 'package:smart_office/home_page/widgets/tabbar_list.dart';
import 'package:smart_office/riverpod/button_state.dart';
import 'package:smart_office/riverpod/riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    final dimmerValue = ref.watch(dimmerProvider('dimmer'));
    final selectedPath = ref.watch(selectedPathProviders);
    final powerRuangTamu = ref.watch(lampuRuangTamuProvider);
    final powerLampuTeras = ref.watch(lampuTerasValueProvider('relay'));

    // log(selectedPath);
    if (dimmerValue.isLoading || powerLampuTeras.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.blueLight.withOpacity(0.8),
                        child: Icon(
                          CupertinoIcons.person,
                          size: 35.h,
                          color: AppColors.black,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Hi, There',
                        style: GoogleFonts.poppins(
                          fontSize: 20.sp,
                          color: AppColors.greyLight,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  TabbarList(
                    onChanged: (index) {},
                  ),
                  SizedBox(height: 30.h),
                  if (selectedPath == 'dimmer')
                    TabbarRuangTamu()
                  else if (selectedPath == 'relay')
                    TabbarTeras(),
                ],
              ),
            ),
          ),
          if (selectedPath == 'dimmer')
            Positioned(
              right: 20.h,
              top: 0,
              child: LightBulb(
                cableColor: selectedPath == 'dimmer'
                    ? Colors.amber
                    : Colors.lightBlueAccent,
                powerOnColor: selectedPath == 'dimmer'
                    ? AppColors.yellow
                    : AppColors.blueLight,
                opacity: dimmerValue.asData!.value.toInt() / 100,
                powerOn: powerRuangTamu,
              ),
            )
          else
            Positioned(
              right: 20.h,
              top: 0,
              child: LightBulb(
                cableColor: selectedPath == 'dimmer'
                    ? Colors.amber
                    : Colors.lightBlueAccent,
                powerOnColor: selectedPath == 'dimmer'
                    ? AppColors.yellow
                    : AppColors.blueLight,
                opacity: 1,
                powerOn: powerLampuTeras.asData!.value,
              ),
            )
        ],
      ),
    );
  }
}
