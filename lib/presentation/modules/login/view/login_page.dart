import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:flutter_meedu/provider/filters.dart';
import 'package:poke_test/helpers/assets_image_helper.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/presentation/modules/login/controller/login_controller.dart';
import 'package:poke_test/presentation/modules/login/utils/login.dart';
import 'package:poke_test/theme/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, _) {
        final loginController = ref.watch(loginProvider);
        final isDarkMode = ref.select(settingsGP.select((s) => s.isDarkMode));

        final textColor = isDarkMode
            ? AppColors.darkTextPrimary
            : AppColors.lightTextPrimary;
        final subTextColor = isDarkMode
            ? AppColors.darkTextSecondary
            : AppColors.lightTextSecondary;

        return Scaffold(
          backgroundColor: isDarkMode
              ? AppColors.darkBackground
              : AppColors.lightBackground,
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
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: .bold,
                    color: textColor,
                  ),
                ),
                48.h,

                // --- TEXTFIELD: USUARIO ---
                TextField(
                  onChanged: loginController.onChangeUsername,
                  style: TextStyle(
                    color: isDarkMode
                        ? AppColors.lightTextPrimary
                        : AppColors.darkTextSecondary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Ingresa su usuario',
                    hintStyle: TextStyle(color: subTextColor),
                    prefixIcon: Icon(Icons.person_outline, color: subTextColor),
                  ),
                ),
                16.h,

                // --- TEXTFIELD: CONTRASEÑA ---
                TextField(
                  obscureText: loginController.state.obscurePassword,
                  onChanged: loginController.onChangePassword,
                  style: TextStyle(
                    color: isDarkMode
                        ? AppColors.lightTextPrimary
                        : AppColors.darkTextSecondary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Ingresa su contraseña',
                    hintStyle: TextStyle(color: subTextColor),
                    prefixIcon: Icon(
                      Icons.vpn_key_outlined,
                      color: subTextColor,
                    ),
                    suffixIcon: IconButton(
                      onPressed: loginController.togglePasswordVisibility,
                      icon: Icon(
                        loginController.state.obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: subTextColor,
                      ),
                    ),
                  ),
                ),
                24.h,

                // --- BOTÓN SIGN IN ---
                ElevatedButton(
                  onPressed: loginController.isValid ? login : null,
                  child: Text(
                    'Ingresar',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: .bold, 
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                16.h,
              ],
            ).padding(.symmetric(horizontal: 24.rw)),
          ),
        );
      },
    );
  }
}
