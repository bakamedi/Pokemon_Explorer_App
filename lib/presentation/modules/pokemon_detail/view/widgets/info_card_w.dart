import 'package:flutter/material.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/theme/app_colors.dart';

class InfoCardW extends StatelessWidget {
  const InfoCardW({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.isDarkMode,
  });

  final IconData icon;
  final String title;
  final String value;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: .symmetric(horizontal: 16.rw, vertical: 16.rh),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkInput : Colors.purple.shade50,
        borderRadius: .circular(16.rw),
        border: .all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurpleAccent, size: 28.sp),
          12.rw.w,
          Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey,
                  fontWeight: .bold,
                ),
              ),
              4.rh.h,
              Text(
                value,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 15.sp,
                  fontWeight: .bold,
                ),
              ),
            ],
          ),
        ],
      ),
    ).expanded;
  }
}
