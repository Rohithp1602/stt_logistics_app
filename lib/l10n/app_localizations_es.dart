// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'STT Logistics';

  @override
  String get appTagline => 'Verificación de conductores y gestión de envíos';

  @override
  String get splashTagline =>
      'Tú llamas, nosotros transportamos. ¡Eso es todo!';

  @override
  String get onboardingTitle1Line1 => 'Logística inteligente.';

  @override
  String get onboardingTitle1Line2 => 'Conexiones más fuertes.';

  @override
  String get onboardingSubtitle1 =>
      'Verificando conductores. Gestionando envíos. Entregando confianza.';

  @override
  String get onboardingTitle2Line1 => 'Todo lo que necesitas,';

  @override
  String get onboardingTitle2Line2 => 'en un solo lugar.';

  @override
  String get onboardingSubtitle2 =>
      'STT App te ayuda a verificar conductores, rastrear envíos y mantener el control en cualquier momento.';

  @override
  String get featureDriverTitle => 'Verificación del conductor';

  @override
  String get featureDriverBody =>
      'Verifica rápidamente los datos del conductor y el estado STT.';

  @override
  String get featureShipmentTitle => 'Gestión de envíos';

  @override
  String get featureShipmentBody =>
      'Crea, actualiza, rastrea y administra todos tus envíos en tiempo real.';

  @override
  String get featureRealtimeTitle => 'Actualizaciones en tiempo real';

  @override
  String get featureRealtimeBody =>
      'Mantente al día con el estado en vivo y toma mejores decisiones.';

  @override
  String get getStarted => 'Comenzar';

  @override
  String get skip => 'Omitir';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get chooseLanguage => 'Elige tu idioma';

  @override
  String get chooseLanguageHint => 'Puedes cambiarlo después en Ajustes.';

  @override
  String get language => 'Idioma';

  @override
  String get settings => 'Ajustes';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get pushNotifications => 'Notificaciones push';

  @override
  String get pushNotificationsHint => 'Recibe actualizaciones sobre tus envíos';

  @override
  String get legal => 'Legal';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get termsOfUse => 'Términos de uso';

  @override
  String get appVersion => 'Versión de la app';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get confirmLogout => 'Confirmar cierre de sesión';

  @override
  String get confirmLogoutBody => '¿Seguro que quieres cerrar sesión?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get home => 'Inicio';

  @override
  String get shipments => 'Envíos';

  @override
  String get profile => 'Perfil';

  @override
  String get fabTutorialTitle => 'Agregar un envío';

  @override
  String get fabTutorialBody =>
      'Toca el botón rojo + en cualquier momento para crear un envío.';

  @override
  String get fabTutorialGotIt => 'Entendido';

  @override
  String get navDone => 'Listo';

  @override
  String get welcomeBack => 'Bienvenido de nuevo';

  @override
  String get driverVerification => 'Verificación del conductor';

  @override
  String get tapCardForLicense =>
      'Toca la tarjeta para ver los detalles de la licencia';

  @override
  String get completeProfileForLicense =>
      'Completa el perfil para ver la tarjeta de licencia';

  @override
  String get shipmentOverview => 'Resumen de envíos';

  @override
  String get tapToOpenShipments => 'Toca para abrir envíos';

  @override
  String get total => 'Total';

  @override
  String get statusPending => 'Pendiente';

  @override
  String get statusInTransit => 'En tránsito';

  @override
  String get statusDelivered => 'Entregado';

  @override
  String get sttVerified => 'Verificado STT';

  @override
  String get verificationPending => 'Pendiente';

  @override
  String get verificationRejected => 'Rechazado';

  @override
  String get addShipment => 'Agregar envío';

  @override
  String get editShipment => 'Editar envío';

  @override
  String get deleteShipment => 'Eliminar envío';

  @override
  String get noShipments => 'Aún no hay envíos';

  @override
  String get createFirstShipment => 'Crea tu primer envío para comenzar';

  @override
  String get shipmentAdded => 'Envío agregado correctamente';

  @override
  String get shipmentDeleted => 'Envío eliminado';

  @override
  String get shipmentUpdated => 'Envío actualizado';

  @override
  String deleteShipmentConfirm(String id) {
    return '¿Eliminar envío $id?';
  }

  @override
  String get customerName => 'Nombre del cliente';

  @override
  String get origin => 'Origen';

  @override
  String get destination => 'Destino';

  @override
  String get status => 'Estado';

  @override
  String get updateShipment => 'Actualizar envío';

  @override
  String get saveShipment => 'Guardar envío';

  @override
  String get loginTitle => 'Iniciar sesión';

  @override
  String get emailHint => 'Correo electrónico';

  @override
  String get passwordHint => 'Contraseña';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get loginSuccess => 'Inicio de sesión exitoso';

  @override
  String get loginFailed => 'Correo o contraseña inválidos';

  @override
  String get logoutSuccess => 'Sesión cerrada correctamente';

  @override
  String get logoutFailed => 'Error al cerrar sesión';

  @override
  String get registerSuccess => 'Registro exitoso';

  @override
  String get registerFailed => 'Error en el registro';

  @override
  String get registerTitle => 'Crear cuenta';

  @override
  String get registerButton => 'Crear cuenta';

  @override
  String get fullNameHint => 'Nombre completo';

  @override
  String get phoneHint => 'Número de teléfono';

  @override
  String get confirmPasswordHint => 'Confirmar contraseña';

  @override
  String get cdlHint => 'Número de CDL';

  @override
  String get hubHint => 'Centro / depósito';

  @override
  String get dontHaveAccount => '¿No tienes una cuenta?';

  @override
  String get registerNow => 'Regístrate ahora';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get signInLink => 'Iniciar sesión';

  @override
  String get emailExists => 'Ya existe una cuenta con este correo';

  @override
  String get photoOptionalHint => 'Foto de perfil (opcional)';

  @override
  String get addPhotoHint => 'Toca para agregar una foto';

  @override
  String get changePhotoHint => 'Toca para cambiar la foto';

  @override
  String get profileUpdated => 'Perfil actualizado correctamente';

  @override
  String get fieldRequired => 'Este campo es obligatorio';

  @override
  String get invalidEmail => 'Ingresa un correo válido';

  @override
  String get invalidPhone => 'Ingresa un teléfono válido';

  @override
  String get passwordTooShort =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get originSameAsDestination =>
      'El origen y el destino deben ser diferentes';

  @override
  String get camera => 'Cámara';

  @override
  String get gallery => 'Galería';

  @override
  String get removePhoto => 'Eliminar foto';

  @override
  String get takePhoto => 'Tomar foto';

  @override
  String get chooseFromGallery => 'Elegir de la galería';

  @override
  String get driverProfileUnavailable => 'Perfil de conductor no disponible';
}

/// The translations for Spanish Castilian, as used in Mexico (`es_MX`).
class AppLocalizationsEsMx extends AppLocalizationsEs {
  AppLocalizationsEsMx() : super('es_MX');

  @override
  String get appName => 'STT Logistics';

  @override
  String get appTagline => 'Verificación de conductores y gestión de envíos';

  @override
  String get splashTagline =>
      'Tú llamas, nosotros transportamos. ¡Eso es todo!';

  @override
  String get onboardingTitle1Line1 => 'Logística inteligente.';

  @override
  String get onboardingTitle1Line2 => 'Conexiones más fuertes.';

  @override
  String get onboardingSubtitle1 =>
      'Verificando conductores. Gestionando envíos. Entregando confianza.';

  @override
  String get onboardingTitle2Line1 => 'Todo lo que necesitas,';

  @override
  String get onboardingTitle2Line2 => 'en un solo lugar.';

  @override
  String get onboardingSubtitle2 =>
      'STT App te ayuda a verificar conductores, rastrear envíos y mantener el control en cualquier momento.';

  @override
  String get featureDriverTitle => 'Verificación del conductor';

  @override
  String get featureDriverBody =>
      'Verifica rápidamente los datos del conductor y el estado STT.';

  @override
  String get featureShipmentTitle => 'Gestión de envíos';

  @override
  String get featureShipmentBody =>
      'Crea, actualiza, rastrea y administra todos tus envíos en tiempo real.';

  @override
  String get featureRealtimeTitle => 'Actualizaciones en tiempo real';

  @override
  String get featureRealtimeBody =>
      'Mantente al día con el estado en vivo y toma mejores decisiones.';

  @override
  String get getStarted => 'Comenzar';

  @override
  String get skip => 'Omitir';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get chooseLanguage => 'Elige tu idioma';

  @override
  String get chooseLanguageHint => 'Puedes cambiarlo después en Configuración.';

  @override
  String get language => 'Idioma';

  @override
  String get settings => 'Ajustes';

  @override
  String get notifications => 'Notificaciones';

  @override
  String get pushNotifications => 'Notificaciones push';

  @override
  String get pushNotificationsHint => 'Recibe actualizaciones sobre tus envíos';

  @override
  String get legal => 'Legal';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get termsOfUse => 'Términos de uso';

  @override
  String get appVersion => 'Versión de la app';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get confirmLogout => 'Confirmar cierre de sesión';

  @override
  String get confirmLogoutBody => '¿Seguro que quieres cerrar sesión?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get home => 'Inicio';

  @override
  String get shipments => 'Envíos';

  @override
  String get profile => 'Perfil';

  @override
  String get fabTutorialTitle => 'Agregar un envío';

  @override
  String get fabTutorialBody =>
      'Toca el botón rojo + en cualquier momento para crear un envío.';

  @override
  String get fabTutorialGotIt => 'Entendido';

  @override
  String get navDone => 'Listo';

  @override
  String get welcomeBack => 'Bienvenido de nuevo';

  @override
  String get driverVerification => 'Verificación del conductor';

  @override
  String get tapCardForLicense =>
      'Toca la tarjeta para ver los detalles de la licencia';

  @override
  String get completeProfileForLicense =>
      'Completa el perfil para ver la tarjeta de licencia';

  @override
  String get shipmentOverview => 'Resumen de envíos';

  @override
  String get tapToOpenShipments => 'Toca para abrir envíos';

  @override
  String get total => 'Total';

  @override
  String get statusPending => 'Pendiente';

  @override
  String get statusInTransit => 'En tránsito';

  @override
  String get statusDelivered => 'Entregado';

  @override
  String get sttVerified => 'Verificado STT';

  @override
  String get verificationPending => 'Pendiente';

  @override
  String get verificationRejected => 'Rechazado';

  @override
  String get addShipment => 'Agregar envío';

  @override
  String get editShipment => 'Editar envío';

  @override
  String get deleteShipment => 'Eliminar envío';

  @override
  String get noShipments => 'Aún no hay envíos';

  @override
  String get createFirstShipment => 'Crea tu primer envío para comenzar';

  @override
  String get shipmentAdded => 'Envío agregado correctamente';

  @override
  String get shipmentDeleted => 'Envío eliminado';

  @override
  String get shipmentUpdated => 'Envío actualizado';

  @override
  String deleteShipmentConfirm(String id) {
    return '¿Eliminar envío $id?';
  }

  @override
  String get customerName => 'Nombre del cliente';

  @override
  String get origin => 'Origen';

  @override
  String get destination => 'Destino';

  @override
  String get status => 'Estado';

  @override
  String get updateShipment => 'Actualizar envío';

  @override
  String get saveShipment => 'Guardar envío';

  @override
  String get loginTitle => 'Iniciar sesión';

  @override
  String get emailHint => 'Correo electrónico';

  @override
  String get passwordHint => 'Contraseña';

  @override
  String get loginButton => 'Iniciar sesión';

  @override
  String get loginSuccess => 'Inicio de sesión exitoso';

  @override
  String get loginFailed => 'Correo o contraseña inválidos';

  @override
  String get logoutSuccess => 'Sesión cerrada correctamente';

  @override
  String get logoutFailed => 'Error al cerrar sesión';

  @override
  String get registerSuccess => 'Registro exitoso';

  @override
  String get registerFailed => 'Error en el registro';

  @override
  String get registerTitle => 'Crear cuenta';

  @override
  String get registerButton => 'Crear cuenta';

  @override
  String get fullNameHint => 'Nombre completo';

  @override
  String get phoneHint => 'Número de teléfono';

  @override
  String get confirmPasswordHint => 'Confirmar contraseña';

  @override
  String get cdlHint => 'Número de CDL';

  @override
  String get hubHint => 'Centro / depósito';

  @override
  String get dontHaveAccount => '¿No tienes una cuenta?';

  @override
  String get registerNow => 'Regístrate ahora';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get signInLink => 'Iniciar sesión';

  @override
  String get emailExists => 'Ya existe una cuenta con este correo';

  @override
  String get photoOptionalHint => 'Foto de perfil (opcional)';

  @override
  String get addPhotoHint => 'Toca para agregar una foto';

  @override
  String get changePhotoHint => 'Toca para cambiar la foto';

  @override
  String get profileUpdated => 'Perfil actualizado correctamente';

  @override
  String get fieldRequired => 'Este campo es obligatorio';

  @override
  String get invalidEmail => 'Ingresa un correo válido';

  @override
  String get invalidPhone => 'Ingresa un teléfono válido';

  @override
  String get passwordTooShort =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get originSameAsDestination =>
      'El origen y el destino deben ser diferentes';

  @override
  String get camera => 'Cámara';

  @override
  String get gallery => 'Galería';

  @override
  String get removePhoto => 'Eliminar foto';

  @override
  String get takePhoto => 'Tomar foto';

  @override
  String get chooseFromGallery => 'Elegir de la galería';

  @override
  String get driverProfileUnavailable => 'Perfil de conductor no disponible';
}
