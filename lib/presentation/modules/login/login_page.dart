import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:poke_test/helpers/assets_image_helper.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/presentation/modules/login/controller/login_controller.dart';
import 'package:poke_test/presentation/modules/login/utils/login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .stretch,
          children: [
            Image.asset(
              AssetsImageHelper.pokeball,
              height: 85.rh,
              width: 85.rw,
            ).center,
            12.h,
            Text(
              'Ingreso a tu cuenta',
              textAlign: .center,
              style: TextStyle(fontSize: 18.sp, fontWeight: .bold),
            ),
            48.h,

            Consumer(
              builder: (_, ref, _) {
                final controller = ref.watch(loginProvider);
                return Column(
                  children: [
                    TextField(
                      onChanged: controller.onChangeUsername,
                      decoration: InputDecoration(
                        hintText: 'Ingresa su usuario',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    16.h,

                    TextField(
                      obscureText: controller.state.obscurePassword,
                      onChanged: controller.onChangePassword,
                      decoration: InputDecoration(
                        hintText: 'Ingresa su contraseña',
                        prefixIcon: const Icon(Icons.vpn_key_outlined),

                        suffixIcon: IconButton(
                          onPressed: controller.togglePasswordVisibility,
                          icon: Icon(
                            controller.state.obscurePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                      ),
                    ),
                    24.h,
                    // --- BOTÓN SIGN IN ---
                    ElevatedButton(
                      onPressed: controller.isValid ? login : null,
                      child: Text(
                        'Ingresar',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: .bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            16.h,
          ],
        ).padding(.symmetric(horizontal: 24.rw)),
      ),
    );
  }
}
