import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../l10n/l10n.dart';
import '../../../theme/app_decorations.dart';

/// Shipment overview: chart and status counts.
class ShipmentOverviewCard extends StatelessWidget {
  const ShipmentOverviewCard({
    super.key,
    required this.total,
    required this.pending,
    required this.inTransit,
    required this.delivered,
    required this.onTap,
  });

  final int total;
  final int pending;
  final int inTransit;
  final int delivered;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final segments = <_ChartSegment>[
      _ChartSegment(
        label: strings.statusPending,
        count: pending,
        color: AppColors.pending,
        icon: Icons.schedule_rounded,
      ),
      _ChartSegment(
        label: strings.statusInTransit,
        count: inTransit,
        color: AppColors.info,
        icon: Icons.local_shipping_rounded,
      ),
      _ChartSegment(
        label: strings.statusDelivered,
        count: delivered,
        color: AppColors.success,
        icon: Icons.check_circle_rounded,
      ),
    ];

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: AppDecorations.card.copyWith(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.analytics_rounded,
                        color: AppColors.primary,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            strings.shipmentOverview,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            strings.tapToOpenShipments,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.textSecondary.withValues(alpha: 0.8),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      width: 132,
                      height: 132,
                      child: CustomPaint(
                        painter: _DonutChartPainter(
                          segments: segments,
                          total: total,
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '$total',
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                strings.total,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary
                                      .withValues(alpha: 0.95),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        children: [
                          for (var i = 0; i < segments.length; i++) ...[
                            if (i > 0) const SizedBox(height: 10),
                            _LegendRow(
                              segment: segments[i],
                              total: total,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    height: 10,
                    child: total == 0
                        ? ColoredBox(
                            color: AppColors.border.withValues(alpha: 0.7),
                          )
                        : Row(
                            children: [
                              for (final s in segments)
                                if (s.count > 0)
                                  Expanded(
                                    flex: s.count,
                                    child: ColoredBox(color: s.color),
                                  ),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChartSegment {
  const _ChartSegment({
    required this.label,
    required this.count,
    required this.color,
    required this.icon,
  });

  final String label;
  final int count;
  final Color color;
  final IconData icon;
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({required this.segment, required this.total});

  final _ChartSegment segment;
  final int total;

  @override
  Widget build(BuildContext context) {
    final pct = total == 0 ? 0 : ((segment.count / total) * 100).round();
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: segment.color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(segment.icon, size: 18, color: segment.color),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                segment.label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '$pct%',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        Text(
          '${segment.count}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: segment.color,
          ),
        ),
      ],
    );
  }
}

class _DonutChartPainter extends CustomPainter {
  _DonutChartPainter({required this.segments, required this.total});

  final List<_ChartSegment> segments;
  final int total;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;
    final stroke = radius * 0.28;
    final rect = Rect.fromCircle(center: center, radius: radius - stroke / 2);

    final track = Paint()
      ..color = AppColors.border.withValues(alpha: 0.65)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(rect, 0, math.pi * 2, false, track);

    if (total <= 0) return;

    var start = -math.pi / 2;
    for (final segment in segments) {
      if (segment.count <= 0) continue;
      final sweep = (segment.count / total) * math.pi * 2;
      final paint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(rect, start, sweep, false, paint);
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutChartPainter oldDelegate) {
    return oldDelegate.total != total ||
        oldDelegate.segments.length != segments.length ||
        !_sameCounts(oldDelegate.segments, segments);
  }

  bool _sameCounts(List<_ChartSegment> a, List<_ChartSegment> b) {
    for (var i = 0; i < a.length; i++) {
      if (a[i].count != b[i].count || a[i].color != b[i].color) return false;
    }
    return true;
  }
}
