import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../core/enums/shipment_status.dart';
import '../../../data/models/shipment_model.dart';
import '../../../l10n/l10n.dart';
import '../../../theme/app_decorations.dart';

/// List row for a shipment with status change and delete actions.
class ShipmentTile extends StatelessWidget {
  const ShipmentTile({
    super.key,
    required this.shipment,
    required this.onTap,
    required this.onDelete,
    required this.onStatusChanged,
  });

  final ShipmentModel shipment;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final ValueChanged<ShipmentStatus> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          decoration: AppDecorations.card,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        shipment.customerName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    IconButton(
                      tooltip: strings.delete,
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline),
                    ),
                  ],
                ),
                Text(
                  shipment.id,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  '${shipment.origin}  →  ${shipment.destination}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<ShipmentStatus>(
                  key: ValueKey('${shipment.id}-${shipment.status}'),
                  initialValue: shipment.status,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor:
                        _statusColor(shipment.status).withValues(alpha: 0.1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: ShipmentStatus.values
                      .map(
                        (status) => DropdownMenuItem(
                          value: status,
                          child: Text(status.localizedLabel(strings)),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) onStatusChanged(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _statusColor(ShipmentStatus status) {
    switch (status) {
      case ShipmentStatus.pending:
        return AppColors.pending;
      case ShipmentStatus.inTransit:
        return AppColors.info;
      case ShipmentStatus.delivered:
        return AppColors.success;
    }
  }
}
