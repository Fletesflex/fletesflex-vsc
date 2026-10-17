import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/request.dart';
import '../models/service_type.dart';
import '../theme/theme.dart';
import '../utils/format.dart';
import 'app_card.dart';
import 'offer_card.dart';

/// Uppercase category label ("MUDANZA") tinted per [ServiceType].
class ServiceBadge extends StatelessWidget {
  const ServiceBadge(this.type, {super.key, this.pill = false});

  final ServiceType type;

  /// Fully rounded variant (detail header) instead of the 8px-radius tag.
  final bool pill;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: pill ? AppSpacing.sm : 10,
        vertical: pill ? 6 : AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: type.badgeColor,
        borderRadius: BorderRadius.circular(
          pill ? AppRadius.pill : AppRadius.chip,
        ),
      ),
      child: Text(
        type.label.toUpperCase(),
        style: AppTypography.badgeLabel.copyWith(
          color: type.badgeTextColor,
          fontWeight: pill ? FontWeight.bold : FontWeight.w800,
          fontSize: pill ? 12 : 11,
        ),
      ),
    );
  }
}

/// Marketplace card for a carrier: category, route, date/distance,
/// requirement tags, reference price and "Ver y ofertar".
class RequestCard extends StatelessWidget {
  const RequestCard({super.key, required this.request, this.onOpen});

  final TransportRequest request;
  final VoidCallback? onOpen;

  static const _routeIcons = {
    ServiceType.mudanza: 'assets/icons/house_sm.svg',
    ServiceType.flete: 'assets/icons/package_accent.svg',
    ServiceType.mensajeria: 'assets/icons/bike.svg',
  };

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      radius: AppRadius.xl,
      onTap: onOpen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ServiceBadge(request.type),
              Text(
                request.postedAgo,
                style: AppTypography.itemSubtitle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              SvgPicture.asset(
                _routeIcons[request.type]!,
                width: 16,
                height: 16,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  request.route,
                  style: AppTypography.routeTitle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              _Meta('assets/icons/calendar_xs_2.svg', request.when),
              const SizedBox(width: AppSpacing.md),
              _Meta('assets/icons/navigation.svg', request.distance),
            ],
          ),
          if (request.requirements.isNotEmpty) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final (icon, label) in request.requirements)
                  RequirementTag(iconAsset: icon, label: label),
              ],
            ),
          ],
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('REFERENCIA CLIENTE', style: AppTypography.micro),
                    const SizedBox(height: 1),
                    Text(
                      formatArs(request.referencePrice),
                      style: AppTypography.priceSmall,
                    ),
                  ],
                ),
                CompactButton(label: 'Ver y ofertar', onPressed: onOpen),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Meta extends StatelessWidget {
  const _Meta(this.iconAsset, this.text);

  final String iconAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(iconAsset, width: 14, height: 14),
        const SizedBox(width: AppSpacing.xxs),
        Text(text, style: AppTypography.routeText),
      ],
    );
  }
}

/// Gray tag with a small icon ("Ayudantes (2)", "Ascensor: Sí").
class RequirementTag extends StatelessWidget {
  const RequirementTag({
    super.key,
    required this.iconAsset,
    required this.label,
    this.color = AppColors.border,
    this.textColor = AppColors.textSecondary,
    this.iconSize = 14,
  });

  final String iconAsset;
  final String label;
  final Color color;
  final Color textColor;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: iconSize < 14 ? AppSpacing.xs : 10,
        vertical: iconSize < 14 ? 3 : AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          iconSize < 14 ? 6 : AppRadius.chip,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(iconAsset, width: iconSize, height: iconSize),
          SizedBox(width: iconSize < 14 ? 4 : 6),
          Text(
            label,
            style: AppTypography.micro.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// Compact request card: category badge + reference, route with truck icon,
/// schedule, optional one-line detail and optional [footer].
class RequestSummaryCard extends StatelessWidget {
  const RequestSummaryCard({
    super.key,
    required this.type,
    required this.reference,
    required this.route,
    required this.schedule,
    this.detail,
    this.footer,
  });

  final ServiceType type;
  final String reference;
  final String route;
  final String schedule;
  final String? detail;

  /// Shown below a thin divider (e.g. "Tu presupuesto $55.000").
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.all(footer == null ? AppSpacing.md : AppSpacing.sectionGap),
      radius: footer == null ? AppRadius.xl : AppRadius.lg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ServiceBadge(type),
              Text(
                'Ref: $reference',
                style: AppTypography.itemSubtitle.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/truck_md.svg',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(child: Text(route, style: AppTypography.routeTitle)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/calendar_xs.svg',
                width: 14,
                height: 14,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(child: Text(schedule, style: AppTypography.routeText)),
            ],
          ),
          if (detail != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                const SizedBox(
                  width: 14,
                  child: Center(
                    child: SizedBox(
                      width: 6,
                      height: 6,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.textPrimary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(detail!, style: AppTypography.routeText),
                ),
              ],
            ),
          ],
          if (footer != null) ...[
            const SizedBox(height: 14),
            const AppDivider(thin: true),
            const SizedBox(height: 14),
            footer!,
          ],
        ],
      ),
    );
  }
}
