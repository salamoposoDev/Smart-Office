import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_office/constant/constant.dart';

class SchedulePill extends StatefulWidget {
  const SchedulePill({
    super.key,
    required this.onTap,
    required this.time,
  });
  final VoidCallback onTap;
  final String time;

  @override
  State<SchedulePill> createState() => _SchedulePillState();
}

class _SchedulePillState extends State<SchedulePill> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    log(_selectedTime.toString());
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: AppColors.blueLight.withOpacity(0.9),
          border: Border.all(color: Colors.grey.shade500),
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(
          widget.time,
          style: GoogleFonts.aBeeZee(
              color: AppColors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
