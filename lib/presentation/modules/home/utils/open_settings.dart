import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart';
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:poke_test/presentation/globals/utils/router_util.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/presentation/modules/home/utils/close_session.dart';
import 'package:poke_test/theme/app_colors.dart';

// Ya no requerimos pasarle 'isDarkMode' por parámetro externo
void openSettings(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: .vertical(top: .circular(24)),
    ),
    builder: (modalContext) {
      return Consumer(
        builder: (_, ref, _) {
          final controller = ref.watch(settingsGP);
          final isDarkMode = controller.state.isDarkMode;

          // 2. Colores diámicos basados en tus AppColors
          final textColor = isDarkMode
              ? AppColors.darkTextPrimary
              : AppColors.lightTextPrimary;
          final subTextColor = isDarkMode
              ? AppColors.darkTextSecondary
              : AppColors.lightTextSecondary;

          return Material(
            color: isDarkMode
                ? AppColors.darkBackground
                : AppColors.lightBackground,
            clipBehavior: Clip.antiAlias,
            borderRadius: const .vertical(top: .circular(24)),
            child: SafeArea(
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .start,
                children: [
                  // Línea superior decorativa del BottomSheet
                  Center(
                    child: Container(
                      width: 40.rw,
                      height: 4.rh,
                      margin: const .only(bottom: 20),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                        borderRadius: .circular(2), // Corregido .circular
                      ),
                    ),
                  ),

                  Text(
                    'Configuración',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: .bold, // Corregido .bold
                      color: textColor, // Aplicado dinámico
                    ),
                  ),
                  20.h,

                  // OPCIÓN 1: CAMBIAR TEMA
                  ListTile(
                    contentPadding: .zero, // Corregido .zero
                    leading: Icon(
                      Icons.palette_rounded,
                      color: AppColors.primaryRed,
                      size: 24.sp,
                    ),
                    title: Text(
                      'Modo Oscuro',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: .w500,
                        color: textColor, // Aplicado dinámico
                      ),
                    ),
                    subtitle: Text(
                      'Alterna entre el tema claro y oscuro',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: subTextColor, // Aplicado dinámico
                      ),
                    ),
                    trailing: Switch.adaptive(
                      value: isDarkMode,
                      activeTrackColor: AppColors.primaryRed.withValues(
                        alpha: 0.5,
                      ),
                      activeThumbColor: AppColors.primaryRed,
                      onChanged: (bool value) => controller.toggleDarkMode(),
                    ),
                  ),

                  Divider(
                    height: 32.rh,
                    color: isDarkMode ? Colors.white10 : Colors.black12,
                  ),

                  // OPCIÓN 2: CERRAR SESIÓN
                  ListTile(
                    contentPadding: EdgeInsets.zero, // Corregido .zero
                    leading: Icon(
                      Icons.logout_rounded,
                      color: subTextColor, // Aplicado dinámico
                      size: 24.sp,
                    ),
                    title: Text(
                      'Cerrar Sesión',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: .w500,
                        color: Colors.red.shade700,
                      ),
                    ),
                    subtitle: Text(
                      'Salir de tu cuenta de forma segura',
                      style: TextStyle(fontSize: 12.sp, color: subTextColor),
                    ),
                    onTap: () {
                      RouterUtil.pop();
                      closeSession(context);
                    },
                  ),

                  16.h,
                ],
              ).padding(.all(24.sp)),
            ),
          );
        },
      );
    },
  );
}
