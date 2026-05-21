import 'package:flutter/material.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';

class ErrorGW extends StatelessWidget {
  const ErrorGW({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.error_outline, color: Colors.grey, size: 9.sp),
        Text(
          'Ocurrió un error al cargar los datos.',
          style: TextStyle(fontSize: 2.2.sp, color: Colors.grey),
        ).padding(.symmetric(vertical: 5.sp)),
      ],
    ).padding(.only(top: 4.sp));
  }
}
