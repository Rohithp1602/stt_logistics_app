// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'STT Logistics';

  @override
  String get appTagline =>
      'Vérification des conducteurs et gestion des expéditions';

  @override
  String get splashTagline => 'Vous appelez, nous livrons. C\'est tout !';

  @override
  String get onboardingTitle1Line1 => 'Logistique intelligente.';

  @override
  String get onboardingTitle1Line2 => 'Des liens plus forts.';

  @override
  String get onboardingSubtitle1 =>
      'Vérifier les conducteurs. Gérer les envois. Livrer la confiance.';

  @override
  String get onboardingTitle2Line1 => 'Tout ce dont vous avez besoin,';

  @override
  String get onboardingTitle2Line2 => 'au même endroit.';

  @override
  String get onboardingSubtitle2 =>
      'L\'app STT vous aide à vérifier les conducteurs, suivre les envois et rester maître à tout moment.';

  @override
  String get featureDriverTitle => 'Vérification du conducteur';

  @override
  String get featureDriverBody =>
      'Vérifiez rapidement les détails du conducteur et le statut STT.';

  @override
  String get featureShipmentTitle => 'Gestion des envois';

  @override
  String get featureShipmentBody =>
      'Créez, mettez à jour et suivez tous vos envois en temps réel.';

  @override
  String get featureRealtimeTitle => 'Mises à jour en temps réel';

  @override
  String get featureRealtimeBody =>
      'Restez informé du statut en direct et prenez de meilleures décisions.';

  @override
  String get getStarted => 'Commencer';

  @override
  String get skip => 'Passer';

  @override
  String get continueLabel => 'Continuer';

  @override
  String get chooseLanguage => 'Choisissez votre langue';

  @override
  String get chooseLanguageHint =>
      'Vous pourrez la changer plus tard dans Réglages.';

  @override
  String get language => 'Langue';

  @override
  String get settings => 'Réglages';

  @override
  String get notifications => 'Notifications';

  @override
  String get pushNotifications => 'Notifications push';

  @override
  String get pushNotificationsHint =>
      'Recevoir des mises à jour sur vos envois';

  @override
  String get legal => 'Mentions légales';

  @override
  String get privacyPolicy => 'Politique de confidentialité';

  @override
  String get termsOfUse => 'Conditions d\'utilisation';

  @override
  String get appVersion => 'Version de l\'app';

  @override
  String get logout => 'Déconnexion';

  @override
  String get confirmLogout => 'Confirmer la déconnexion';

  @override
  String get confirmLogoutBody => 'Voulez-vous vraiment vous déconnecter ?';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get home => 'Accueil';

  @override
  String get shipments => 'Envois';

  @override
  String get profile => 'Profil';

  @override
  String get fabTutorialTitle => 'Ajouter un envoi';

  @override
  String get fabTutorialBody =>
      'Appuyez sur le bouton rouge + pour créer un envoi.';

  @override
  String get fabTutorialGotIt => 'J\'ai compris';

  @override
  String get navDone => 'Terminé';

  @override
  String get welcomeBack => 'Bon retour';

  @override
  String get driverVerification => 'Vérification du conducteur';

  @override
  String get tapCardForLicense =>
      'Appuyez sur la carte pour les détails du permis';

  @override
  String get completeProfileForLicense =>
      'Complétez le profil pour voir la carte de permis';

  @override
  String get shipmentOverview => 'Aperçu des expéditions';

  @override
  String get tapToOpenShipments => 'Appuyez pour ouvrir les expéditions';

  @override
  String get total => 'Total';

  @override
  String get statusPending => 'En attente';

  @override
  String get statusInTransit => 'En transit';

  @override
  String get statusDelivered => 'Livré';

  @override
  String get sttVerified => 'Vérifié STT';

  @override
  String get verificationPending => 'En attente';

  @override
  String get verificationRejected => 'Rejeté';

  @override
  String get addShipment => 'Ajouter une expédition';

  @override
  String get editShipment => 'Modifier l\'expédition';

  @override
  String get deleteShipment => 'Supprimer l\'expédition';

  @override
  String get noShipments => 'Pas encore d\'expéditions';

  @override
  String get createFirstShipment =>
      'Créez votre première expédition pour commencer';

  @override
  String get shipmentAdded => 'Expédition ajoutée avec succès';

  @override
  String get shipmentDeleted => 'Expédition supprimée';

  @override
  String get shipmentUpdated => 'Expédition mise à jour';

  @override
  String deleteShipmentConfirm(String id) {
    return 'Supprimer l\'expédition $id ?';
  }

  @override
  String get customerName => 'Nom du client';

  @override
  String get origin => 'Origine';

  @override
  String get destination => 'Destination';

  @override
  String get status => 'Statut';

  @override
  String get updateShipment => 'Mettre à jour';

  @override
  String get saveShipment => 'Enregistrer l\'expédition';

  @override
  String get loginTitle => 'Connexion';

  @override
  String get emailHint => 'Adresse e-mail';

  @override
  String get passwordHint => 'Mot de passe';

  @override
  String get loginButton => 'Connexion';

  @override
  String get loginSuccess => 'Connexion réussie';

  @override
  String get loginFailed => 'E-mail ou mot de passe invalide';

  @override
  String get logoutSuccess => 'Déconnexion réussie';

  @override
  String get logoutFailed => 'Échec de la déconnexion';

  @override
  String get registerSuccess => 'Inscription réussie';

  @override
  String get registerFailed => 'Échec de l\'inscription';

  @override
  String get registerTitle => 'Créer un compte';

  @override
  String get registerButton => 'Créer un compte';

  @override
  String get fullNameHint => 'Nom complet';

  @override
  String get phoneHint => 'Numéro de téléphone';

  @override
  String get confirmPasswordHint => 'Confirmer le mot de passe';

  @override
  String get cdlHint => 'Numéro CDL';

  @override
  String get hubHint => 'Hub / dépôt';

  @override
  String get dontHaveAccount => 'Pas encore de compte ?';

  @override
  String get registerNow => 'S\'inscrire';

  @override
  String get alreadyHaveAccount => 'Déjà un compte ?';

  @override
  String get signInLink => 'Connexion';

  @override
  String get emailExists => 'Un compte avec cet e-mail existe déjà';

  @override
  String get photoOptionalHint => 'Photo de profil (facultatif)';

  @override
  String get addPhotoHint => 'Appuyez pour ajouter une photo';

  @override
  String get changePhotoHint => 'Appuyez pour changer la photo';

  @override
  String get profileUpdated => 'Profil mis à jour';

  @override
  String get fieldRequired => 'Ce champ est obligatoire';

  @override
  String get invalidEmail => 'Entrez une adresse e-mail valide';

  @override
  String get invalidPhone => 'Entrez un numéro de téléphone valide';

  @override
  String get passwordTooShort =>
      'Le mot de passe doit contenir au moins 6 caractères';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get originSameAsDestination =>
      'L\'origine et la destination doivent être différentes';

  @override
  String get camera => 'Appareil photo';

  @override
  String get gallery => 'Galerie';

  @override
  String get removePhoto => 'Supprimer la photo';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get chooseFromGallery => 'Choisir depuis la galerie';

  @override
  String get driverProfileUnavailable => 'Profil conducteur indisponible';
}
