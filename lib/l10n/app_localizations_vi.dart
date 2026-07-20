// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appName => 'STT Logistics';

  @override
  String get appTagline => 'Xác minh tài xế & quản lý lô hàng';

  @override
  String get splashTagline => 'Bạn gọi, chúng tôi vận chuyển!';

  @override
  String get onboardingTitle1Line1 => 'Logistics thông minh.';

  @override
  String get onboardingTitle1Line2 => 'Kết nối vững chắc.';

  @override
  String get onboardingSubtitle1 =>
      'Xác minh tài xế. Quản lý lô hàng. Mang lại niềm tin.';

  @override
  String get onboardingTitle2Line1 => 'Mọi thứ bạn cần,';

  @override
  String get onboardingTitle2Line2 => 'trong một nơi.';

  @override
  String get onboardingSubtitle2 =>
      'Ứng dụng STT giúp xác minh tài xế, theo dõi lô hàng và kiểm soát mọi lúc.';

  @override
  String get featureDriverTitle => 'Xác minh tài xế';

  @override
  String get featureDriverBody =>
      'Nhanh chóng kiểm tra thông tin tài xế và trạng thái STT.';

  @override
  String get featureShipmentTitle => 'Quản lý lô hàng';

  @override
  String get featureShipmentBody =>
      'Tạo, cập nhật, theo dõi và quản lý tất cả lô hàng theo thời gian thực.';

  @override
  String get featureRealtimeTitle => 'Cập nhật thời gian thực';

  @override
  String get featureRealtimeBody =>
      'Luôn cập nhật trạng thái trực tiếp và đưa ra quyết định tốt hơn.';

  @override
  String get getStarted => 'Bắt đầu';

  @override
  String get skip => 'Bỏ qua';

  @override
  String get continueLabel => 'Tiếp tục';

  @override
  String get chooseLanguage => 'Chọn ngôn ngữ';

  @override
  String get chooseLanguageHint => 'Bạn có thể đổi sau trong Cài đặt.';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get settings => 'Cài đặt';

  @override
  String get notifications => 'Thông báo';

  @override
  String get pushNotifications => 'Thông báo đẩy';

  @override
  String get pushNotificationsHint => 'Nhận cập nhật về lô hàng của bạn';

  @override
  String get legal => 'Pháp lý';

  @override
  String get privacyPolicy => 'Chính sách bảo mật';

  @override
  String get termsOfUse => 'Điều khoản sử dụng';

  @override
  String get appVersion => 'Phiên bản ứng dụng';

  @override
  String get logout => 'Đăng xuất';

  @override
  String get confirmLogout => 'Xác nhận đăng xuất';

  @override
  String get confirmLogoutBody => 'Bạn có chắc muốn đăng xuất?';

  @override
  String get cancel => 'Hủy';

  @override
  String get delete => 'Xóa';

  @override
  String get home => 'Trang chủ';

  @override
  String get shipments => 'Lô hàng';

  @override
  String get profile => 'Hồ sơ';

  @override
  String get fabTutorialTitle => 'Thêm lô hàng';

  @override
  String get fabTutorialBody => 'Chạm nút + đỏ để tạo lô hàng mới.';

  @override
  String get fabTutorialGotIt => 'Đã hiểu';

  @override
  String get navDone => 'Xong';

  @override
  String get welcomeBack => 'Chào mừng trở lại';

  @override
  String get driverVerification => 'Xác minh tài xế';

  @override
  String get tapCardForLicense => 'Chạm thẻ để xem chi tiết bằng lái';

  @override
  String get completeProfileForLicense => 'Hoàn tất hồ sơ để xem thẻ bằng lái';

  @override
  String get shipmentOverview => 'Tổng quan lô hàng';

  @override
  String get tapToOpenShipments => 'Chạm để mở lô hàng';

  @override
  String get total => 'Tổng';

  @override
  String get statusPending => 'Đang chờ';

  @override
  String get statusInTransit => 'Đang vận chuyển';

  @override
  String get statusDelivered => 'Đã giao';

  @override
  String get sttVerified => 'Đã xác minh STT';

  @override
  String get verificationPending => 'Đang chờ';

  @override
  String get verificationRejected => 'Từ chối';

  @override
  String get addShipment => 'Thêm lô hàng';

  @override
  String get editShipment => 'Sửa lô hàng';

  @override
  String get deleteShipment => 'Xóa lô hàng';

  @override
  String get noShipments => 'Chưa có lô hàng';

  @override
  String get createFirstShipment => 'Tạo lô hàng đầu tiên để bắt đầu';

  @override
  String get shipmentAdded => 'Đã thêm lô hàng';

  @override
  String get shipmentDeleted => 'Đã xóa lô hàng';

  @override
  String get shipmentUpdated => 'Đã cập nhật lô hàng';

  @override
  String deleteShipmentConfirm(String id) {
    return 'Xóa lô hàng $id?';
  }

  @override
  String get customerName => 'Tên khách hàng';

  @override
  String get origin => 'Điểm đi';

  @override
  String get destination => 'Điểm đến';

  @override
  String get status => 'Trạng thái';

  @override
  String get updateShipment => 'Cập nhật lô hàng';

  @override
  String get saveShipment => 'Lưu lô hàng';

  @override
  String get loginTitle => 'Đăng nhập';

  @override
  String get emailHint => 'Email';

  @override
  String get passwordHint => 'Mật khẩu';

  @override
  String get loginButton => 'Đăng nhập';

  @override
  String get loginSuccess => 'Đăng nhập thành công';

  @override
  String get loginFailed => 'Email hoặc mật khẩu không hợp lệ';

  @override
  String get logoutSuccess => 'Đã đăng xuất';

  @override
  String get logoutFailed => 'Đăng xuất thất bại';

  @override
  String get registerSuccess => 'Đăng ký thành công';

  @override
  String get registerFailed => 'Đăng ký thất bại';

  @override
  String get registerTitle => 'Tạo tài khoản';

  @override
  String get registerButton => 'Tạo tài khoản';

  @override
  String get fullNameHint => 'Họ và tên';

  @override
  String get phoneHint => 'Số điện thoại';

  @override
  String get confirmPasswordHint => 'Xác nhận mật khẩu';

  @override
  String get cdlHint => 'Số CDL';

  @override
  String get hubHint => 'Hub / kho';

  @override
  String get dontHaveAccount => 'Chưa có tài khoản?';

  @override
  String get registerNow => 'Đăng ký ngay';

  @override
  String get alreadyHaveAccount => 'Đã có tài khoản?';

  @override
  String get signInLink => 'Đăng nhập';

  @override
  String get emailExists => 'Email này đã có tài khoản';

  @override
  String get photoOptionalHint => 'Ảnh hồ sơ (tuỳ chọn)';

  @override
  String get addPhotoHint => 'Chạm để thêm ảnh';

  @override
  String get changePhotoHint => 'Chạm để đổi ảnh';

  @override
  String get profileUpdated => 'Đã cập nhật hồ sơ';

  @override
  String get fieldRequired => 'Trường này là bắt buộc';

  @override
  String get invalidEmail => 'Nhập email hợp lệ';

  @override
  String get invalidPhone => 'Nhập số điện thoại hợp lệ';

  @override
  String get passwordTooShort => 'Mật khẩu phải có ít nhất 6 ký tự';

  @override
  String get passwordsDoNotMatch => 'Mật khẩu không khớp';

  @override
  String get originSameAsDestination => 'Điểm đi và điểm đến phải khác nhau';

  @override
  String get camera => 'Máy ảnh';

  @override
  String get gallery => 'Thư viện';

  @override
  String get removePhoto => 'Xóa ảnh';

  @override
  String get takePhoto => 'Chụp ảnh';

  @override
  String get chooseFromGallery => 'Chọn từ thư viện';

  @override
  String get driverProfileUnavailable => 'Không có hồ sơ tài xế';
}
