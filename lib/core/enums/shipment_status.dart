import '../../l10n/app_localizations.dart';

/// Lifecycle states for a shipment in the logistics workflow.
enum ShipmentStatus {
  pending,
  inTransit,
  delivered,
}

extension ShipmentStatusX on ShipmentStatus {
  /// Localized label for UI display.
  String localizedLabel(AppLocalizations l10n) {
    switch (this) {
      case ShipmentStatus.pending:
        return l10n.statusPending;
      case ShipmentStatus.inTransit:
        return l10n.statusInTransit;
      case ShipmentStatus.delivered:
        return l10n.statusDelivered;
    }
  }

  /// English fallback for non-UI / legacy callers.
  String get label {
    switch (this) {
      case ShipmentStatus.pending:
        return 'Pending';
      case ShipmentStatus.inTransit:
        return 'In Transit';
      case ShipmentStatus.delivered:
        return 'Delivered';
    }
  }

  /// Stable string used when persisting / serializing.
  String get storageValue {
    switch (this) {
      case ShipmentStatus.pending:
        return 'pending';
      case ShipmentStatus.inTransit:
        return 'in_transit';
      case ShipmentStatus.delivered:
        return 'delivered';
    }
  }

  /// Parses a stored string back into [ShipmentStatus].
  static ShipmentStatus fromStorage(String value) {
    switch (value) {
      case 'in_transit':
        return ShipmentStatus.inTransit;
      case 'delivered':
        return ShipmentStatus.delivered;
      case 'pending':
      default:
        return ShipmentStatus.pending;
    }
  }
}
