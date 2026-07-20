// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'STT Logistics';

  @override
  String get appTagline => 'Fahrerprüfung & Sendungsverwaltung';

  @override
  String get splashTagline =>
      'Sie rufen an, wir transportieren. Das ist alles!';

  @override
  String get onboardingTitle1Line1 => 'Intelligente Logistik.';

  @override
  String get onboardingTitle1Line2 => 'Stärkere Verbindungen.';

  @override
  String get onboardingSubtitle1 =>
      'Fahrer prüfen. Sendungen verwalten. Vertrauen liefern.';

  @override
  String get onboardingTitle2Line1 => 'Alles was Sie brauchen,';

  @override
  String get onboardingTitle2Line2 => 'an einem Ort.';

  @override
  String get onboardingSubtitle2 =>
      'STT App hilft Ihnen, Fahrer zu prüfen, Sendungen zu verfolgen und die Kontrolle zu behalten.';

  @override
  String get featureDriverTitle => 'Fahrerprüfung';

  @override
  String get featureDriverBody => 'Fahrerdaten und STT-Status schnell prüfen.';

  @override
  String get featureShipmentTitle => 'Sendungsverwaltung';

  @override
  String get featureShipmentBody =>
      'Sendungen in Echtzeit erstellen, aktualisieren und verfolgen.';

  @override
  String get featureRealtimeTitle => 'Echtzeit-Updates';

  @override
  String get featureRealtimeBody =>
      'Bleiben Sie mit Live-Status auf dem Laufenden.';

  @override
  String get getStarted => 'Loslegen';

  @override
  String get skip => 'Überspringen';

  @override
  String get continueLabel => 'Weiter';

  @override
  String get chooseLanguage => 'Sprache wählen';

  @override
  String get chooseLanguageHint =>
      'Sie können dies später in den Einstellungen ändern.';

  @override
  String get language => 'Sprache';

  @override
  String get settings => 'Einstellungen';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get pushNotifications => 'Push-Benachrichtigungen';

  @override
  String get pushNotificationsHint => 'Updates zu Ihren Sendungen erhalten';

  @override
  String get legal => 'Rechtliches';

  @override
  String get privacyPolicy => 'Datenschutz';

  @override
  String get termsOfUse => 'Nutzungsbedingungen';

  @override
  String get appVersion => 'App-Version';

  @override
  String get logout => 'Abmelden';

  @override
  String get confirmLogout => 'Abmelden bestätigen';

  @override
  String get confirmLogoutBody => 'Möchten Sie sich wirklich abmelden?';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get home => 'Start';

  @override
  String get shipments => 'Sendungen';

  @override
  String get profile => 'Profil';

  @override
  String get fabTutorialTitle => 'Sendung hinzufügen';

  @override
  String get fabTutorialBody =>
      'Tippen Sie jederzeit auf die rote +-Taste, um eine Sendung zu erstellen.';

  @override
  String get fabTutorialGotIt => 'Verstanden';

  @override
  String get navDone => 'Fertig';

  @override
  String get welcomeBack => 'Willkommen zurück';

  @override
  String get driverVerification => 'Fahrerprüfung';

  @override
  String get tapCardForLicense => 'Tippen Sie auf die Karte für Lizenzdetails';

  @override
  String get completeProfileForLicense =>
      'Profil vervollständigen, um die Lizenzkarte zu sehen';

  @override
  String get shipmentOverview => 'Sendungsübersicht';

  @override
  String get tapToOpenShipments => 'Tippen, um Sendungen zu öffnen';

  @override
  String get total => 'Gesamt';

  @override
  String get statusPending => 'Ausstehend';

  @override
  String get statusInTransit => 'Unterwegs';

  @override
  String get statusDelivered => 'Zugestellt';

  @override
  String get sttVerified => 'STT verifiziert';

  @override
  String get verificationPending => 'Ausstehend';

  @override
  String get verificationRejected => 'Abgelehnt';

  @override
  String get addShipment => 'Sendung hinzufügen';

  @override
  String get editShipment => 'Sendung bearbeiten';

  @override
  String get deleteShipment => 'Sendung löschen';

  @override
  String get noShipments => 'Noch keine Sendungen';

  @override
  String get createFirstShipment => 'Erstellen Sie Ihre erste Sendung';

  @override
  String get shipmentAdded => 'Sendung erfolgreich hinzugefügt';

  @override
  String get shipmentDeleted => 'Sendung gelöscht';

  @override
  String get shipmentUpdated => 'Sendung aktualisiert';

  @override
  String deleteShipmentConfirm(String id) {
    return 'Sendung $id löschen?';
  }

  @override
  String get customerName => 'Kundenname';

  @override
  String get origin => 'Herkunft';

  @override
  String get destination => 'Ziel';

  @override
  String get status => 'Status';

  @override
  String get updateShipment => 'Sendung aktualisieren';

  @override
  String get saveShipment => 'Sendung speichern';

  @override
  String get loginTitle => 'Anmelden';

  @override
  String get emailHint => 'E-Mail-Adresse';

  @override
  String get passwordHint => 'Passwort';

  @override
  String get loginButton => 'Anmelden';

  @override
  String get loginSuccess => 'Anmeldung erfolgreich';

  @override
  String get loginFailed => 'Ungültige E-Mail oder Passwort';

  @override
  String get logoutSuccess => 'Erfolgreich abgemeldet';

  @override
  String get logoutFailed => 'Abmelden fehlgeschlagen';

  @override
  String get registerSuccess => 'Registrierung erfolgreich';

  @override
  String get registerFailed => 'Registrierung fehlgeschlagen';

  @override
  String get registerTitle => 'Konto erstellen';

  @override
  String get registerButton => 'Konto erstellen';

  @override
  String get fullNameHint => 'Vollständiger Name';

  @override
  String get phoneHint => 'Telefonnummer';

  @override
  String get confirmPasswordHint => 'Passwort bestätigen';

  @override
  String get cdlHint => 'CDL-Nummer';

  @override
  String get hubHint => 'Hub / Depot';

  @override
  String get dontHaveAccount => 'Noch kein Konto?';

  @override
  String get registerNow => 'Jetzt registrieren';

  @override
  String get alreadyHaveAccount => 'Bereits ein Konto?';

  @override
  String get signInLink => 'Anmelden';

  @override
  String get emailExists => 'Ein Konto mit dieser E-Mail existiert bereits';

  @override
  String get photoOptionalHint => 'Profilfoto (optional)';

  @override
  String get addPhotoHint => 'Tippen, um ein Foto hinzuzufügen';

  @override
  String get changePhotoHint => 'Tippen, um Foto zu ändern';

  @override
  String get profileUpdated => 'Profil erfolgreich aktualisiert';

  @override
  String get fieldRequired => 'Dieses Feld ist erforderlich';

  @override
  String get invalidEmail => 'Gültige E-Mail eingeben';

  @override
  String get invalidPhone => 'Gültige Telefonnummer eingeben';

  @override
  String get passwordTooShort => 'Passwort muss mindestens 6 Zeichen haben';

  @override
  String get passwordsDoNotMatch => 'Passwörter stimmen nicht überein';

  @override
  String get originSameAsDestination =>
      'Herkunft und Ziel müssen unterschiedlich sein';

  @override
  String get camera => 'Kamera';

  @override
  String get gallery => 'Galerie';

  @override
  String get removePhoto => 'Foto entfernen';

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get chooseFromGallery => 'Aus Galerie wählen';

  @override
  String get driverProfileUnavailable => 'Fahrerprofil nicht verfügbar';
}
