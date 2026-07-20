// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Filipino Pilipino (`fil`).
class AppLocalizationsFil extends AppLocalizations {
  AppLocalizationsFil([String locale = 'fil']) : super(locale);

  @override
  String get appName => 'STT Logistics';

  @override
  String get appTagline => 'Beripikasyon ng driver at pamamahala ng shipment';

  @override
  String get splashTagline => 'Tumawag ka, kami ang magha-haul!';

  @override
  String get onboardingTitle1Line1 => 'Smart Logistics.';

  @override
  String get onboardingTitle1Line2 => 'Mas Matibay na Koneksyon.';

  @override
  String get onboardingSubtitle1 =>
      'Pag-verify ng driver. Pamamahala ng shipment. Paghahatid ng tiwala.';

  @override
  String get onboardingTitle2Line1 => 'Lahat ng Kailangan Mo,';

  @override
  String get onboardingTitle2Line2 => 'Sa Isang Lugar.';

  @override
  String get onboardingSubtitle2 =>
      'Tinutulungan ka ng STT App na i-verify ang driver, i-track ang shipment, at manatiling kontrolado.';

  @override
  String get featureDriverTitle => 'Pag-verify ng Driver';

  @override
  String get featureDriverBody =>
      'Mabilis na suriin ang detalye ng driver at STT status.';

  @override
  String get featureShipmentTitle => 'Pamamahala ng Shipment';

  @override
  String get featureShipmentBody =>
      'Lumikha, mag-update, mag-track, at pamahalaan ang lahat ng shipment nang real time.';

  @override
  String get featureRealtimeTitle => 'Real-Time Updates';

  @override
  String get featureRealtimeBody =>
      'Manatiling updated sa live status at gumawa ng mas magandang desisyon.';

  @override
  String get getStarted => 'Magsimula';

  @override
  String get skip => 'Laktawan';

  @override
  String get continueLabel => 'Magpatuloy';

  @override
  String get chooseLanguage => 'Piliin ang wika';

  @override
  String get chooseLanguageHint => 'Mababago mo ito mamaya sa Settings.';

  @override
  String get language => 'Wika';

  @override
  String get settings => 'Settings';

  @override
  String get notifications => 'Mga Abiso';

  @override
  String get pushNotifications => 'Push Notifications';

  @override
  String get pushNotificationsHint =>
      'Tumanggap ng update tungkol sa iyong shipment';

  @override
  String get legal => 'Legal';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get appVersion => 'Bersyon ng app';

  @override
  String get logout => 'Logout';

  @override
  String get confirmLogout => 'Kumpirmahin ang logout';

  @override
  String get confirmLogoutBody => 'Sigurado ka bang gusto mong mag-logout?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Burahin';

  @override
  String get home => 'Home';

  @override
  String get shipments => 'Shipments';

  @override
  String get profile => 'Profile';

  @override
  String get fabTutorialTitle => 'Magdagdag ng shipment';

  @override
  String get fabTutorialBody =>
      'I-tap ang pulang + button para gumawa ng bagong shipment.';

  @override
  String get fabTutorialGotIt => 'Nakuha';

  @override
  String get navDone => 'Tapos';

  @override
  String get welcomeBack => 'Maligayang pagbabalik';

  @override
  String get driverVerification => 'Beripikasyon ng Driver';

  @override
  String get tapCardForLicense => 'I-tap ang card para sa detalye ng lisensya';

  @override
  String get completeProfileForLicense =>
      'Kumpletuhin ang profile para makita ang license card';

  @override
  String get shipmentOverview => 'Overview ng shipment';

  @override
  String get tapToOpenShipments => 'I-tap para buksan ang shipments';

  @override
  String get total => 'Kabuuan';

  @override
  String get statusPending => 'Nakabinbin';

  @override
  String get statusInTransit => 'Nasa transit';

  @override
  String get statusDelivered => 'Naihatid';

  @override
  String get sttVerified => 'STT Verified';

  @override
  String get verificationPending => 'Nakabinbin';

  @override
  String get verificationRejected => 'Tinanggihan';

  @override
  String get addShipment => 'Magdagdag ng Shipment';

  @override
  String get editShipment => 'I-edit ang Shipment';

  @override
  String get deleteShipment => 'Burahin ang Shipment';

  @override
  String get noShipments => 'Wala pang shipment';

  @override
  String get createFirstShipment => 'Gumawa ng unang shipment para magsimula';

  @override
  String get shipmentAdded => 'Matagumpay na naidagdag ang shipment';

  @override
  String get shipmentDeleted => 'Nabura ang shipment';

  @override
  String get shipmentUpdated => 'Na-update ang shipment';

  @override
  String deleteShipmentConfirm(String id) {
    return 'Burahin ang shipment $id?';
  }

  @override
  String get customerName => 'Pangalan ng customer';

  @override
  String get origin => 'Pinagmulan';

  @override
  String get destination => 'Destinasyon';

  @override
  String get status => 'Status';

  @override
  String get updateShipment => 'I-update ang Shipment';

  @override
  String get saveShipment => 'I-save ang Shipment';

  @override
  String get loginTitle => 'Mag-sign in';

  @override
  String get emailHint => 'Email address';

  @override
  String get passwordHint => 'Password';

  @override
  String get loginButton => 'Mag-sign in';

  @override
  String get loginSuccess => 'Matagumpay ang login';

  @override
  String get loginFailed => 'Invalid ang email o password';

  @override
  String get logoutSuccess => 'Matagumpay ang logout';

  @override
  String get logoutFailed => 'Nabigo ang logout';

  @override
  String get registerSuccess => 'Matagumpay ang rehistro';

  @override
  String get registerFailed => 'Nabigo ang rehistro';

  @override
  String get registerTitle => 'Gumawa ng account';

  @override
  String get registerButton => 'Gumawa ng account';

  @override
  String get fullNameHint => 'Buong pangalan';

  @override
  String get phoneHint => 'Numero ng telepono';

  @override
  String get confirmPasswordHint => 'Kumpirmahin ang password';

  @override
  String get cdlHint => 'CDL number';

  @override
  String get hubHint => 'Hub / depot';

  @override
  String get dontHaveAccount => 'Wala pang account?';

  @override
  String get registerNow => 'Magrehistro ngayon';

  @override
  String get alreadyHaveAccount => 'May account na?';

  @override
  String get signInLink => 'Mag-sign in';

  @override
  String get emailExists => 'May account na sa email na ito';

  @override
  String get photoOptionalHint => 'Profile photo (opsyonal)';

  @override
  String get addPhotoHint => 'I-tap para magdagdag ng larawan';

  @override
  String get changePhotoHint => 'I-tap para palitan ang larawan';

  @override
  String get profileUpdated => 'Na-update ang profile';

  @override
  String get fieldRequired => 'Kinakailangan ang field na ito';

  @override
  String get invalidEmail => 'Maglagay ng wastong email';

  @override
  String get invalidPhone => 'Maglagay ng wastong numero';

  @override
  String get passwordTooShort => 'Hindi bababa sa 6 na character ang password';

  @override
  String get passwordsDoNotMatch => 'Hindi magkatugma ang mga password';

  @override
  String get originSameAsDestination =>
      'Dapat magkaiba ang origin at destination';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get removePhoto => 'Alisin ang larawan';

  @override
  String get takePhoto => 'Kumuha ng larawan';

  @override
  String get chooseFromGallery => 'Pumili mula sa gallery';

  @override
  String get driverProfileUnavailable => 'Hindi available ang driver profile';
}
