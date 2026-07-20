/// User-facing copy used across the app.
class AppStrings {
  AppStrings._();

  static const String appName = 'STT Logistics';
  static const String appTagline = 'Driver verification & shipment management';
  static const String splashTagline = "You Call, We Haul. That's All!";

  // Auth
  static const String loginTitle = 'Sign in';
  static const String emailHint = 'Email address';
  static const String passwordHint = 'Password';
  static const String loginButton = 'Sign in';
  static const String loginSuccess = 'Login successful';
  static const String loginFailed = 'Invalid email or password';
  static const String logoutSuccess = 'Logged out successfully';
  static const String logoutFailed = 'Logout failed';
  static const String registerSuccess = 'Registration successful';
  static const String registerFailed = 'Registration failed';
  static const String registerTitle = 'Create account';
  static const String registerButton = 'Create account';
  static const String fullNameHint = 'Full name';
  static const String phoneHint = 'Phone number';
  static const String confirmPasswordHint = 'Confirm password';
  static const String cdlHint = 'CDL number';
  static const String hubHint = 'Hub / depot';
  static const String dontHaveAccount = "Don't have an account?";
  static const String registerNow = 'Register now';
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String signInLink = 'Sign in';
  static const String emailExists = 'An account with this email already exists';
  static const String photoOptionalHint = 'Profile photo (optional)';
  static const String addPhotoHint = 'Tap to add a photo';
  static const String changePhotoHint = 'Tap to change photo';
  static const String profileUpdated = 'Profile updated successfully';

  // Validation
  static const String fieldRequired = 'This field is required';
  static const String invalidEmail = 'Enter a valid email address';
  static const String invalidPhone = 'Enter a valid phone number';
  static const String passwordTooShort = 'Password must be at least 6 characters';
  static const String passwordsDoNotMatch = 'Passwords do not match';
  static const String originSameAsDestination =
      'Origin and destination must be different';

  // Driver
  static const String driverVerification = 'Driver Verification';
  static const String sttVerified = 'STT Verified';
  static const String verificationPending = 'Pending';
  static const String verificationRejected = 'Rejected';

  // Shipments
  static const String shipments = 'Shipments';
  static const String addShipment = 'Add Shipment';
  static const String editShipment = 'Edit Shipment';
  static const String deleteShipment = 'Delete Shipment';
  static const String noShipments = 'No shipments yet';
  static const String shipmentSaved = 'Shipment saved';
  static const String shipmentAdded = 'Shipment added successfully';
  static const String shipmentDeleted = 'Shipment deleted';
  static const String shipmentUpdated = 'Shipment updated';
}
