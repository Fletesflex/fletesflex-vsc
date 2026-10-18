import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/offer.dart';
import '../routes.dart';
import '../theme/theme.dart';
import '../utils/format.dart';
import '../widgets/widgets.dart';
import 'comprobante_pago_screen.dart' show ShadowBackButton;

/// Confirmation step shown right after the requester picks an offer and
/// before the success screen, implemented from the Figma
/// "confirmacion-transportista" design (file neRKyJz313WM7CEdoZdgGl, node
/// 30:4). Receives the chosen [Offer] as the route argument.
class ConfirmacionTransportistaScreen extends StatelessWidget {
  const ConfirmacionTransportistaScreen({super.key});

  void _handleConfirm(BuildContext context, Offer offer) {
    // TODO: confirm the chosen carrier with the backend before navigating.
    Navigator.of(context).pushNamed(
      AppRoutes.exitoConfirmacion,
      arguments: offer,
    );
  }

  @override
  Widget build(BuildContext context) {
    final offer = ModalRoute.of(context)?.settings.arguments as Offer? ??
        SampleOffers.andres;
    final carrier = offer.carrier;
    final firstName = carrier.name.split(' ').first;

    return AppPage(
      header: const Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xs,
        ),
        child: Row(children: [ShadowBackButton()]),
      ),
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xs,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      children: [
        Text('Confirmá tu elección', style: AppTypography.display),
        const SizedBox(height: AppSpacing.md),
        _CarrierCard(carrier: carrier, vehicle: offer.vehicle),
        const SizedBox(height: AppSpacing.sectionGap),
        AppCard(
          borderWidth: 0,
          borderColor: Colors.transparent,
          radius: AppRadius.xl,
          elevatedShadow: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Resumen del servicio', style: AppTypography.userName),
              const SizedBox(height: AppSpacing.md),
              const AppDivider(thin: true),
              const SizedBox(height: AppSpacing.md),
              // TODO: fill from the confirmed request.
              const InfoRow(
                iconAsset: 'assets/icons/box_md.svg',
                label: 'Tipo',
                value: 'Mudanza chica',
              ),
              const SizedBox(height: 14),
              const InfoRow(
                iconAsset: 'assets/icons/map_pin.svg',
                label: 'Ruta',
                value: 'Palermo → Belgrano',
              ),
              const SizedBox(height: 14),
              const InfoRow(
                iconAsset: 'assets/icons/calendar_md.svg',
                label: 'Fecha',
                value: 'Sáb 12 Oct, 10:00–13:00',
              ),
              const SizedBox(height: 14),
              const InfoRow(
                iconAsset: 'assets/icons/clock_md.svg',
                label: 'Horario',
                value: 'Turno mañana',
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        _PriceBlock(price: offer.price),
        const SizedBox(height: AppSpacing.sectionGap),
        Text(
          'Al confirmar, le avisamos a $firstName y vas a poder coordinar '
          'el pago para reservar el servicio.',
          style: AppTypography.routeText.copyWith(height: 1.4),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.md),
        PillButton(
          label: 'Confirmar y continuar',
          onPressed: () => _handleConfirm(context, offer),
        ),
        const SizedBox(height: AppSpacing.md),
        Center(
          child: TextLinkButton(
            label: 'Elegir otro transportista',
            color: AppColors.textPrimary,
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ),
      ],
    );
  }
}

/// Avatar + name + rating + vehicle, mirroring the compact header used by
/// [OfferCard] and the profile hero.
class _CarrierCard extends StatelessWidget {
  const _CarrierCard({required this.carrier, required this.vehicle});

  final Carrier carrier;
  final String vehicle;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      radius: AppRadius.xl,
      borderWidth: 0,
      borderColor: Colors.transparent,
      elevatedShadow: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppAvatar(carrier.avatarAsset, size: 64),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  carrier.name,
                  style: AppTypography.userName.copyWith(fontSize: 18),
                ),
                const SizedBox(height: 4),
                RatingRow(
                  rating: carrier.rating,
                  suffix: '(${carrier.completedJobs} viajes)',
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/truck_muted_xs.svg',
                      width: 14,
                      height: 14,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        vehicle,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.routeText.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Centered hero price with a muted "precio fijo" caption.
class _PriceBlock extends StatelessWidget {
  const _PriceBlock({required this.price});

  final int price;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          formatArs(price),
          style: AppTypography.priceAmount.copyWith(fontSize: 42),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          'Precio fijo del servicio'.toUpperCase(),
          style: AppTypography.priceEstimateLabel.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
