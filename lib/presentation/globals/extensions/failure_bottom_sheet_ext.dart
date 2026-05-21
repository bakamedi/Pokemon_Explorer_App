import 'package:flutter/material.dart';
import 'package:poke_test/domain/models/failures/failure.dart';
import 'package:poke_test/presentation/globals/extensions/responsive_num_ext.dart';
import 'package:poke_test/presentation/globals/extensions/widgets_ext.dart';
import 'package:poke_test/presentation/globals/utils/router_util.dart';
import 'package:poke_test/routes/app_pages.dart';

extension FailureBottomSheetExt on Failure {
  static final _router = AppRouter.routerProvider.read();

  static BuildContext get _context =>
      _router.routerDelegate.navigatorKey.currentContext!;

  Future<void> showBottomSheet() {
    return showModalBottomSheet(
      context: _context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      builder: (_) {
        return SafeArea(
          child: Column(
            mainAxisSize: .min,
            children: [
              Icon(Icons.error_outline, size: 40.sp, color: Colors.red),
              const SizedBox(height: 16),

              Text(
                title,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Text(message, textAlign: .center),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => RouterUtil.pop(),
                  child: const Text('Aceptar'),
                ),
              ),
            ],
          ).padding(.all(24.sp)),
        );
      },
    );
  }

  String get title => when(
    network: (_, _) => 'Error de conexión',
    unknown: (_, _) => 'Error desconocido',
    api: (_, _, _) => 'Error del servidor',
    auth: (_, _, _) => 'Error de autenticación',
    validation: (_, _, _) => 'Datos inválidos',
    business: (_, _) => 'Error',
    noData: (_) => 'Sin datos',
    timeout: (_) => 'Tiempo agotado',
    notFound: (_) => 'No encontrado',
    storage: (_) => 'Error local',
    supabase: (_) => 'Error',
    biometric: (_) => 'Biometría',
    biometricNoHardware: (_) => 'Biometría',
    noBiometricsEnrolled: (_) => 'Biometría',
    sessionExpired: (_) => 'Sesión expirada',
    cancelled: (_) => 'Cancelado',
    permissionDenied: (_, _) => 'Permiso denegado',
    eventOverlap: (_) => 'Horario ocupado',
    duplicate: (_) => 'Duplicado',
    purchaseCancelledError: (_) => 'Compra cancelada',
    storeProblemError: (_) => 'Problema en tienda',
    productAlreadyPurchasedError: (_) => 'Producto comprado',
    purchaseInvalidError: (_) => 'Compra inválida',
    productNotAvailableForPurchaseError: (_) => 'No disponible',
  );

  String get message => when(
    network: (message, _) => message,
    unknown: (message, _) => message,
    api: (message, _, _) => message,
    auth: (message, _, _) => message,
    validation: (message, _, _) => message,
    business: (message, _) => message,
    noData: (message) => message,
    timeout: (message) => message,
    notFound: (message) => message,
    storage: (message) => message,
    supabase: (message) => message,
    biometric: (message) => message,
    biometricNoHardware: (message) => message,
    noBiometricsEnrolled: (message) => message,
    sessionExpired: (message) => message,
    cancelled: (message) => message,
    permissionDenied: (message, _) => message,
    eventOverlap: (message) => message,
    duplicate: (message) => message,
    purchaseCancelledError: (message) => message,
    storeProblemError: (message) => message,
    productAlreadyPurchasedError: (message) => message,
    purchaseInvalidError: (message) => message,
    productNotAvailableForPurchaseError: (message) => message,
  );
}
