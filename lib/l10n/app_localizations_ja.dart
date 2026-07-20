// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'STT Logistics';

  @override
  String get appTagline => 'ドライバー認証と配送管理';

  @override
  String get splashTagline => 'お電話いただければ、お届けします。';

  @override
  String get onboardingTitle1Line1 => 'スマートな物流。';

  @override
  String get onboardingTitle1Line2 => 'より強いつながり。';

  @override
  String get onboardingSubtitle1 => 'ドライバー認証。配送管理。信頼の配達。';

  @override
  String get onboardingTitle2Line1 => '必要なものがすべて、';

  @override
  String get onboardingTitle2Line2 => 'ひとつの場所に。';

  @override
  String get onboardingSubtitle2 => 'STTアプリでドライバー確認、配送追跡、いつでも管理できます。';

  @override
  String get featureDriverTitle => 'ドライバー認証';

  @override
  String get featureDriverBody => 'ドライバー情報とSTTステータスをすばやく確認。';

  @override
  String get featureShipmentTitle => '配送管理';

  @override
  String get featureShipmentBody => '配送の作成・更新・追跡をリアルタイムで。';

  @override
  String get featureRealtimeTitle => 'リアルタイム更新';

  @override
  String get featureRealtimeBody => 'ライブ状況を把握し、より良い判断を。';

  @override
  String get getStarted => 'はじめる';

  @override
  String get skip => 'スキップ';

  @override
  String get continueLabel => '続ける';

  @override
  String get chooseLanguage => '言語を選択';

  @override
  String get chooseLanguageHint => '後から設定で変更できます。';

  @override
  String get language => '言語';

  @override
  String get settings => '設定';

  @override
  String get notifications => '通知';

  @override
  String get pushNotifications => 'プッシュ通知';

  @override
  String get pushNotificationsHint => '配送に関する更新を受け取る';

  @override
  String get legal => '法的情報';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get termsOfUse => '利用規約';

  @override
  String get appVersion => 'アプリバージョン';

  @override
  String get logout => 'ログアウト';

  @override
  String get confirmLogout => 'ログアウトの確認';

  @override
  String get confirmLogoutBody => '本当にログアウトしますか？';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get home => 'ホーム';

  @override
  String get shipments => '配送';

  @override
  String get profile => 'プロフィール';

  @override
  String get fabTutorialTitle => '配送を追加';

  @override
  String get fabTutorialBody => '赤い＋ボタンをタップして新しい配送を作成できます。';

  @override
  String get fabTutorialGotIt => '了解';

  @override
  String get navDone => '完了';

  @override
  String get welcomeBack => 'おかえりなさい';

  @override
  String get driverVerification => 'ドライバー認証';

  @override
  String get tapCardForLicense => 'カードをタップして免許の詳細を表示';

  @override
  String get completeProfileForLicense => '免許カードを表示するにはプロフィールを完成させてください';

  @override
  String get shipmentOverview => '配送概要';

  @override
  String get tapToOpenShipments => 'タップして配送を開く';

  @override
  String get total => '合計';

  @override
  String get statusPending => '保留';

  @override
  String get statusInTransit => '輸送中';

  @override
  String get statusDelivered => '配達済み';

  @override
  String get sttVerified => 'STT認証済み';

  @override
  String get verificationPending => '保留';

  @override
  String get verificationRejected => '拒否';

  @override
  String get addShipment => '配送を追加';

  @override
  String get editShipment => '配送を編集';

  @override
  String get deleteShipment => '配送を削除';

  @override
  String get noShipments => '配送はまだありません';

  @override
  String get createFirstShipment => '最初の配送を作成して始めましょう';

  @override
  String get shipmentAdded => '配送を追加しました';

  @override
  String get shipmentDeleted => '配送を削除しました';

  @override
  String get shipmentUpdated => '配送を更新しました';

  @override
  String deleteShipmentConfirm(String id) {
    return '配送 $id を削除しますか？';
  }

  @override
  String get customerName => '顧客名';

  @override
  String get origin => '出発地';

  @override
  String get destination => '目的地';

  @override
  String get status => 'ステータス';

  @override
  String get updateShipment => '配送を更新';

  @override
  String get saveShipment => '配送を保存';

  @override
  String get loginTitle => 'サインイン';

  @override
  String get emailHint => 'メールアドレス';

  @override
  String get passwordHint => 'パスワード';

  @override
  String get loginButton => 'サインイン';

  @override
  String get loginSuccess => 'ログイン成功';

  @override
  String get loginFailed => 'メールまたはパスワードが無効です';

  @override
  String get logoutSuccess => 'ログアウトしました';

  @override
  String get logoutFailed => 'ログアウトに失敗しました';

  @override
  String get registerSuccess => '登録成功';

  @override
  String get registerFailed => '登録に失敗しました';

  @override
  String get registerTitle => 'アカウント作成';

  @override
  String get registerButton => 'アカウント作成';

  @override
  String get fullNameHint => '氏名';

  @override
  String get phoneHint => '電話番号';

  @override
  String get confirmPasswordHint => 'パスワード確認';

  @override
  String get cdlHint => 'CDL番号';

  @override
  String get hubHint => 'ハブ / デポ';

  @override
  String get dontHaveAccount => 'アカウントをお持ちでないですか？';

  @override
  String get registerNow => '今すぐ登録';

  @override
  String get alreadyHaveAccount => 'すでにアカウントをお持ちですか？';

  @override
  String get signInLink => 'サインイン';

  @override
  String get emailExists => 'このメールのアカウントは既に存在します';

  @override
  String get photoOptionalHint => 'プロフィール写真（任意）';

  @override
  String get addPhotoHint => 'タップして写真を追加';

  @override
  String get changePhotoHint => 'タップして写真を変更';

  @override
  String get profileUpdated => 'プロフィールを更新しました';

  @override
  String get fieldRequired => 'この項目は必須です';

  @override
  String get invalidEmail => '有効なメールアドレスを入力してください';

  @override
  String get invalidPhone => '有効な電話番号を入力してください';

  @override
  String get passwordTooShort => 'パスワードは6文字以上必要です';

  @override
  String get passwordsDoNotMatch => 'パスワードが一致しません';

  @override
  String get originSameAsDestination => '出発地と目的地は異なる必要があります';

  @override
  String get camera => 'カメラ';

  @override
  String get gallery => 'ギャラリー';

  @override
  String get removePhoto => '写真を削除';

  @override
  String get takePhoto => '写真を撮る';

  @override
  String get chooseFromGallery => 'ギャラリーから選択';

  @override
  String get driverProfileUnavailable => 'ドライバープロフィールを利用できません';
}
