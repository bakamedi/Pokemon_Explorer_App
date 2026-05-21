import 'package:flutter/material.dart';
import 'package:poke_test/presentation/globals/utils/router_util.dart';
import 'package:poke_test/presentation/home/controller/home_controller.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart'; // Para tus extensiones .sp
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart'; // Para tu extensión .padding
import 'package:poke_test/routes/app_routes.dart/login_route.dart';
import 'package:poke_test/theme/app_colors.dart';

void closeSession(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: .vertical(top: .circular(24)),
    ),
    builder: (modalContext) {
      return SafeArea(
        child: Column(
          mainAxisSize: .min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const .only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: .circular(2),
              ),
            ),

            Icon(
              Icons.logout_rounded,
              size: 44.sp,
              color: AppColors.primaryRed,
            ),
            const SizedBox(height: 16),

            Text(
              '¿Cerrar Sesión?',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade900,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              'Tu progreso actual y las búsquedas locales se mantendrán a salvo.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
            ),
            const SizedBox(height: 24),

            // BOTÓN ROJO: ACCIÓN CONFIRMAR CERRAR SESIÓN
            SizedBox(
              width: .infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryRed,
                  shape: RoundedRectangleBorder(borderRadius: .circular(12)),
                  elevation: 0,
                ),
                onPressed: () async {
                  RouterUtil.pushReplacement(LoginRoute.path);
                  await homeProvider.read().closeSession();
                },
                child: Text(
                  'Cerrar Sesión',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: .bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // BOTÓN BLANCO: ACCIÓN CANCELAR
            SizedBox(
              width: .infinity,
              height: 48,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(borderRadius: .circular(12)),
                ),
                onPressed: () => RouterUtil.pop(),
                child: Text(
                  'Cancelar',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 15.sp,
                    fontWeight: .w600,
                  ),
                ),
              ),
            ),
          ],
        ).padding(.all(24.sp)), // Corregido .all -> EdgeInsets.all
      );
    },
  );
}
