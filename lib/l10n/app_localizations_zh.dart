// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'STT Logistics';

  @override
  String get appTagline => '司机验证与货运管理';

  @override
  String get splashTagline => '您来电，我们承运。就是这样！';

  @override
  String get onboardingTitle1Line1 => 'Smart Logistics.';

  @override
  String get onboardingTitle1Line2 => 'Stronger Connections.';

  @override
  String get onboardingSubtitle1 =>
      'Verifying Drivers. Managing Shipments. Delivering Trust.';

  @override
  String get onboardingTitle2Line1 => 'Everything You Need,';

  @override
  String get onboardingTitle2Line2 => 'All in One Place.';

  @override
  String get onboardingSubtitle2 =>
      'STT App helps you verify drivers, track shipments, and stay in control anytime, anywhere.';

  @override
  String get featureDriverTitle => 'Driver Verification';

  @override
  String get featureDriverBody =>
      'Quickly verify driver details, and check STT verification status with ease.';

  @override
  String get featureShipmentTitle => 'Shipment Management';

  @override
  String get featureShipmentBody =>
      'Create, update, track, and manage all your shipments in real time.';

  @override
  String get featureRealtimeTitle => 'Real-Time Updates';

  @override
  String get featureRealtimeBody =>
      'Stay updated with live status and make smarter logistics decisions.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get skip => 'Skip';

  @override
  String get continueLabel => 'Continue';

  @override
  String get chooseLanguage => 'Choose your language';

  @override
  String get chooseLanguageHint => 'You can change this later in Settings.';

  @override
  String get language => '语言';

  @override
  String get settings => '设置';

  @override
  String get notifications => 'Notifications';

  @override
  String get pushNotifications => 'Push Notifications';

  @override
  String get pushNotificationsHint => 'Receive updates about your shipments';

  @override
  String get legal => 'Legal';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfUse => 'Terms of Use';

  @override
  String get appVersion => 'App version';

  @override
  String get logout => '退出登录';

  @override
  String get confirmLogout => 'Confirm Logout';

  @override
  String get confirmLogoutBody => 'Are you sure you want to logout?';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get home => '首页';

  @override
  String get shipments => '货运';

  @override
  String get profile => '个人资料';

  @override
  String get fabTutorialTitle => 'Add a shipment';

  @override
  String get fabTutorialBody =>
      'Tap the red + button anytime to create a new shipment.';

  @override
  String get fabTutorialGotIt => 'Got it';

  @override
  String get navDone => 'Done';

  @override
  String get welcomeBack => '欢迎回来';

  @override
  String get driverVerification => '司机验证';

  @override
  String get tapCardForLicense => '点击卡片查看驾照详情';

  @override
  String get completeProfileForLicense => '完善资料以查看驾照卡';

  @override
  String get shipmentOverview => '货运概览';

  @override
  String get tapToOpenShipments => '点击打开货运';

  @override
  String get total => '总计';

  @override
  String get statusPending => '待处理';

  @override
  String get statusInTransit => '运输中';

  @override
  String get statusDelivered => '已送达';

  @override
  String get sttVerified => 'STT已验证';

  @override
  String get verificationPending => '待处理';

  @override
  String get verificationRejected => '已拒绝';

  @override
  String get addShipment => '添加货运';

  @override
  String get editShipment => '编辑货运';

  @override
  String get deleteShipment => '删除货运';

  @override
  String get noShipments => '暂无货运';

  @override
  String get createFirstShipment => '创建您的第一笔货运开始使用';

  @override
  String get shipmentAdded => '货运添加成功';

  @override
  String get shipmentDeleted => '货运已删除';

  @override
  String get shipmentUpdated => '货运已更新';

  @override
  String deleteShipmentConfirm(String id) {
    return '删除货运 $id？';
  }

  @override
  String get customerName => '客户名称';

  @override
  String get origin => '起点';

  @override
  String get destination => '终点';

  @override
  String get status => '状态';

  @override
  String get updateShipment => '更新货运';

  @override
  String get saveShipment => '保存货运';

  @override
  String get loginTitle => '登录';

  @override
  String get emailHint => '电子邮箱';

  @override
  String get passwordHint => '密码';

  @override
  String get loginButton => '登录';

  @override
  String get loginSuccess => '登录成功';

  @override
  String get loginFailed => '邮箱或密码无效';

  @override
  String get logoutSuccess => '已成功退出';

  @override
  String get logoutFailed => '退出失败';

  @override
  String get registerSuccess => '注册成功';

  @override
  String get registerFailed => '注册失败';

  @override
  String get registerTitle => '创建账户';

  @override
  String get registerButton => '创建账户';

  @override
  String get fullNameHint => '全名';

  @override
  String get phoneHint => '电话号码';

  @override
  String get confirmPasswordHint => '确认密码';

  @override
  String get cdlHint => 'CDL编号';

  @override
  String get hubHint => '枢纽 / 车场';

  @override
  String get dontHaveAccount => '还没有账户？';

  @override
  String get registerNow => '立即注册';

  @override
  String get alreadyHaveAccount => '已有账户？';

  @override
  String get signInLink => '登录';

  @override
  String get emailExists => '该邮箱账户已存在';

  @override
  String get photoOptionalHint => '头像（可选）';

  @override
  String get addPhotoHint => '点击添加照片';

  @override
  String get changePhotoHint => '点击更换照片';

  @override
  String get profileUpdated => '资料更新成功';

  @override
  String get fieldRequired => '此字段为必填项';

  @override
  String get invalidEmail => '请输入有效邮箱';

  @override
  String get invalidPhone => '请输入有效电话';

  @override
  String get passwordTooShort => '密码至少6个字符';

  @override
  String get passwordsDoNotMatch => '两次密码不一致';

  @override
  String get originSameAsDestination => '起点和终点必须不同';

  @override
  String get camera => '相机';

  @override
  String get gallery => '相册';

  @override
  String get removePhoto => '删除照片';

  @override
  String get takePhoto => '拍照';

  @override
  String get chooseFromGallery => '从相册选择';

  @override
  String get driverProfileUnavailable => '司机资料不可用';
}
