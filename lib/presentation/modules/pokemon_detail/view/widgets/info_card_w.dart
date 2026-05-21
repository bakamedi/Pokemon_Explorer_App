import 'package:flutter/material.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';

class InfoCardW extends StatelessWidget {
  const InfoCardW({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const .all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: .circular(16),
        border: .all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurpleAccent, size: 28.sp),
          12.w,
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
              4.h,
              Text(
                value,
                style: TextStyle(fontSize: 15.sp, fontWeight: .bold),
              ),
            ],
          ),
        ],
      ),
    ).expanded;
  }
}
