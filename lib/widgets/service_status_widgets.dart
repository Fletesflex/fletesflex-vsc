import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import '../utils/format.dart';
import 'app_card.dart';
import 'rating.dart';

/// A step in the 4-step service lifecycle shown on the "servicio-*" screens
/// (file neRKyJz313WM7CEdoZdgGl, nodes 2067:2, 2067:104, 2067:205).
enum ServiceStep { confirmado, enCamino, enCurso, finalizado }

enum _StepDotState { done, current, upcoming }

/// Row of 4 labeled dots connected by lines, showing progress through
/// [ServiceStep]. Steps before [current] render as filled accent circles
/// with a check; [current] renders as a ring; later steps are plain gray.
class ServiceStepsIndicator extends StatelessWidget {
  const ServiceStepsIndicator({super.key, required this.current});

  final ServiceStep current;

  static const _labels = ['Confirmado', 'En camino', 'En curso', 'Finalizado'];

  @override
  Widget build(BuildContext context) {
    final currentIndex = current.index;
    return Row(
      children: [
        for (final (i, label) in _labels.indexed)
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _Line(
                        i == 0 ? null : i - 1 < currentIndex,
                      ),
                    ),
                    _Dot(
                      i < currentIndex
                          ? _StepDotState.done
                          : i == currentIndex
                              ? _StepDotState.current
                              : _StepDotState.upcoming,
                    ),
                    Expanded(
                      child: _Line(i == 3 ? null : i < currentIndex),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  label,
                  style: i <= currentIndex
                      ? AppTypography.badgeLabel
                      : AppTypography.navLabel.copyWith(fontSize: 11),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/// A line segment between two dots. Null [filled] renders transparent (the
/// row's leading/trailing edge), otherwise accent when reached or gray.
class _Line extends StatelessWidget {
  const _Line(this.filled);

  final bool? filled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      color: filled == null
          ? Colors.transparent
          : (filled! ? AppColors.accent : AppColors.border),
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot(this.state);

  final _StepDotState state;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case _StepDotState.done:
        return Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.accent,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            'assets/icons/check_sm.svg',
            width: 14,
            height: 14,
          ),
        );
      case _StepDotState.current:
        return SvgPicture.asset(
          'assets/icons/radio_on.svg',
          width: 24,
          height: 24,
        );
      case _StepDotState.upcoming:
        return Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: AppColors.border,
            shape: BoxShape.circle,
          ),
        );
    }
  }
}

/// "card-estado": date/time + note, a status pill, and a [ServiceStepsIndicator],
/// shared by the three in-progress service screens.
class ServiceStatusCard extends StatelessWidget {
  const ServiceStatusCard({
    super.key,
    required this.dateLabel,
    required this.note,
    required this.statusLabel,
    required this.statusColor,
    required this.statusBackground,
    required this.current,
  });

  final String dateLabel;
  final String note;
  final String statusLabel;
  final Color statusColor;
  final Color statusBackground;
  final ServiceStep current;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      radius: AppRadius.xl,
      elevatedShadow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dateLabel, style: AppTypography.cardHeading),
                    const SizedBox(height: 2),
                    Text(
                      note,
                      style: AppTypography.itemSubtitle.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: AppSpacing.xxs,
                ),
                decoration: BoxDecoration(
                  color: statusBackground,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                ),
                child: Text(
                  statusLabel,
                  style: AppTypography.badgeLabel.copyWith(color: statusColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ServiceStepsIndicator(current: current),
        ],
      ),
    );
  }
}

/// "card-persona": avatar (photo or initial), caption, name, rating and an
/// optional detail line, plus a round chat button.
class PersonSummaryCard extends StatelessWidget {
  const PersonSummaryCard({
    super.key,
    required this.caption,
    required this.name,
    this.avatarAsset,
    this.initial,
    required this.rating,
    required this.ratingSuffix,
    this.detail,
    required this.onChat,
  });

  final String caption;
  final String name;

  /// A photo asset; when null, [initial] is shown on a soft-yellow circle.
  final String? avatarAsset;
  final String? initial;
  final double rating;
  final String ratingSuffix;

  /// E.g. the carrier's vehicle ("Fiat Fiorino · Carga liviana").
  final String? detail;
  final VoidCallback onChat;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 14,
      ),
      radius: AppRadius.xl,
      elevatedShadow: true,
      child: Row(
        children: [
          if (avatarAsset != null)
            AppAvatar(avatarAsset!, size: 52)
          else
            Container(
              width: 52,
              height: 52,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.iconSurface,
                shape: BoxShape.circle,
              ),
              child: Text(
                initial ?? '',
                style: AppTypography.headline.copyWith(fontSize: 20),
              ),
            ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  caption,
                  style: AppTypography.badgeLabel.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(name, style: AppTypography.userName),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/star_rating_14.svg',
                      width: 12,
                      height: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${rating.toStringAsFixed(1)} $ratingSuffix',
                      style: AppTypography.itemSubtitle.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                if (detail != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    detail!,
                    style: AppTypography.itemSubtitle.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          InkWell(
            onTap: onChat,
            customBorder: const CircleBorder(),
            child: Container(
              width: 44,
              height: 44,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/icons/message_circle.svg',
                width: 20,
                height: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// "card-ruta": origin ("RETIRO") and destination ("ENTREGA") stops with a
/// pin tile + address + detail, plus a service-type line below.
class RouteStopsCard extends StatelessWidget {
  const RouteStopsCard({
    super.key,
    required this.originAddress,
    required this.originDetail,
    required this.destinationAddress,
    required this.destinationDetail,
    required this.typeLabel,
  });

  final String originAddress;
  final String originDetail;
  final String destinationAddress;
  final String destinationDetail;
  final String typeLabel;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 14,
      ),
      radius: AppRadius.xl,
      elevatedShadow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Stop(
            pinColor: AppColors.iconSurface,
            iconAsset: 'assets/icons/map_pin.svg',
            label: 'RETIRO',
            address: originAddress,
            detail: originDetail,
          ),
          const SizedBox(height: 10),
          const AppDivider(thin: true),
          const SizedBox(height: 10),
          _Stop(
            pinColor: AppColors.textPrimary,
            iconAsset: 'assets/icons/map_pin_white.svg',
            label: 'ENTREGA',
            address: destinationAddress,
            detail: destinationDetail,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SvgPicture.asset('assets/icons/box.svg', width: 16, height: 16),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  typeLabel,
                  style: AppTypography.routeText.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stop extends StatelessWidget {
  const _Stop({
    required this.pinColor,
    required this.iconAsset,
    required this.label,
    required this.address,
    required this.detail,
  });

  final Color pinColor;
  final String iconAsset;
  final String label;
  final String address;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: pinColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(iconAsset, width: 18, height: 18),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.badgeLabel.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              Text(
                address,
                style: AppTypography.itemTitle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                detail,
                style: AppTypography.itemSubtitle.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// "card-monto": an uppercase caption + amount, with an optional status pill
/// (the requester's "Pagado"; the carrier's amount has none).
class AmountCard extends StatelessWidget {
  const AmountCard({
    super.key,
    required this.caption,
    required this.amount,
    this.pillLabel,
  });

  final String caption;
  final int amount;
  final String? pillLabel;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 14,
      ),
      radius: AppRadius.xl,
      elevatedShadow: true,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  caption,
                  style: AppTypography.badgeLabel.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  formatArs(amount),
                  style: AppTypography.cardHeading.copyWith(fontSize: 22),
                ),
              ],
            ),
          ),
          if (pillLabel != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: AppSpacing.xxs,
              ),
              decoration: BoxDecoration(
                color: AppColors.successSurface,
                borderRadius: BorderRadius.circular(AppRadius.chip),
              ),
              child: Text(
                pillLabel!,
                style: AppTypography.badgeLabel.copyWith(
                  color: AppColors.success,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Centered, non-underlined text action ("Cancelar servicio", "Volver").
class CenteredTextLink extends StatelessWidget {
  const CenteredTextLink({
    super.key,
    required this.label,
    required this.onTap,
    this.color = AppColors.textPrimary,
  });

  final String label;
  final VoidCallback onTap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.chip),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppSpacing.xxs,
            horizontal: AppSpacing.xs,
          ),
          child: Text(
            label,
            style: AppTypography.itemTitle.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

/// "card-aviso": warning banner shown on the cancel-service screens.
class CancelWarningBanner extends StatelessWidget {
  const CancelWarningBanner({super.key, required this.onViewPolicy});

  final VoidCallback onViewPolicy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: AppColors.iconSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icons/alert_triangle.svg',
            width: 22,
            height: 22,
            colorFilter: const ColorFilter.mode(
              AppColors.warning,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cancelar puede tener costos',
                  style: AppTypography.cardHeading.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  'Revisá la política de cancelaciones antes de confirmar.',
                  style: AppTypography.itemSubtitle.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 2),
                InkWell(
                  onTap: onViewPolicy,
                  child: Text(
                    'Ver política',
                    style: AppTypography.badgeLabel.copyWith(
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// "card-motivos": single-choice (radio) list of cancellation reasons.
class CancelReasonCard extends StatelessWidget {
  const CancelReasonCard({
    super.key,
    required this.reasons,
    required this.selected,
    required this.onChanged,
  });

  final List<String> reasons;
  final String? selected;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      radius: AppRadius.xl,
      elevatedShadow: true,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Column(
          children: [
            for (final (i, reason) in reasons.indexed) ...[
              if (i > 0) const AppDivider(thin: true),
              _ReasonTile(
                label: reason,
                selected: reason == selected,
                onTap: () => onChanged(reason),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ReasonTile extends StatelessWidget {
  const _ReasonTile({
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
      child: Container(
        color: selected ? AppColors.unreadSurface : AppColors.surface,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: 14,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              selected
                  ? 'assets/icons/radio_on.svg'
                  : 'assets/icons/radio_off.svg',
              width: 22,
              height: 22,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                label,
                style: selected
                    ? AppTypography.itemTitle.copyWith(
                        fontWeight: FontWeight.bold,
                      )
                    : AppTypography.checkLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
