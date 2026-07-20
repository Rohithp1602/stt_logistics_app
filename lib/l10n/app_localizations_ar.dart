// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'STT Logistics';

  @override
  String get appTagline => 'التحقق من السائق وإدارة الشحنات';

  @override
  String get splashTagline => 'اتصل بنا وسنتولى النقل!';

  @override
  String get onboardingTitle1Line1 => 'خدمات لوجستية ذكية.';

  @override
  String get onboardingTitle1Line2 => 'روابط أقوى.';

  @override
  String get onboardingSubtitle1 =>
      'التحقق من السائقين. إدارة الشحنات. تسليم الثقة.';

  @override
  String get onboardingTitle2Line1 => 'كل ما تحتاجه،';

  @override
  String get onboardingTitle2Line2 => 'في مكان واحد.';

  @override
  String get onboardingSubtitle2 =>
      'يساعدك تطبيق STT على التحقق من السائقين وتتبع الشحنات والبقاء مسيطرًا في أي وقت.';

  @override
  String get featureDriverTitle => 'التحقق من السائق';

  @override
  String get featureDriverBody => 'تحقق بسرعة من تفاصيل السائق وحالة STT.';

  @override
  String get featureShipmentTitle => 'إدارة الشحنات';

  @override
  String get featureShipmentBody =>
      'أنشئ وحدّث وتتبع وأدر جميع شحناتك في الوقت الفعلي.';

  @override
  String get featureRealtimeTitle => 'تحديثات فورية';

  @override
  String get featureRealtimeBody =>
      'ابقَ على اطلاع بالحالة المباشرة واتخذ قرارات أفضل.';

  @override
  String get getStarted => 'ابدأ';

  @override
  String get skip => 'تخطي';

  @override
  String get continueLabel => 'متابعة';

  @override
  String get chooseLanguage => 'اختر لغتك';

  @override
  String get chooseLanguageHint => 'يمكنك تغييرها لاحقًا من الإعدادات.';

  @override
  String get language => 'اللغة';

  @override
  String get settings => 'الإعدادات';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get pushNotifications => 'إشعارات الدفع';

  @override
  String get pushNotificationsHint => 'تلقي تحديثات حول شحناتك';

  @override
  String get legal => 'قانوني';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get termsOfUse => 'شروط الاستخدام';

  @override
  String get appVersion => 'إصدار التطبيق';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get confirmLogout => 'تأكيد تسجيل الخروج';

  @override
  String get confirmLogoutBody => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get home => 'الرئيسية';

  @override
  String get shipments => 'الشحنات';

  @override
  String get profile => 'الملف';

  @override
  String get fabTutorialTitle => 'إضافة شحنة';

  @override
  String get fabTutorialBody => 'اضغط زر + الأحمر لإنشاء شحنة جديدة.';

  @override
  String get fabTutorialGotIt => 'حسنًا';

  @override
  String get navDone => 'تم';

  @override
  String get welcomeBack => 'مرحبًا بعودتك';

  @override
  String get driverVerification => 'التحقق من السائق';

  @override
  String get tapCardForLicense => 'اضغط على البطاقة لتفاصيل الرخصة';

  @override
  String get completeProfileForLicense => 'أكمل الملف لعرض بطاقة الرخصة';

  @override
  String get shipmentOverview => 'نظرة عامة على الشحنات';

  @override
  String get tapToOpenShipments => 'اضغط لفتح الشحنات';

  @override
  String get total => 'الإجمالي';

  @override
  String get statusPending => 'قيد الانتظار';

  @override
  String get statusInTransit => 'قيد النقل';

  @override
  String get statusDelivered => 'تم التسليم';

  @override
  String get sttVerified => 'موثّق STT';

  @override
  String get verificationPending => 'قيد الانتظار';

  @override
  String get verificationRejected => 'مرفوض';

  @override
  String get addShipment => 'إضافة شحنة';

  @override
  String get editShipment => 'تعديل الشحنة';

  @override
  String get deleteShipment => 'حذف الشحنة';

  @override
  String get noShipments => 'لا توجد شحنات بعد';

  @override
  String get createFirstShipment => 'أنشئ أول شحنة للبدء';

  @override
  String get shipmentAdded => 'تمت إضافة الشحنة';

  @override
  String get shipmentDeleted => 'تم حذف الشحنة';

  @override
  String get shipmentUpdated => 'تم تحديث الشحنة';

  @override
  String deleteShipmentConfirm(String id) {
    return 'حذف الشحنة $id؟';
  }

  @override
  String get customerName => 'اسم العميل';

  @override
  String get origin => 'المصدر';

  @override
  String get destination => 'الوجهة';

  @override
  String get status => 'الحالة';

  @override
  String get updateShipment => 'تحديث الشحنة';

  @override
  String get saveShipment => 'حفظ الشحنة';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get emailHint => 'البريد الإلكتروني';

  @override
  String get passwordHint => 'كلمة المرور';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get loginSuccess => 'تم تسجيل الدخول';

  @override
  String get loginFailed => 'بريد أو كلمة مرور غير صحيحة';

  @override
  String get logoutSuccess => 'تم تسجيل الخروج';

  @override
  String get logoutFailed => 'فشل تسجيل الخروج';

  @override
  String get registerSuccess => 'تم التسجيل';

  @override
  String get registerFailed => 'فشل التسجيل';

  @override
  String get registerTitle => 'إنشاء حساب';

  @override
  String get registerButton => 'إنشاء حساب';

  @override
  String get fullNameHint => 'الاسم الكامل';

  @override
  String get phoneHint => 'رقم الهاتف';

  @override
  String get confirmPasswordHint => 'تأكيد كلمة المرور';

  @override
  String get cdlHint => 'رقم CDL';

  @override
  String get hubHint => 'المركز / المستودع';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get registerNow => 'سجّل الآن';

  @override
  String get alreadyHaveAccount => 'لديك حساب؟';

  @override
  String get signInLink => 'تسجيل الدخول';

  @override
  String get emailExists => 'يوجد حساب بهذا البريد';

  @override
  String get photoOptionalHint => 'صورة الملف (اختياري)';

  @override
  String get addPhotoHint => 'اضغط لإضافة صورة';

  @override
  String get changePhotoHint => 'اضغط لتغيير الصورة';

  @override
  String get profileUpdated => 'تم تحديث الملف';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get invalidEmail => 'أدخل بريدًا صالحًا';

  @override
  String get invalidPhone => 'أدخل رقم هاتف صالحًا';

  @override
  String get passwordTooShort => 'يجب أن تكون كلمة المرور 6 أحرف على الأقل';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get originSameAsDestination => 'يجب أن يختلف المصدر عن الوجهة';

  @override
  String get camera => 'الكاميرا';

  @override
  String get gallery => 'المعرض';

  @override
  String get removePhoto => 'إزالة الصورة';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get chooseFromGallery => 'اختيار من المعرض';

  @override
  String get driverProfileUnavailable => 'ملف السائق غير متاح';
}
