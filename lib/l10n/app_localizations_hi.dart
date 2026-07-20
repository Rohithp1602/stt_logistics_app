// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'STT Logistics';

  @override
  String get appTagline => 'ड्राइवर सत्यापन और शिपमेंट प्रबंधन';

  @override
  String get splashTagline => 'आप कॉल करें, हम पहुँचाएँ। बस इतना!';

  @override
  String get onboardingTitle1Line1 => 'स्मार्ट लॉजिस्टिक्स।';

  @override
  String get onboardingTitle1Line2 => 'मज़बूत कनेक्शन।';

  @override
  String get onboardingSubtitle1 =>
      'ड्राइवर सत्यापन। शिपमेंट प्रबंधन। विश्वास की डिलीवरी।';

  @override
  String get onboardingTitle2Line1 => 'आपको जो चाहिए,';

  @override
  String get onboardingTitle2Line2 => 'सब एक जगह।';

  @override
  String get onboardingSubtitle2 =>
      'STT ऐप ड्राइवर सत्यापित करने, शिपमेंट ट्रैक करने और नियंत्रण में रहने में मदद करता है।';

  @override
  String get featureDriverTitle => 'ड्राइवर सत्यापन';

  @override
  String get featureDriverBody => 'ड्राइवर विवरण और STT स्थिति जल्दी जाँचें।';

  @override
  String get featureShipmentTitle => 'शिपमेंट प्रबंधन';

  @override
  String get featureShipmentBody =>
      'रियल टाइम में शिपमेंट बनाएँ, अपडेट करें और ट्रैक करें।';

  @override
  String get featureRealtimeTitle => 'रियल-टाइम अपडेट';

  @override
  String get featureRealtimeBody => 'लाइव स्थिति से अपडेट रहें।';

  @override
  String get getStarted => 'शुरू करें';

  @override
  String get skip => 'छोड़ें';

  @override
  String get continueLabel => 'जारी रखें';

  @override
  String get chooseLanguage => 'अपनी भाषा चुनें';

  @override
  String get chooseLanguageHint => 'बाद में सेटिंग्स में बदल सकते हैं।';

  @override
  String get language => 'भाषा';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get notifications => 'सूचनाएँ';

  @override
  String get pushNotifications => 'पुश सूचनाएँ';

  @override
  String get pushNotificationsHint => 'अपने शिपमेंट की अपडेट पाएँ';

  @override
  String get legal => 'कानूनी';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get termsOfUse => 'उपयोग की शर्तें';

  @override
  String get appVersion => 'ऐप संस्करण';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get confirmLogout => 'लॉग आउट की पुष्टि';

  @override
  String get confirmLogoutBody => 'क्या आप वाकई लॉग आउट करना चाहते हैं?';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएँ';

  @override
  String get home => 'होम';

  @override
  String get shipments => 'शिपमेंट';

  @override
  String get profile => 'प्रोफ़ाइल';

  @override
  String get fabTutorialTitle => 'शिपमेंट जोड़ें';

  @override
  String get fabTutorialBody => 'नया शिपमेंट बनाने के लिए लाल + बटन टैप करें।';

  @override
  String get fabTutorialGotIt => 'समझ गया';

  @override
  String get navDone => 'हो गया';

  @override
  String get welcomeBack => 'वापसी पर स्वागत है';

  @override
  String get driverVerification => 'ड्राइवर सत्यापन';

  @override
  String get tapCardForLicense => 'लाइसेंस विवरण के लिए कार्ड टैप करें';

  @override
  String get completeProfileForLicense =>
      'लाइसेंस कार्ड देखने के लिए प्रोफ़ाइल पूरा करें';

  @override
  String get shipmentOverview => 'शिपमेंट अवलोकन';

  @override
  String get tapToOpenShipments => 'शिपमेंट खोलने के लिए टैप करें';

  @override
  String get total => 'कुल';

  @override
  String get statusPending => 'लंबित';

  @override
  String get statusInTransit => 'ट्रांज़िट में';

  @override
  String get statusDelivered => 'डिलीवर';

  @override
  String get sttVerified => 'STT सत्यापित';

  @override
  String get verificationPending => 'लंबित';

  @override
  String get verificationRejected => 'अस्वीकृत';

  @override
  String get addShipment => 'शिपमेंट जोड़ें';

  @override
  String get editShipment => 'शिपमेंट संपादित करें';

  @override
  String get deleteShipment => 'शिपमेंट हटाएँ';

  @override
  String get noShipments => 'अभी कोई शिपमेंट नहीं';

  @override
  String get createFirstShipment => 'शुरू करने के लिए पहला शिपमेंट बनाएँ';

  @override
  String get shipmentAdded => 'शिपमेंट सफलतापूर्वक जोड़ा गया';

  @override
  String get shipmentDeleted => 'शिपमेंट हटाया गया';

  @override
  String get shipmentUpdated => 'शिपमेंट अपडेट हुआ';

  @override
  String deleteShipmentConfirm(String id) {
    return 'शिपमेंट $id हटाएँ?';
  }

  @override
  String get customerName => 'ग्राहक का नाम';

  @override
  String get origin => 'उत्पत्ति';

  @override
  String get destination => 'गंतव्य';

  @override
  String get status => 'स्थिति';

  @override
  String get updateShipment => 'शिपमेंट अपडेट करें';

  @override
  String get saveShipment => 'शिपमेंट सहेजें';

  @override
  String get loginTitle => 'साइन इन';

  @override
  String get emailHint => 'ईमेल पता';

  @override
  String get passwordHint => 'पासवर्ड';

  @override
  String get loginButton => 'साइन इन';

  @override
  String get loginSuccess => 'लॉगिन सफल';

  @override
  String get loginFailed => 'अमान्य ईमेल या पासवर्ड';

  @override
  String get logoutSuccess => 'सफलतापूर्वक लॉग आउट';

  @override
  String get logoutFailed => 'लॉग आउट विफल';

  @override
  String get registerSuccess => 'पंजीकरण सफल';

  @override
  String get registerFailed => 'पंजीकरण विफल';

  @override
  String get registerTitle => 'खाता बनाएँ';

  @override
  String get registerButton => 'खाता बनाएँ';

  @override
  String get fullNameHint => 'पूरा नाम';

  @override
  String get phoneHint => 'फ़ोन नंबर';

  @override
  String get confirmPasswordHint => 'पासवर्ड की पुष्टि';

  @override
  String get cdlHint => 'CDL नंबर';

  @override
  String get hubHint => 'हब / डिपो';

  @override
  String get dontHaveAccount => 'खाता नहीं है?';

  @override
  String get registerNow => 'अभी पंजीकरण करें';

  @override
  String get alreadyHaveAccount => 'पहले से खाता है?';

  @override
  String get signInLink => 'साइन इन';

  @override
  String get emailExists => 'इस ईमेल से खाता पहले से मौजूद है';

  @override
  String get photoOptionalHint => 'प्रोफ़ाइल फ़ोटो (वैकल्पिक)';

  @override
  String get addPhotoHint => 'फ़ोटो जोड़ने के लिए टैप करें';

  @override
  String get changePhotoHint => 'फ़ोटो बदलने के लिए टैप करें';

  @override
  String get profileUpdated => 'प्रोफ़ाइल अपडेट सफल';

  @override
  String get fieldRequired => 'यह फ़ील्ड आवश्यक है';

  @override
  String get invalidEmail => 'मान्य ईमेल दर्ज करें';

  @override
  String get invalidPhone => 'मान्य फ़ोन नंबर दर्ज करें';

  @override
  String get passwordTooShort => 'पासवर्ड कम से कम 6 अक्षर का होना चाहिए';

  @override
  String get passwordsDoNotMatch => 'पासवर्ड मेल नहीं खाते';

  @override
  String get originSameAsDestination => 'उत्पत्ति और गंतव्य अलग होने चाहिए';

  @override
  String get camera => 'कैमरा';

  @override
  String get gallery => 'गैलरी';

  @override
  String get removePhoto => 'फ़ोटो हटाएँ';

  @override
  String get takePhoto => 'फ़ोटो लें';

  @override
  String get chooseFromGallery => 'गैलरी से चुनें';

  @override
  String get driverProfileUnavailable => 'ड्राइवर प्रोफ़ाइल उपलब्ध नहीं';
}
