import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const Failure._(); // constructor privado para métodos comunes

  const factory Failure.network({
    @Default('Sin conexión a internet') String message,
    int? statusCode,
  }) = NetworkFailure;

  const factory Failure.unknown({
    @Default('Error desconocido') String message,
    String? errorCode,
  }) = UnknownFailure;

  const factory Failure.api({
    @Default('Error del servidor') String message,
    int? statusCode,
    String? errorCode,
  }) = ApiFailure;

  const factory Failure.auth({
    @Default('Error de autenticación') String message,
    String? provider, // 'facebook', 'google'
    String? errorCode,
  }) = AuthFailure;

  const factory Failure.validation({
    @Default('Datos inválidos') String message,
    String? field,
    String? errorCode,
  }) = ValidationFailure;

  const factory Failure.business({
    @Default('Error de negocio') String message,
    String? errorCode,
  }) = BusinessFailure;

  const factory Failure.noData([
    @Default('No hay datos disponibles') String message,
  ]) = NoDataFailure;

  const factory Failure.timeout([
    @Default('La solicitud ha expirado') String message,
  ]) = TimeoutFailure;

  const factory Failure.notFound([
    @Default('No se encuentra el objeto') String message,
  ]) = NotFound;

  const factory Failure.storage([
    @Default('Error de almacenamiento local') String message,
  ]) = StorageFailure;

  const factory Failure.supabase([
    @Default('Error con Supabase') String message,
  ]) = SupabaseFailure;

  const factory Failure.biometric([
    @Default('Error con Autenticacion biometrica') String message,
  ]) = BiometricFailure;

  const factory Failure.biometricNoHardware([
    @Default('Tu dispositivo no cuenta con biometria') String message,
  ]) = BiometricNoHardwareFailure;

  const factory Failure.noBiometricsEnrolled([
    @Default('Error con Autenticacion biometrica') String message,
  ]) = NoBiometricsEnrolledFailure;

  const factory Failure.sessionExpired([
    @Default('Sesion expirada') String message,
  ]) = SessionExpiredFailure;

  const factory Failure.cancelled([
    @Default('Operación cancelada por el usuario') String message,
  ]) = CancelledFailure;

  const factory Failure.permissionDenied({
    @Default('Permiso denegado') String message,
    String? permission,
  }) = PermissionDeniedFailure;

  const factory Failure.eventOverlap({
    @Default(
      'Este horario ya está ocupado. El padre seleccionado tiene otro evento en este mismo intervalo.',
    )
    String message,
  }) = EventOverlapFailure;

  const factory Failure.duplicate([
    @Default('Registro duplicado') String message,
  ]) = DuplicateFailure;

  const factory Failure.purchaseCancelledError([
    @Default('La compra fue cancelada') String message,
  ]) = PurchaseCancelledError;

  const factory Failure.storeProblemError([
    @Default('Ocurrió un problema con la tienda') String message,
  ]) = StoreProblemError;

  const factory Failure.productAlreadyPurchasedError([
    @Default('Este producto ya fue comprado anteriormente') String message,
  ]) = ProductAlreadyPurchasedError;

  const factory Failure.purchaseInvalidError([
    @Default('La compra no es válida') String message,
  ]) = PurchaseInvalidError;

  const factory Failure.productNotAvailableForPurchaseError([
    @Default('Este producto no está disponible para la compra') String message,
  ]) = ProductNotAvailableForPurchaseError;
}
