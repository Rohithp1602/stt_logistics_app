// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'STT Logistics';

  @override
  String get appTagline => 'Verifica autisti e gestione spedizioni';

  @override
  String get splashTagline => 'Chiami tu, trasportiamo noi!';

  @override
  String get onboardingTitle1Line1 => 'Logistica smart.';

  @override
  String get onboardingTitle1Line2 => 'Connessioni più forti.';

  @override
  String get onboardingSubtitle1 =>
      'Verifica autisti. Gestisci spedizioni. Consegna fiducia.';

  @override
  String get onboardingTitle2Line1 => 'Tutto ciò che ti serve,';

  @override
  String get onboardingTitle2Line2 => 'in un solo posto.';

  @override
  String get onboardingSubtitle2 =>
      'L\'app STT ti aiuta a verificare gli autisti, tracciare le spedizioni e restare in controllo.';

  @override
  String get featureDriverTitle => 'Verifica autista';

  @override
  String get featureDriverBody =>
      'Verifica rapidamente i dettagli autista e lo stato STT.';

  @override
  String get featureShipmentTitle => 'Gestione spedizioni';

  @override
  String get featureShipmentBody =>
      'Crea, aggiorna, traccia e gestisci tutte le spedizioni in tempo reale.';

  @override
  String get featureRealtimeTitle => 'Aggiornamenti in tempo reale';

  @override
  String get featureRealtimeBody =>
      'Resta aggiornato con lo stato live e prendi decisioni migliori.';

  @override
  String get getStarted => 'Inizia';

  @override
  String get skip => 'Salta';

  @override
  String get continueLabel => 'Continua';

  @override
  String get chooseLanguage => 'Scegli la lingua';

  @override
  String get chooseLanguageHint => 'Potrai cambiarla in Impostazioni.';

  @override
  String get language => 'Lingua';

  @override
  String get settings => 'Impostazioni';

  @override
  String get notifications => 'Notifiche';

  @override
  String get pushNotifications => 'Notifiche push';

  @override
  String get pushNotificationsHint =>
      'Ricevi aggiornamenti sulle tue spedizioni';

  @override
  String get legal => 'Note legali';

  @override
  String get privacyPolicy => 'Informativa sulla privacy';

  @override
  String get termsOfUse => 'Termini d\'uso';

  @override
  String get appVersion => 'Versione dell\'app';

  @override
  String get logout => 'Esci';

  @override
  String get confirmLogout => 'Conferma uscita';

  @override
  String get confirmLogoutBody => 'Sei sicuro di voler uscire?';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get home => 'Home';

  @override
  String get shipments => 'Spedizioni';

  @override
  String get profile => 'Profilo';

  @override
  String get fabTutorialTitle => 'Aggiungi spedizione';

  @override
  String get fabTutorialBody =>
      'Tocca il pulsante rosso + per creare una spedizione.';

  @override
  String get fabTutorialGotIt => 'Ho capito';

  @override
  String get navDone => 'Fatto';

  @override
  String get welcomeBack => 'Bentornato';

  @override
  String get driverVerification => 'Verifica autista';

  @override
  String get tapCardForLicense => 'Tocca la carta per i dettagli della patente';

  @override
  String get completeProfileForLicense =>
      'Completa il profilo per vedere la carta';

  @override
  String get shipmentOverview => 'Panoramica spedizioni';

  @override
  String get tapToOpenShipments => 'Tocca per aprire le spedizioni';

  @override
  String get total => 'Totale';

  @override
  String get statusPending => 'In attesa';

  @override
  String get statusInTransit => 'In transito';

  @override
  String get statusDelivered => 'Consegnato';

  @override
  String get sttVerified => 'Verificato STT';

  @override
  String get verificationPending => 'In attesa';

  @override
  String get verificationRejected => 'Rifiutato';

  @override
  String get addShipment => 'Aggiungi spedizione';

  @override
  String get editShipment => 'Modifica spedizione';

  @override
  String get deleteShipment => 'Elimina spedizione';

  @override
  String get noShipments => 'Nessuna spedizione';

  @override
  String get createFirstShipment => 'Crea la tua prima spedizione per iniziare';

  @override
  String get shipmentAdded => 'Spedizione aggiunta';

  @override
  String get shipmentDeleted => 'Spedizione eliminata';

  @override
  String get shipmentUpdated => 'Spedizione aggiornata';

  @override
  String deleteShipmentConfirm(String id) {
    return 'Eliminare la spedizione $id?';
  }

  @override
  String get customerName => 'Nome cliente';

  @override
  String get origin => 'Origine';

  @override
  String get destination => 'Destinazione';

  @override
  String get status => 'Stato';

  @override
  String get updateShipment => 'Aggiorna spedizione';

  @override
  String get saveShipment => 'Salva spedizione';

  @override
  String get loginTitle => 'Accedi';

  @override
  String get emailHint => 'Email';

  @override
  String get passwordHint => 'Password';

  @override
  String get loginButton => 'Accedi';

  @override
  String get loginSuccess => 'Accesso riuscito';

  @override
  String get loginFailed => 'Email o password non validi';

  @override
  String get logoutSuccess => 'Disconnessione riuscita';

  @override
  String get logoutFailed => 'Disconnessione non riuscita';

  @override
  String get registerSuccess => 'Registrazione riuscita';

  @override
  String get registerFailed => 'Registrazione non riuscita';

  @override
  String get registerTitle => 'Crea account';

  @override
  String get registerButton => 'Crea account';

  @override
  String get fullNameHint => 'Nome completo';

  @override
  String get phoneHint => 'Telefono';

  @override
  String get confirmPasswordHint => 'Conferma password';

  @override
  String get cdlHint => 'Numero CDL';

  @override
  String get hubHint => 'Hub / deposito';

  @override
  String get dontHaveAccount => 'Non hai un account?';

  @override
  String get registerNow => 'Registrati ora';

  @override
  String get alreadyHaveAccount => 'Hai già un account?';

  @override
  String get signInLink => 'Accedi';

  @override
  String get emailExists => 'Esiste già un account con questa email';

  @override
  String get photoOptionalHint => 'Foto profilo (opzionale)';

  @override
  String get addPhotoHint => 'Tocca per aggiungere una foto';

  @override
  String get changePhotoHint => 'Tocca per cambiare foto';

  @override
  String get profileUpdated => 'Profilo aggiornato';

  @override
  String get fieldRequired => 'Questo campo è obbligatorio';

  @override
  String get invalidEmail => 'Inserisci un\'email valida';

  @override
  String get invalidPhone => 'Inserisci un telefono valido';

  @override
  String get passwordTooShort => 'La password deve avere almeno 6 caratteri';

  @override
  String get passwordsDoNotMatch => 'Le password non coincidono';

  @override
  String get originSameAsDestination =>
      'Origine e destinazione devono essere diverse';

  @override
  String get camera => 'Fotocamera';

  @override
  String get gallery => 'Galleria';

  @override
  String get removePhoto => 'Rimuovi foto';

  @override
  String get takePhoto => 'Scatta foto';

  @override
  String get chooseFromGallery => 'Scegli dalla galleria';

  @override
  String get driverProfileUnavailable => 'Profilo autista non disponibile';
}
