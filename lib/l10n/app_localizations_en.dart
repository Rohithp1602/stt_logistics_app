// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'STT Logistics';

  @override
  String get appTagline => 'Driver verification & shipment management';

  @override
  String get splashTagline => 'You Call, We Haul. That\'s All!';

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
  String get language => 'Language';

  @override
  String get settings => 'Settings';

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
  String get logout => 'Logout';

  @override
  String get confirmLogout => 'Confirm Logout';

  @override
  String get confirmLogoutBody => 'Are you sure you want to logout?';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get home => 'Home';

  @override
  String get shipments => 'Shipments';

  @override
  String get profile => 'Profile';

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
  String get welcomeBack => 'Welcome back';

  @override
  String get driverVerification => 'Driver Verification';

  @override
  String get tapCardForLicense => 'Tap card for full license details';

  @override
  String get completeProfileForLicense =>
      'Complete profile to view license card';

  @override
  String get shipmentOverview => 'Shipment overview';

  @override
  String get tapToOpenShipments => 'Tap to open shipments';

  @override
  String get total => 'Total';

  @override
  String get statusPending => 'Pending';

  @override
  String get statusInTransit => 'In Transit';

  @override
  String get statusDelivered => 'Delivered';

  @override
  String get sttVerified => 'STT Verified';

  @override
  String get verificationPending => 'Pending';

  @override
  String get verificationRejected => 'Rejected';

  @override
  String get addShipment => 'Add Shipment';

  @override
  String get editShipment => 'Edit Shipment';

  @override
  String get deleteShipment => 'Delete Shipment';

  @override
  String get noShipments => 'No shipments yet';

  @override
  String get createFirstShipment => 'Create your first shipment to get started';

  @override
  String get shipmentAdded => 'Shipment added successfully';

  @override
  String get shipmentDeleted => 'Shipment deleted';

  @override
  String get shipmentUpdated => 'Shipment updated';

  @override
  String deleteShipmentConfirm(String id) {
    return 'Delete shipment $id?';
  }

  @override
  String get customerName => 'Customer Name';

  @override
  String get origin => 'Origin';

  @override
  String get destination => 'Destination';

  @override
  String get status => 'Status';

  @override
  String get updateShipment => 'Update Shipment';

  @override
  String get saveShipment => 'Save Shipment';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get emailHint => 'Email address';

  @override
  String get passwordHint => 'Password';

  @override
  String get loginButton => 'Sign in';

  @override
  String get loginSuccess => 'Login successful';

  @override
  String get loginFailed => 'Invalid email or password';

  @override
  String get logoutSuccess => 'Logged out successfully';

  @override
  String get logoutFailed => 'Logout failed';

  @override
  String get registerSuccess => 'Registration successful';

  @override
  String get registerFailed => 'Registration failed';

  @override
  String get registerTitle => 'Create account';

  @override
  String get registerButton => 'Create account';

  @override
  String get fullNameHint => 'Full name';

  @override
  String get phoneHint => 'Phone number';

  @override
  String get confirmPasswordHint => 'Confirm password';

  @override
  String get cdlHint => 'CDL number';

  @override
  String get hubHint => 'Hub / depot';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get registerNow => 'Register now';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get signInLink => 'Sign in';

  @override
  String get emailExists => 'An account with this email already exists';

  @override
  String get photoOptionalHint => 'Profile photo (optional)';

  @override
  String get addPhotoHint => 'Tap to add a photo';

  @override
  String get changePhotoHint => 'Tap to change photo';

  @override
  String get profileUpdated => 'Profile updated successfully';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get invalidEmail => 'Enter a valid email address';

  @override
  String get invalidPhone => 'Enter a valid phone number';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get originSameAsDestination =>
      'Origin and destination must be different';

  @override
  String get camera => 'Camera';

  @override
  String get gallery => 'Gallery';

  @override
  String get removePhoto => 'Remove Photo';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get driverProfileUnavailable => 'Driver profile unavailable';
}
