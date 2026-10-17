import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import '../utils/format.dart';
import '../widgets/widgets.dart';

/// Step 3 of the "Mensajería" request form (confirmation), implemented from
/// the Figma "mensajeria-confirmacion" design (file neRKyJz313WM7CEdoZdgGl,
/// node 44:5), reusing the tokens in `lib/theme/`.
class MensajeriaConfirmacionScreen extends StatelessWidget {
  const MensajeriaConfirmacionScreen({super.key});

  void _handleConfirm(BuildContext context) {
    // TODO: submit the mensajería request before navigating.
  }

  void _handleEdit(BuildContext context) {
    // TODO: return to a specific step to edit the request data.
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Confirmar envío',
      topBarStyle: TopBarStyle.centered,
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xs,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      children: [
        const StepIndicator(
          current: 2,
          total: 3,
          style: StepIndicatorStyle.bars,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text('Paso 3: Confirmación', style: AppTypography.textAction),
        const SizedBox(height: AppSpacing.sectionGap),
        const _RouteCard(),
        const SizedBox(height: AppSpacing.md),
        const _DetailsCard(),
        const SizedBox(height: AppSpacing.md),
        const _PriceCard(),
        const SizedBox(height: AppSpacing.sectionGap),
        PillButton(
          label: 'Confirmar y publicar envío',
          onPressed: () => _handleConfirm(context),
        ),
        const SizedBox(height: AppSpacing.sm),
        Center(
          child: TextLinkButton(
            label: 'Editar datos',
            color: AppColors.textPrimary,
            onPressed: () => _handleEdit(context),
          ),
        ),
      ],
    );
  }
}

/// "Recorrido del envío" card: pickup, delivery and estimated distance, each
/// as an icon + muted caption + value row, separated by hairlines.
class _RouteCard extends StatelessWidget {
  const _RouteCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderWidth: 0,
      borderColor: Colors.transparent,
      radius: AppRadius.xl,
      elevatedShadow: true,
      padding: const EdgeInsets.all(AppSpacing.sectionGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recorrido del envío', style: AppTypography.cardHeading),
          const SizedBox(height: AppSpacing.sectionGap),
          const _InfoRow(
            iconAsset: 'assets/icons/map_pin.svg',
            label: 'Retiro',
            value: 'Av. Córdoba 1234, CABA',
          ),
          const SizedBox(height: AppSpacing.sm),
          const SizedBox(width: double.infinity, child: AppDivider()),
          const SizedBox(height: AppSpacing.sm),
          const _InfoRow(
            iconAsset: 'assets/icons/flag_triangle_right.svg',
            label: 'Entrega',
            value: 'Av. Libertador 5678, Vicente López',
          ),
          const SizedBox(height: AppSpacing.sm),
          const SizedBox(width: double.infinity, child: AppDivider()),
          const SizedBox(height: AppSpacing.sm),
          const _InfoRow(
            iconAsset: 'assets/icons/route.svg',
            label: 'Distancia estimada',
            value: '4,2 km',
            valueBold: true,
          ),
        ],
      ),
    );
  }
}

/// 18px icon + muted caption + value, shared by [_RouteCard] and
/// [_DetailsCard].
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.iconAsset,
    required this.label,
    required this.value,
    this.valueBold = false,
  });

  final String iconAsset;
  final String label;
  final String value;
  final bool valueBold;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(iconAsset, width: 18, height: 18),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTypography.itemSubtitle),
              const SizedBox(height: 2),
              Text(
                value,
                style: valueBold
                    ? AppTypography.addressValue.copyWith(
                        fontWeight: FontWeight.bold,
                      )
                    : AppTypography.addressValue,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// "Detalle del envío" card: package type/weight and pickup time window.
class _DetailsCard extends StatelessWidget {
  const _DetailsCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderWidth: 0,
      borderColor: Colors.transparent,
      radius: AppRadius.xl,
      elevatedShadow: true,
      padding: const EdgeInsets.all(AppSpacing.sectionGap),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Detalle del envío', style: AppTypography.cardHeading),
          const SizedBox(height: AppSpacing.sectionGap),
          const _PackageTypeRow(),
          const SizedBox(height: AppSpacing.sm),
          const SizedBox(width: double.infinity, child: AppDivider()),
          const SizedBox(height: AppSpacing.sm),
          const _InfoRow(
            iconAsset: 'assets/icons/clock.svg',
            label: 'Horario de retiro',
            value: 'Lo antes posible',
            valueBold: true,
          ),
        ],
      ),
    );
  }
}

/// Icon + "Caja chica (~5 kg)" baseline-aligned row.
class _PackageTypeRow extends StatelessWidget {
  const _PackageTypeRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset('assets/icons/box.svg', width: 18, height: 18),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'Caja chica',
                style: AppTypography.addressValue.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: AppSpacing.xxs),
              Text('(~5 kg)', style: AppTypography.caption),
            ],
          ),
        ),
      ],
    );
  }
}

/// Soft-yellow "Tarifa del envío" breakdown: base fare, distance fare and
/// the estimated total.
class _PriceCard extends StatelessWidget {
  const _PriceCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sectionGap),
      decoration: BoxDecoration(
        color: AppColors.iconSurface,
        border: Border.all(color: AppColors.accent, width: 1.5),
        borderRadius: BorderRadius.circular(AppRadius.xl),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tarifa del envío', style: AppTypography.cardHeading),
          const SizedBox(height: AppSpacing.sectionGap),
          const _PriceLineRow(label: 'Tarifa base', amount: 2500),
          const SizedBox(height: AppSpacing.sm),
          const _PriceLineRow(label: 'Distancia', amount: 3360),
          const SizedBox(height: AppSpacing.sm),
          Opacity(
            opacity: 0.3,
            child: const SizedBox(width: double.infinity, child: AppDivider(thin: true)),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total estimado', style: AppTypography.vehicleTitle),
              Text(formatArs(5860), style: AppTypography.priceHero),
            ],
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            'Precio final — sin cargos ocultos',
            style: AppTypography.itemSubtitle,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// One "label … $amount" row inside [_PriceCard].
class _PriceLineRow extends StatelessWidget {
  const _PriceLineRow({required this.label, required this.amount});

  final String label;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTypography.fieldValue),
        Text(formatArs(amount), style: AppTypography.priceCurrency),
      ],
    );
  }
}
