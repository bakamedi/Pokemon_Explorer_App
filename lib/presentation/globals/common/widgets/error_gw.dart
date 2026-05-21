import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:flutter_meedu/provider/filters.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/theme/app_colors.dart';

class ErrorGW extends StatelessWidget {
  const ErrorGW({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, _) {
        final isDarkMode = ref.select(settingsGP.select((s) => s.isDarkMode));

        final contentColor = isDarkMode
            ? AppColors.darkTextSecondary
            : Colors.grey.shade600;

        return Column(
          mainAxisAlignment: .center,
          children: [
            Icon(Icons.error_outline, color: contentColor, size: 90.sp),
            Text(
              'Sin conexión a internet',
              style: TextStyle(
                fontSize: 20.sp,
                color: contentColor,
                fontWeight: .w500,
              ),
            ).padding(.symmetric(vertical: 18.sp)),
          ],
        ).padding(.only(bottom: 50.rh)).center;
      },
    );
  }
}
