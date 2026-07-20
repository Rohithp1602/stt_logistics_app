// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appName => 'STT Logistics';

  @override
  String get appTagline => '운전자 인증 및 배송 관리';

  @override
  String get splashTagline => '전화 주시면 배송해 드립니다!';

  @override
  String get onboardingTitle1Line1 => '스마트 물류.';

  @override
  String get onboardingTitle1Line2 => '더 강한 연결.';

  @override
  String get onboardingSubtitle1 => '운전자 인증. 배송 관리. 신뢰 전달.';

  @override
  String get onboardingTitle2Line1 => '필요한 모든 것,';

  @override
  String get onboardingTitle2Line2 => '한곳에.';

  @override
  String get onboardingSubtitle2 => 'STT 앱으로 운전자 확인, 배송 추적, 언제든 관리하세요.';

  @override
  String get featureDriverTitle => '운전자 인증';

  @override
  String get featureDriverBody => '운전자 정보와 STT 상태를 빠르게 확인하세요.';

  @override
  String get featureShipmentTitle => '배송 관리';

  @override
  String get featureShipmentBody => '모든 배송을 실시간으로 생성·업데이트·추적하세요.';

  @override
  String get featureRealtimeTitle => '실시간 업데이트';

  @override
  String get featureRealtimeBody => '실시간 상태로 더 나은 결정을 내리세요.';

  @override
  String get getStarted => '시작하기';

  @override
  String get skip => '건너뛰기';

  @override
  String get continueLabel => '계속';

  @override
  String get chooseLanguage => '언어 선택';

  @override
  String get chooseLanguageHint => '나중에 설정에서 변경할 수 있습니다.';

  @override
  String get language => '언어';

  @override
  String get settings => '설정';

  @override
  String get notifications => '알림';

  @override
  String get pushNotifications => '푸시 알림';

  @override
  String get pushNotificationsHint => '배송 업데이트를 받아보세요';

  @override
  String get legal => '법적 고지';

  @override
  String get privacyPolicy => '개인정보 처리방침';

  @override
  String get termsOfUse => '이용약관';

  @override
  String get appVersion => '앱 버전';

  @override
  String get logout => '로그아웃';

  @override
  String get confirmLogout => '로그아웃 확인';

  @override
  String get confirmLogoutBody => '정말 로그아웃하시겠습니까?';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get home => '홈';

  @override
  String get shipments => '배송';

  @override
  String get profile => '프로필';

  @override
  String get fabTutorialTitle => '배송 추가';

  @override
  String get fabTutorialBody => '빨간 + 버튼을 눌러 새 배송을 만드세요.';

  @override
  String get fabTutorialGotIt => '확인';

  @override
  String get navDone => '완료';

  @override
  String get welcomeBack => '다시 오신 것을 환영합니다';

  @override
  String get driverVerification => '운전자 인증';

  @override
  String get tapCardForLicense => '카드를 눌러 면허 상세 보기';

  @override
  String get completeProfileForLicense => '면허 카드를 보려면 프로필을 완성하세요';

  @override
  String get shipmentOverview => '배송 개요';

  @override
  String get tapToOpenShipments => '눌러서 배송 열기';

  @override
  String get total => '합계';

  @override
  String get statusPending => '대기';

  @override
  String get statusInTransit => '운송 중';

  @override
  String get statusDelivered => '배송 완료';

  @override
  String get sttVerified => 'STT 인증됨';

  @override
  String get verificationPending => '대기';

  @override
  String get verificationRejected => '거절됨';

  @override
  String get addShipment => '배송 추가';

  @override
  String get editShipment => '배송 수정';

  @override
  String get deleteShipment => '배송 삭제';

  @override
  String get noShipments => '아직 배송이 없습니다';

  @override
  String get createFirstShipment => '첫 배송을 만들어 시작하세요';

  @override
  String get shipmentAdded => '배송이 추가되었습니다';

  @override
  String get shipmentDeleted => '배송이 삭제되었습니다';

  @override
  String get shipmentUpdated => '배송이 업데이트되었습니다';

  @override
  String deleteShipmentConfirm(String id) {
    return '배송 $id을(를) 삭제할까요?';
  }

  @override
  String get customerName => '고객명';

  @override
  String get origin => '출발지';

  @override
  String get destination => '도착지';

  @override
  String get status => '상태';

  @override
  String get updateShipment => '배송 업데이트';

  @override
  String get saveShipment => '배송 저장';

  @override
  String get loginTitle => '로그인';

  @override
  String get emailHint => '이메일';

  @override
  String get passwordHint => '비밀번호';

  @override
  String get loginButton => '로그인';

  @override
  String get loginSuccess => '로그인 성공';

  @override
  String get loginFailed => '잘못된 이메일 또는 비밀번호';

  @override
  String get logoutSuccess => '로그아웃되었습니다';

  @override
  String get logoutFailed => '로그아웃 실패';

  @override
  String get registerSuccess => '가입 성공';

  @override
  String get registerFailed => '가입 실패';

  @override
  String get registerTitle => '계정 만들기';

  @override
  String get registerButton => '계정 만들기';

  @override
  String get fullNameHint => '이름';

  @override
  String get phoneHint => '전화번호';

  @override
  String get confirmPasswordHint => '비밀번호 확인';

  @override
  String get cdlHint => 'CDL 번호';

  @override
  String get hubHint => '허브 / 차고';

  @override
  String get dontHaveAccount => '계정이 없으신가요?';

  @override
  String get registerNow => '지금 가입';

  @override
  String get alreadyHaveAccount => '이미 계정이 있으신가요?';

  @override
  String get signInLink => '로그인';

  @override
  String get emailExists => '이 이메일의 계정이 이미 있습니다';

  @override
  String get photoOptionalHint => '프로필 사진(선택)';

  @override
  String get addPhotoHint => '탭하여 사진 추가';

  @override
  String get changePhotoHint => '탭하여 사진 변경';

  @override
  String get profileUpdated => '프로필이 업데이트되었습니다';

  @override
  String get fieldRequired => '필수 항목입니다';

  @override
  String get invalidEmail => '유효한 이메일을 입력하세요';

  @override
  String get invalidPhone => '유효한 전화번호를 입력하세요';

  @override
  String get passwordTooShort => '비밀번호는 6자 이상이어야 합니다';

  @override
  String get passwordsDoNotMatch => '비밀번호가 일치하지 않습니다';

  @override
  String get originSameAsDestination => '출발지와 도착지는 달라야 합니다';

  @override
  String get camera => '카메라';

  @override
  String get gallery => '갤러리';

  @override
  String get removePhoto => '사진 삭제';

  @override
  String get takePhoto => '사진 찍기';

  @override
  String get chooseFromGallery => '갤러리에서 선택';

  @override
  String get driverProfileUnavailable => '운전자 프로필을 사용할 수 없습니다';
}
