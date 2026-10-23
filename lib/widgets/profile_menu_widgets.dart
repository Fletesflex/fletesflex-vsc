import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import 'app_card.dart';

/// Which side of the app "Mi perfil" is currently showing, for accounts
/// with both roles active.
enum ProfileMode { solicitante, transportista }

/// "Solicitante | Transportista" segmented control shown on "Mi perfil"
/// when the account has both roles active, implemented from the Figma
/// "card-modo" design (file neRKyJz313WM7CEdoZdgGl, nodes 2057:289,
/// 2057:585). Switches immediately on tap, with no confirmation step:
/// solicitante goes to the requester Home, transportista goes to the
/// carrier Solicitudes list.
class ProfileModeSelector extends StatelessWidget {
  const ProfileModeSelector({super.key, required this.current});

  final ProfileMode current;

  void _switchTo(BuildContext context, ProfileMode mode) {
    if (mode == current) return;
    final route = mode == ProfileMode.solicitante
        ? AppRoutes.home
        : AppRoutes.transportistaSolicitudes;
    Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.segmentedTrack,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: _Segment(
              label: 'Solicitante',
              selected: current == ProfileMode.solicitante,
              onTap: () => _switchTo(context, ProfileMode.solicitante),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _Segment(
              label: 'Transportista',
              selected: current == ProfileMode.transportista,
              onTap: () => _switchTo(context, ProfileMode.transportista),
            ),
          ),
        ],
      ),
    );
  }
}

class _Segment extends StatelessWidget {
  const _Segment({
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
      borderRadius: BorderRadius.circular(11),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 11),
        decoration: BoxDecoration(
          color: selected ? AppColors.textPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(11),
        ),
        child: Text(
          label,
          style: AppTypography.toggleLabel.copyWith(
            fontWeight: selected ? FontWeight.bold : FontWeight.w500,
            color: selected ? AppColors.surface : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}

/// Avatar initial, name, role (+ optional verified chip), an edit button,
/// and a "servicios / calificación" stat row, implemented from the Figma
/// "profile-card" design shared by all "Mi perfil" states.
class ProfileHeroCard extends StatelessWidget {
  const ProfileHeroCard({
    super.key,
    required this.initial,
    required this.name,
    required this.roleLabel,
    required this.servicesCount,
    required this.rating,
    this.verified = false,
    this.onEditTap,
  });

  final String initial;
  final String name;
  final String roleLabel;
  final int servicesCount;
  final double rating;

  /// Shows the green "Identidad verificada" chip (carrier only).
  final bool verified;
  final VoidCallback? onEditTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      radius: AppRadius.xl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.iconSurface,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.accent, width: 2),
                ),
                child: Text(
                  initial,
                  style: AppTypography.headline.copyWith(fontSize: 26),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: AppTypography.cardTitle.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      roleLabel,
                      style: AppTypography.subtitle.copyWith(fontSize: 13),
                    ),
                    if (verified) ...[
                      const SizedBox(height: 4),
                      const _VerifiedChip(),
                    ],
                  ],
                ),
              ),
              _EditButton(onTap: onEditTap),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const AppDivider(thin: true),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _Stat(value: '$servicesCount', label: 'servicios'),
              ),
              Container(width: 1, height: 36, color: AppColors.border),
              Expanded(
                child: _Stat(
                  value: rating.toStringAsFixed(1),
                  label: 'calificación',
                  iconAsset: 'assets/icons/star_accent.svg',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.value, required this.label, this.iconAsset});

  final String value;
  final String label;
  final String? iconAsset;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: AppTypography.sectionTitle.copyWith(fontSize: 20),
            ),
            if (iconAsset != null) ...[
              const SizedBox(width: 4),
              SvgPicture.asset(iconAsset!, width: 14, height: 14),
            ],
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: AppTypography.itemSubtitle.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _VerifiedChip extends StatelessWidget {
  const _VerifiedChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 3, 10, 3),
      decoration: BoxDecoration(
        color: AppColors.successSurface,
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/shield_check.svg',
            width: 13,
            height: 13,
            colorFilter: const ColorFilter.mode(
              AppColors.success,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            'Identidad verificada',
            style: AppTypography.badgeLabel.copyWith(
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({required this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border, width: 1.5),
        ),
        child: SvgPicture.asset('assets/icons/pencil.svg', width: 16, height: 16),
      ),
    );
  }
}

/// The card shown above "CUENTA" on the requester's own profile: either an
/// accent-bordered upsell to become a carrier, or — once verification has
/// been submitted — a neutral status card with an "En revisión" pill.
/// Implemented from the Figma "card-sumate-transportista" designs (file
/// neRKyJz313WM7CEdoZdgGl, nodes 2055:58, 2057:334).
class CarrierUpsellCard extends StatelessWidget {
  const CarrierUpsellCard({super.key, required this.onTap}) : pending = false;

  const CarrierUpsellCard.pending({super.key}) : onTap = null, pending = true;

  final VoidCallback? onTap;
  final bool pending;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(
          color: pending ? AppColors.border : AppColors.accent,
          width: pending ? 1.5 : 2,
        ),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        boxShadow: AppShadows.soft,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.iconSurface,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: SvgPicture.asset(
              'assets/icons/truck.svg',
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pending
                      ? 'Verificación en revisión'
                      : 'Sumate como transportista',
                  style: AppTypography.cardTitle.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 2),
                Text(
                  pending
                      ? 'Te avisamos apenas puedas ofertar como '
                            'transportista.'
                      : 'Ofertá en pedidos de tu zona con tu vehículo.',
                  style: AppTypography.cardDescription.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          if (pending)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.iconSurface,
                borderRadius: BorderRadius.circular(AppRadius.chip),
              ),
              child: Text(
                'En revisión',
                style: AppTypography.badgeLabel.copyWith(
                  color: AppColors.verificationAmber,
                ),
              ),
            )
          else
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.accent,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/icons/arrow_right.svg',
                width: 16,
                height: 16,
              ),
            ),
        ],
      ),
    );

    if (onTap == null) return content;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: content,
    );
  }
}

/// Uppercase section caption above a [ProfileMenuCard] ("CUENTA", "AYUDA").
class ProfileSectionLabel extends StatelessWidget {
  const ProfileSectionLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppTypography.caps.copyWith(fontSize: 11, letterSpacing: 0.8),
    );
  }
}

/// White rounded card holding a vertical list of [ProfileMenuRow]s
/// separated by hairline dividers (the "CUENTA" / "AYUDA" sections).
class ProfileMenuCard extends StatelessWidget {
  const ProfileMenuCard({super.key, required this.rows});

  final List<ProfileMenuRow> rows;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.zero,
      radius: AppRadius.xl,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.xl),
        child: Column(
          children: [
            for (final (i, row) in rows.indexed) ...[
              if (i > 0) const AppDivider(thin: true),
              row,
            ],
          ],
        ),
      ),
    );
  }
}

/// A single tappable row inside a [ProfileMenuCard]: icon tile, label, an
/// optional trailing badge, and a chevron.
class ProfileMenuRow extends StatelessWidget {
  const ProfileMenuRow({
    super.key,
    required this.iconAsset,
    required this.label,
    this.badge,
    this.onTap,
  });

  final String iconAsset;
  final String label;

  /// Small amber count badge before the chevron (e.g. "2 de 4").
  final String? badge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.iconSurface,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(iconAsset, width: 18, height: 18),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                label,
                style: AppTypography.itemTitle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (badge != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.iconSurface,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                ),
                child: Text(
                  badge!,
                  style: AppTypography.badgeLabel.copyWith(
                    color: AppColors.verificationAmber,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
            ],
            SvgPicture.asset(
              'assets/icons/chevron_right.svg',
              width: 18,
              height: 18,
            ),
          ],
        ),
      ),
    );
  }
}

/// Centered "Cerrar sesión" action in red, used at the bottom of both "Mi
/// perfil" screens.
class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/log_out.svg',
              width: 18,
              height: 18,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'Cerrar sesión',
              style: AppTypography.itemTitle.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.danger,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
