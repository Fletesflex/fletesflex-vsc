import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/offer.dart';
import '../routes.dart';
import '../theme/theme.dart';
import '../utils/format.dart';
import '../widgets/widgets.dart';

/// Discount applied when paying by bank transfer.
const transferDiscount = 0.10;

/// Price after the bank-transfer discount, rounded to whole pesos.
int transferPrice(int price) => (price * (1 - transferDiscount)).round();

/// Payment summary + method choice, implemented from the Figma
/// "resumen-pago-transferencia" design (file o7nkeARTqRUSPsNBaYg2nb,
/// node 32:5). Receives the chosen [Offer] as the route argument.
class ResumenPagoScreen extends StatelessWidget {
  const ResumenPagoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offer = ModalRoute.of(context)?.settings.arguments as Offer? ??
        SampleOffers.andres;
    final discounted = transferPrice(offer.price);

    return AppPage(
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xs,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PillButton(
            onPressed: () => Navigator.of(context).pushNamed(
              AppRoutes.cargaPago,
              arguments: offer,
            ),
            leading: SvgPicture.asset(
              'assets/icons/handshake_sm.svg',
              width: 18,
              height: 18,
            ),
            label: 'Pagar con Mercado Pago · ${formatArs(offer.price)}',
          ),
          const SizedBox(height: AppSpacing.sm),
          PillButton(
            outlined: true,
            onPressed: () => Navigator.of(context).pushNamed(
              AppRoutes.pagoTransferencia,
              arguments: offer,
            ),
            leading: const DiscountPill(solid: true),
            label: 'Pagar por transferencia · ${formatArs(discounted)}',
          ),
          const SizedBox(height: 14),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(
              AppRoutes.comprobantePago,
              arguments: offer,
            ),
            child: Text(
              'Ver comprobante',
              style: AppTypography.linkSmall,
            ),
          ),
        ],
      ),
      children: [
        Text(
          'Resumen de pago',
          style: AppTypography.display.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppSpacing.sm),
        AppCard(
          radius: AppRadius.xl,
          borderWidth: 0,
          borderColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Detalles del flete', style: AppTypography.userName),
              const SizedBox(height: 14),
              const AppDivider(thin: true),
              const SizedBox(height: 14),
              // TODO: fill from the confirmed request.
              const _SummaryRow(
                iconAsset: 'assets/icons/package_sm.svg',
                label: 'Servicio',
                child: Text('Mudanza chica'),
              ),
              const SizedBox(height: 14),
              _SummaryRow(
                iconAsset: 'assets/icons/user_sm.svg',
                label: 'Transportista asignado',
                child: Row(
                  children: [
                    AppAvatar(offer.carrier.avatarAsset, size: 24),
                    const SizedBox(width: AppSpacing.xs),
                    Text(offer.carrier.name),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const _SummaryRow(
                iconAsset: 'assets/icons/map_pin_sm.svg',
                label: 'Ruta',
                child: Text('Palermo → Belgrano'),
              ),
              const SizedBox(height: 14),
              const _SummaryRow(
                iconAsset: 'assets/icons/calendar_sm.svg',
                label: 'Fecha y Hora',
                child: Text('Sáb 12 Oct, 10:00–13:00'),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppCard(
          radius: AppRadius.xl,
          borderWidth: 0,
          borderColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Servicio de mudanza',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textMuted,
                      height: 1,
                    ),
                  ),
                  Text(
                    formatArs(offer.price),
                    style: AppTypography.appBarTitle.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              const AppDivider(thin: true),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: AppSpacing.xs,
                children: [
                  Text('Total a pagar', style: AppTypography.appBarTitle),
                  Text(
                    formatArs(offer.price),
                    style: AppTypography.userName.copyWith(
                      fontWeight: FontWeight.normal,
                      color: AppColors.textMuted,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.textMuted,
                    ),
                  ),
                  Text(
                    formatArs(discounted),
                    style: AppTypography.priceAmount.copyWith(fontSize: 28),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  const DiscountPill(),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Ahorrás ${formatArs(offer.price - discounted)} pagando '
                      'por transferencia',
                      style: AppTypography.pickerValue.copyWith(
                        color: AppColors.successBright,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/icons/info_sm.svg',
                    width: 14,
                    height: 14,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'El monto queda retenido de forma segura hasta que '
                      'finalice el servicio.',
                      style: AppTypography.itemSubtitle.copyWith(height: 1.4),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.iconSurface,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/shield_md.svg',
                    width: 18,
                    height: 18,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'PROTECCIÓN FLETESFLEX',
                    style: AppTypography.buttonSmall,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Tu pago queda resguardado. Si el servicio no se cumple como '
                'lo pactaste, te devolvemos el 50% automáticamente.',
                style: AppTypography.routeText.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.iconAsset,
    required this.label,
    required this.child,
  });

  final String iconAsset;
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.iconSurface,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(iconAsset, width: 16, height: 16),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label.toUpperCase(), style: AppTypography.infoLabel),
              const SizedBox(height: 2),
              DefaultTextStyle(style: AppTypography.infoValue, child: child),
            ],
          ),
        ),
      ],
    );
  }
}

/// "10% OFF" label: mint fill with green text, or [solid] green fill.
class DiscountPill extends StatelessWidget {
  const DiscountPill({super.key, this.solid = false});

  final bool solid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: solid ? AppColors.successBright : AppColors.discountSurface,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        '${(transferDiscount * 100).round()}% OFF',
        style: AppTypography.badgeLabel.copyWith(
          fontSize: solid ? 10 : 11,
          fontWeight: solid ? FontWeight.w800 : FontWeight.bold,
          color: solid ? AppColors.textPrimary : AppColors.successBright,
        ),
      ),
    );
  }
}
