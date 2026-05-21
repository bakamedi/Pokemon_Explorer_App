import 'package:flutter/material.dart';
import 'package:flutter_meedu/consumer.dart'; // Importante para escuchar reactivamente el tema si usas un ThemeProvider
import 'package:poke_test/presentation/globals/controllers/settings/settings_gc.dart';
import 'package:poke_test/presentation/globals/utils/router_util.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/presentation/modules/home/utils/close_session.dart';
import 'package:poke_test/theme/app_colors.dart';

// Importamos tu función anterior de cerrar sesión

void openSettings(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: .vertical(top: .circular(24)),
    ),
    builder: (modalContext) {
      return SafeArea(
        child: Consumer(
          builder: (_, ref, _) {
            final controller = ref.watch(settingsGP);
            final isDarkMode = controller.state.isDarkMode;
            return Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                // Línea superior decorativa del BottomSheet
                Center(
                  child: Container(
                    width: 40.rw,
                    height: 4.rh,
                    margin: const .only(bottom: 20), // Corregido .only
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: .circular(2),
                    ),
                  ),
                ),

                Text(
                  'Configuración',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: .bold,
                    color: Colors.grey.shade900,
                  ),
                ),
                20.h,

                // OPCCIÓN 1: CAMBIAR TEMA
                ListTile(
                  contentPadding: .zero,
                  leading: Icon(
                    Icons.palette_rounded,
                    color: AppColors.primaryRed,
                    size: 24.sp,
                  ),
                  title: Text(
                    'Modo Oscuro',
                    style: TextStyle(fontSize: 16.sp, fontWeight: .w500),
                  ),
                  subtitle: Text(
                    'Alterna entre el tema claro y oscuro',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  trailing: Switch.adaptive(
                    value: isDarkMode,
                    activeThumbColor: AppColors.primaryRed,
                    onChanged: (bool value) => controller.toggleDarkMode(),
                  ),
                ),

                Divider(height: 32.rh),

                // OPCIÓN 2: CERRAR SESIÓN
                ListTile(
                  contentPadding: .zero,
                  leading: Icon(
                    Icons.logout_rounded,
                    color: Colors.grey.shade700,
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
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  onTap: () {
                    RouterUtil.pop();
                    closeSession(context);
                  },
                ),

                16.h,
              ],
            ).padding(.all(24.sp));
          },
        ),
      );
    },
  );
}
