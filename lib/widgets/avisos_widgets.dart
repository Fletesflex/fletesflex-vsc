import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/notification.dart';
import '../theme/theme.dart';
import 'app_card.dart';

/// Single notification row: icon tile, title + unread dot, body and time.
/// Highlighted with [AppColors.unreadSurface] while [notification.unread].
class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notification});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: notification.unread ? AppColors.unreadSurface : AppColors.surface,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 14,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: notification.iconBackground,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: SvgPicture.asset(
              notification.iconAsset,
              width: 20,
              height: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        style: AppTypography.itemTitle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    if (notification.unread) ...[
                      const SizedBox(width: AppSpacing.xs),
                      SvgPicture.asset(
                        'assets/icons/notif_unread_dot.svg',
                        width: 8,
                        height: 8,
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(notification.body, style: AppTypography.cardCaption.copyWith(
                  color: AppColors.textSecondary,
                )),
                const SizedBox(height: 3),
                Text(notification.time, style: AppTypography.itemSubtitle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// White rounded card holding a day-grouped list of [NotificationCard]s
/// separated by thin dividers, clipped so unread rows' fill respects the
/// card's rounded corners.
class NotificationListCard extends StatelessWidget {
  const NotificationListCard({super.key, required this.items});

  final List<AppNotification> items;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      radius: AppRadius.xl,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Column(
          children: [
            for (final (i, item) in items.indexed) ...[
              if (i > 0) const AppDivider(thin: true),
              NotificationCard(notification: item),
            ],
          ],
        ),
      ),
    );
  }
}

/// "Todos" / "Sin leer" filter used on both Avisos screens: the selected
/// chip is solid dark, the other white with a hairline border.
enum NotificationFilter { all, unread }

class NotificationFilterBar extends StatelessWidget {
  const NotificationFilterBar({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final NotificationFilter selected;
  final ValueChanged<NotificationFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Chip(
          label: 'Todos',
          selected: selected == NotificationFilter.all,
          onTap: () => onChanged(NotificationFilter.all),
        ),
        const SizedBox(width: AppSpacing.xs),
        _Chip(
          label: 'Sin leer',
          selected: selected == NotificationFilter.unread,
          onTap: () => onChanged(NotificationFilter.unread),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.textPrimary : AppColors.surface,
          border: Border.all(
            color: selected ? AppColors.textPrimary : AppColors.border,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(AppRadius.pill),
        ),
        child: Text(
          label,
          style: AppTypography.chipSelected.copyWith(
            color: selected ? AppColors.surface : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

/// "Marcar todo como leído" header action.
class MarkAllReadButton extends StatelessWidget {
  const MarkAllReadButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/notif_check_check.svg',
            width: 16,
            height: 16,
          ),
          const SizedBox(width: 6),
          Text(
            'Marcar todo como leído',
            style: AppTypography.badgeLabel.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}

/// Empty state shown when there are no notifications at all: a layered
/// soft-yellow halo behind a dark rounded-square bell tile, implemented
/// from the Figma "avisos-vacio" design (file neRKyJz313WM7CEdoZdgGl,
/// node 2053:108).
class AvisosEmptyState extends StatelessWidget {
  const AvisosEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 132,
            height: 132,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.heroBlobYellow,
              shape: BoxShape.circle,
            ),
            child: Container(
              width: 88,
              height: 88,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.iconSurface,
                shape: BoxShape.circle,
              ),
              child: Container(
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.textPrimary,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: AppShadows.elevated,
                ),
                child: SvgPicture.asset(
                  'assets/icons/notif_bell_hero.svg',
                  width: 28,
                  height: 28,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Todavía no tenés avisos',
            style: AppTypography.pageTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Acá te contamos cuando te elijan para un trabajo, te escriban '
            'o haya novedades de tu cuenta.',
            style: AppTypography.subtitle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Uppercase day-group caption ("HOY", "AYER") above a [NotificationListCard].
class NotificationGroupLabel extends StatelessWidget {
  const NotificationGroupLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTypography.caps.copyWith(fontSize: 11, letterSpacing: 0.8),
    );
  }
}
