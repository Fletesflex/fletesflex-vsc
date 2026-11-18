import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../utils/format.dart';
import '../widgets/widgets.dart';

/// A single row in the "MOVIMIENTOS" list.
class _Movimiento {
  const _Movimiento(this.route, this.date, this.amount, this.accredited);

  final String route;
  final String date;
  final int amount;
  final bool accredited;
}

const _movimientos = [
  _Movimiento('Palermo → Belgrano', 'Sáb 5 Oct', 145000, false),
  _Movimiento('Caballito → Villa Urquiza', 'Sáb 28 Sep', 98000, true),
  _Movimiento('Retiro → San Telmo', 'Dom 15 Sep', 32500, true),
];

/// Carrier earnings hub, implemented from the Figma "cobros-transportista"
/// design (file neRKyJz313WM7CEdoZdgGl, node 2069:2), reusing the tokens in
/// `lib/theme/`. Visual only — no backend wiring yet.
class MisCobrosScreen extends StatelessWidget {
  const MisCobrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        child: CircleIconButton(
          iconAsset: 'assets/icons/arrow_left_sm.svg',
          onTap: () => Navigator.of(context).maybePop(),
        ),
      ),
      children: [
        Text('Mis cobros', style: AppTypography.headline.copyWith(fontSize: 28)),
        const SizedBox(height: AppSpacing.sectionGap),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.sectionGap),
          decoration: BoxDecoration(
            color: AppColors.textPrimary,
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Disponible para cobrar',
                style: AppTypography.itemSubtitle.copyWith(
                  color: const Color(0xFFC9C9CF),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                formatArs(290000),
                style: AppTypography.display.copyWith(
                  fontSize: 38,
                  color: AppColors.surface,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/clock.svg',
                    width: 14,
                    height: 14,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFFC9C9CF),
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${formatArs(145000)} pendientes de acreditar',
                    style: AppTypography.itemSubtitle.copyWith(
                      color: const Color(0xFFC9C9CF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryButton(
                label: 'Transferir a mi cuenta',
                // TODO: transfer the available balance to the linked account.
                onPressed: () {},
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppCard(
          padding: EdgeInsets.zero,
          radius: AppRadius.xl,
          child: InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.datosCobro),
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: 14,
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.iconSurface,
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/credit_card.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cuenta de cobro',
                          style: AppTypography.badgeLabel.copyWith(
                            color: AppColors.textMuted,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'martin.rodriguez.mp',
                          style: AppTypography.cardTitle.copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Cambiar',
                    style: AppTypography.badgeLabel.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const ProfileSectionLabel('MOVIMIENTOS'),
        const SizedBox(height: AppSpacing.xs),
        AppCard(
          padding: EdgeInsets.zero,
          radius: AppRadius.xl,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: Column(
              children: [
                for (final (i, m) in _movimientos.indexed) ...[
                  if (i > 0) const AppDivider(thin: true),
                  _MovimientoRow(movimiento: m),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MovimientoRow extends StatelessWidget {
  const _MovimientoRow({required this.movimiento});

  final _Movimiento movimiento;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.successSurface,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: SvgPicture.asset(
              'assets/icons/arrow_down_left.svg',
              width: 20,
              height: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movimiento.route,
                  style: AppTypography.itemTitle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  movimiento.date,
                  style: AppTypography.itemSubtitle.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '+ ${formatArs(movimiento.amount)}',
                style: AppTypography.cardHeading.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: movimiento.accredited
                      ? AppColors.successSurface
                      : AppColors.iconSurface,
                  borderRadius: BorderRadius.circular(AppRadius.chip),
                ),
                child: Text(
                  movimiento.accredited ? 'Acreditado' : 'Pendiente',
                  style: AppTypography.badgeLabel.copyWith(
                    fontSize: 11,
                    color: movimiento.accredited
                        ? AppColors.success
                        : AppColors.verificationAmber,
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
