import 'package:flutter/material.dart';

import '../models/offer.dart';
import '../routes.dart';
import '../theme/theme.dart';
import '../utils/format.dart';
import '../widgets/widgets.dart';

/// Shown after the requester picks an offer, implemented from the Figma
/// "exito-confirmacion-solicitante" design (file o7nkeARTqRUSPsNBaYg2nb,
/// node 30:221). Receives the chosen [Offer] as the route argument.
class ExitoConfirmacionScreen extends StatelessWidget {
  const ExitoConfirmacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offer = ModalRoute.of(context)?.settings.arguments as Offer? ??
        SampleOffers.andres;
    // First name only ("Martín", "Andrés").
    final name = offer.carrier.name.split(' ').first;

    return AppPage(
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.sectionGap,
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Ir a pagar',
            onPressed: () => Navigator.of(context).pushNamed(
              AppRoutes.resumenPago,
              arguments: offer,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'El flete se confirmará de forma definitiva una vez procesado el '
            'pago.',
            style: AppTypography.helper,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      children: [
        const SuccessBurst(),
        const SizedBox(height: 28),
        Text(
          '¡Listo, confirmaste a $name!',
          style: AppTypography.display,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Le avisamos a $name que lo elegiste. Ahora falta que completes el '
          'pago para reservar el servicio.',
          style: AppTypography.body,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),
        AppCard(
          borderWidth: 0,
          borderColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Resumen del servicio',
                style: AppTypography.userName,
              ),
              const SizedBox(height: AppSpacing.md),
              const AppDivider(thin: true),
              const SizedBox(height: AppSpacing.md),
              // TODO: take these from the confirmed request.
              const InfoRow(
                iconAsset: 'assets/icons/box_md.svg',
                label: 'Servicio',
                value: 'Mudanza chica · Palermo → Belgrano',
              ),
              const SizedBox(height: 14),
              const InfoRow(
                iconAsset: 'assets/icons/calendar_md.svg',
                label: 'Fecha',
                value: 'Sáb 12 Oct, 10:00–13:00',
              ),
              const SizedBox(height: 14),
              InfoRow(
                iconAsset: 'assets/icons/banknote.svg',
                label: 'Precio',
                value: formatArs(offer.price),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
