import 'dart:io';

import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../core/enums/verification_status.dart';
import '../../../data/models/driver_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../../l10n/l10n.dart';

/// Commercial driver license–style verification card.
class DriverVerificationCard extends StatelessWidget {
  const DriverVerificationCard({
    super.key,
    required this.driver,
    this.onTap,
    this.compact = false,
  });

  final DriverModel driver;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final card = AspectRatio(
      aspectRatio: compact ? 1.72 : 1.58,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(painter: _MapWatermarkPainter()),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      compact ? 10 : 12,
                      compact ? 8 : 10,
                      compact ? 10 : 12,
                      compact ? 8 : 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _LicenseHeader(compact: compact),
                        SizedBox(height: compact ? 6 : 8),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              _PhotoColumn(driver: driver, compact: compact),
                              SizedBox(width: compact ? 10 : 12),
                              Expanded(
                                child: _IdentityColumn(
                                  driver: driver,
                                  compact: compact,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return card;
  }
}

class _LicenseHeader extends StatelessWidget {
  const _LicenseHeader({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '★  DRIVER LICENSE  ★',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: compact ? 9 : 10,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: compact ? 2 : 4),
        Text(
          'STT LOGISTICS',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: compact ? 15 : 18,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
            color: AppColors.primary,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 4),
          height: 2,
          color: AppColors.primary,
        ),
      ],
    );
  }
}

class _PhotoColumn extends StatelessWidget {
  const _PhotoColumn({required this.driver, required this.compact});

  final DriverModel driver;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final photoSize = compact ? 72.0 : 88.0;
    final path = driver.photoPath;
    final hasFile = path != null && path.isNotEmpty && File(path).existsSync();

    return SizedBox(
      width: photoSize,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: photoSize * 1.15,
            decoration: BoxDecoration(
              color: const Color(0xFFE8EEF8),
              border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
            ),
            clipBehavior: Clip.antiAlias,
            child: hasFile
                ? Image.file(File(path), fit: BoxFit.cover)
                : Icon(
                    Icons.person,
                    size: photoSize * 0.55,
                    color: AppColors.primary.withValues(alpha: 0.45),
                  ),
          ),
          const Spacer(),
          Text(
            driver.name.split(' ').first,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'cursive',
              fontSize: compact ? 13 : 15,
              fontStyle: FontStyle.italic,
              color: AppColors.textPrimary,
            ),
          ),
          Container(height: 1, color: AppColors.textPrimary.withValues(alpha: 0.35)),
          const SizedBox(height: 4),
          Text(
            'Validation',
            style: TextStyle(
              fontSize: compact ? 7 : 8,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            _validationId(driver),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: compact ? 9 : 10,
              fontWeight: FontWeight.w800,
              color: AppColors.accent,
            ),
          ),
        ],
      ),
    );
  }

  String _validationId(DriverModel driver) {
    final raw = driver.userId.isNotEmpty ? driver.userId : driver.cdlNumber;
    if (raw.isEmpty) return 'STT-PENDING';
    final short = raw.length > 8 ? raw.substring(0, 8).toUpperCase() : raw.toUpperCase();
    return 'DS-$short';
  }
}

class _IdentityColumn extends StatelessWidget {
  const _IdentityColumn({required this.driver, required this.compact});

  final DriverModel driver;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final statusColor = switch (driver.status) {
      VerificationStatus.verified => AppColors.verified,
      VerificationStatus.pending => AppColors.pending,
      VerificationStatus.rejected => AppColors.rejected,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          driver.name.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: compact ? 13 : 15,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          driver.hub.isNotEmpty ? driver.hub : 'Hub not set',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: compact ? 9 : 10,
            height: 1.25,
            color: AppColors.textPrimary.withValues(alpha: 0.75),
          ),
        ),
        SizedBox(height: compact ? 6 : 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'License No.',
                    style: TextStyle(
                      fontSize: compact ? 8 : 9,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                  Text(
                    driver.cdlNumber.isNotEmpty ? driver.cdlNumber : '—',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: compact ? 14 : 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'CLASS CDL',
              style: TextStyle(
                fontSize: compact ? 11 : 12,
                fontWeight: FontWeight.w800,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: compact ? 6 : 8),
        Row(
          children: [
            Expanded(
              child: _LabeledValue(
                label: 'Phone',
                value: driver.phone.isNotEmpty ? driver.phone : '—',
                compact: compact,
              ),
            ),
            Expanded(
              child: _LabeledValue(
                label: strings.status,
                value: _statusShort(driver.status, strings),
                compact: compact,
                valueColor: statusColor,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 8 : 10,
            vertical: compact ? 5 : 6,
          ),
          decoration: BoxDecoration(
            color: statusColor.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: statusColor.withValues(alpha: 0.35)),
          ),
          child: Row(
            children: [
              Icon(
                switch (driver.status) {
                  VerificationStatus.verified => Icons.verified,
                  VerificationStatus.pending => Icons.hourglass_top_rounded,
                  VerificationStatus.rejected => Icons.cancel_outlined,
                },
                size: compact ? 14 : 16,
                color: statusColor,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  _statusBanner(driver.status, strings),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: compact ? 10 : 11,
                    fontWeight: FontWeight.w800,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _statusShort(VerificationStatus status, AppLocalizations strings) =>
      status.localizedLabel(strings).toUpperCase();

  String _statusBanner(VerificationStatus status, AppLocalizations strings) =>
      status.localizedLabel(strings).toUpperCase();
}

class _LabeledValue extends StatelessWidget {
  const _LabeledValue({
    required this.label,
    required this.value,
    required this.compact,
    this.valueColor,
  });

  final String label;
  final String value;
  final bool compact;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: compact ? 8 : 9,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: compact ? 10 : 11,
            fontWeight: FontWeight.w700,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _MapWatermarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.primary.withValues(alpha: 0.04)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final cx = size.width * 0.72;
    final cy = size.height * 0.55;
    for (var i = 1; i <= 4; i++) {
      canvas.drawCircle(Offset(cx, cy), 18.0 * i, paint);
    }
    canvas.drawLine(
      Offset(cx - 70, cy),
      Offset(cx + 70, cy),
      paint,
    );
    canvas.drawLine(
      Offset(cx, cy - 70),
      Offset(cx, cy + 70),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class DriverLicenseBackCard extends StatelessWidget {
  const DriverLicenseBackCard({super.key, required this.driver});

  final DriverModel driver;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.58,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(height: 28, color: AppColors.textPrimary),
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(painter: _MapWatermarkPainter()),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Endorsements',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                              const Text(
                                'NONE',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Restrictions',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                              const Text(
                                'NONE',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Spacer(),
                              const Text(
                                'CALL CENTER',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                ),
                              ),
                              Text(
                                driver.phone.isNotEmpty ? driver.phone : '—',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.accent,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'sttlogisticsgroup.com',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Vertical barcode-style strip
                        SizedBox(
                          width: 42,
                          child: Column(
                            children: List.generate(
                              18,
                              (i) => Expanded(
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 1),
                                  color: i.isEven
                                      ? AppColors.textPrimary
                                      : AppColors.textPrimary
                                          .withValues(alpha: 0.15),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
