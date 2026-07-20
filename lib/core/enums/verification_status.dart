import '../../l10n/app_localizations.dart';

/// Lifecycle states for a driver's STT verification badge.
enum VerificationStatus {
  verified,
  pending,
  rejected,
}

extension VerificationStatusX on VerificationStatus {
  /// Localized label for UI display.
  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case VerificationStatus.verified:
        return l10n.sttVerified;
      case VerificationStatus.pending:
        return l10n.verificationPending;
      case VerificationStatus.rejected:
        return l10n.verificationRejected;
    }
  }

  /// English fallback for non-UI / legacy callers.
  String get label {
    switch (this) {
      case VerificationStatus.verified:
        return 'STT Verified';
      case VerificationStatus.pending:
        return 'Pending';
      case VerificationStatus.rejected:
        return 'Rejected';
    }
  }
}
