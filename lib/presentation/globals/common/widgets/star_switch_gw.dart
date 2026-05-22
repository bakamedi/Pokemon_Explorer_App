import 'package:flutter/material.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';

class StarSwitchGW extends StatelessWidget {
  const StarSwitchGW({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 60.rw,
        height: 36.rh,
        padding: const .symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: .circular(30),
          color: value ? Colors.amber.shade300 : Colors.grey.shade300,
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          alignment: value ? .centerRight : .centerLeft,
          child: Container(
            width: 28.rw,
            height: 28.rh,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: .circle,
            ),
            child: Icon(
              Icons.star,
              size: 18.sp,
              color: value ? Colors.amber : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
