import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:poke_test/presentation/globals/utils/router_util.dart';
import 'package:poke_test/presentation/modules/home/controller/home_controller.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/routes/app_routes.dart/login_route.dart';
import 'package:poke_test/theme/app_colors.dart';

void closeSession(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: .vertical(top: .circular(24)),
    ),
    builder: (modalContext) {
      bool isLoggingOut = false;

      return Consumer(
        builder: (_, ref, _) {
          final settingsController = ref.watch(settingsGP);
          final isDarkMode = settingsController.state.isDarkMode;

          final backgroundColor = isDarkMode
              ? AppColors.darkBackground
              : AppColors.lightBackground;
          final textColor = isDarkMode
              ? AppColors.darkTextPrimary
              : AppColors.lightTextPrimary;
          final subTextColor = isDarkMode
              ? AppColors.darkTextSecondary
              : AppColors.lightTextSecondary;

          return StatefulBuilder(
            builder: (context, setState) {
              return Material(
                color: backgroundColor,
                clipBehavior: .antiAlias,
                borderRadius: const .vertical(top: .circular(24)),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      // Línea superior decorativa del BottomSheet adaptada al color del tema
                      Center(
                        child: Container(
                          width: 40.rw,
                          height: 4.rh,
                          margin: const .only(bottom: 20),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? Colors.grey.shade700
                                : Colors.grey.shade300,
                            borderRadius: .circular(2),
                          ),
                        ),
                      ),

                      Icon(
                        Icons.logout_rounded,
                        size: 44.sp,
                        color: AppColors.primaryRed,
                      ),
                      16.h,

                      Text(
                        '¿Cerrar Sesión?',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: .bold,
                          color: textColor,
                        ),
                      ),
                      8.h,

                      Text(
                        'Tu progreso actual y las búsquedas locales se mantendrán a salvo.',
                        textAlign: .center,
                        style: TextStyle(color: subTextColor, fontSize: 14.sp),
                      ),
                      24.h,

                      // BOTÓN ROJO: ACCIÓN CONFIRMAR CERRAR SESIÓN
                      SizedBox(
                        width: .infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryRed,
                            shape: RoundedRectangleBorder(
                              borderRadius: .circular(12),
                            ),
                            elevation: 0,
                          ),
                          onPressed: isLoggingOut
                              ? null
                              : () async {
                                  setState(() => isLoggingOut = true);
                                  try {
                                    await homeProvider.read().closeSession();

                                    if (modalContext.mounted) RouterUtil.pop();

                                    RouterUtil.pushReplacement(LoginRoute.path);
                                  } catch (e) {
                                    setState(() => isLoggingOut = false);
                                  }
                                },
                          child: isLoggingOut
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Cerrar Sesión',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: .bold,
                                  ),
                                ),
                        ),
                      ),
                      12.h,

                      // BOTÓN BLANCO / OSCURO: ACCIÓN CANCELAR
                      if (!isLoggingOut)
                        SizedBox(
                          width: double.infinity,
                          height: 48.rh,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: isDarkMode
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade300,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: .circular(12),
                              ),
                            ),
                            onPressed: () => RouterUtil.pop(),
                            child: Text(
                              'Cancelar',
                              style: TextStyle(
                                color: isDarkMode
                                    ? Colors.grey.shade400
                                    : Colors.grey.shade700,
                                fontSize: 15.sp,
                                fontWeight: .w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ).padding(.all(24.sp)),
                ),
              );
            },
          );
        },
      );
    },
  );
}
