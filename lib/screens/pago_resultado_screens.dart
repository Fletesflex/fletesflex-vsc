import 'package:flutter/material.dart';

import '../models/offer.dart';
import '../routes.dart';
import '../theme/theme.dart';
import '../utils/format.dart';
import '../widgets/widgets.dart';
import 'resumen_pago_screen.dart';

/// Payment approved, implemented from the Figma "pago-confirmado" design
/// (file o7nkeARTqRUSPsNBaYg2nb, node 30:419). Receives the paid [Offer] as
/// the route argument.
class PagoConfirmadoScreen extends StatelessWidget {
  const PagoConfirmadoScreen({super.key, this.byTransfer = false});

  /// Shows the transfer variant ("transferencia-confirmada", node 33:121):
  /// discounted amount and bank-transfer method.
  final bool byTransfer;

  @override
  Widget build(BuildContext context) {
    final offer = ModalRoute.of(context)?.settings.arguments as Offer? ??
        SampleOffers.andres;
    final name = offer.carrier.name.split(' ').first;
    final paid = byTransfer ? transferPrice(offer.price) : offer.price;

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
            label: 'Ir al chat con $name',
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.chat,
              (route) => route.settings.name == AppRoutes.home,
              arguments: offer,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(
              AppRoutes.comprobantePago,
              arguments: offer,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xxs),
              child: Text('Ver comprobante', style: AppTypography.itemTitle),
            ),
          ),
        ],
      ),
      children: [
        const SuccessBurst(),
        const SizedBox(height: 28),
        Text(
          '¡Pago confirmado!',
          style: AppTypography.display,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Tu dinero queda resguardado hasta que se complete la mudanza. Ya '
          'podés coordinar los detalles con tu transportista.',
          style: AppTypography.body.copyWith(height: 1.45),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),
        AppCard(
          borderWidth: 0,
          borderColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Comprobante de pago', style: AppTypography.userName),
              const SizedBox(height: AppSpacing.md),
              const AppDivider(thin: true),
              const SizedBox(height: AppSpacing.md),
              InfoRow(
                iconAsset: 'assets/icons/banknote.svg',
                label: 'Monto pagado',
                value: formatArs(paid),
              ),
              const SizedBox(height: 14),
              // TODO: card and receipt number from the payment response.
              InfoRow(
                iconAsset: byTransfer
                    ? 'assets/icons/building.svg'
                    : 'assets/icons/credit_card_md.svg',
                label: 'Método de pago',
                value: byTransfer
                    ? 'Transferencia bancaria'
                    : 'Tarjeta terminada en 4242',
              ),
              const SizedBox(height: 14),
              const InfoRow(
                iconAsset: 'assets/icons/box_md.svg',
                label: 'Nro. de Comprobante',
                value: '#FLX-2024-08471',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Payment rejected, implemented from the Figma "pago-rechazado" design
/// (file o7nkeARTqRUSPsNBaYg2nb, node 30:486).
class PagoRechazadoScreen extends StatelessWidget {
  const PagoRechazadoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      bodyPadding: const EdgeInsets.fromLTRB(32, 80, 32, AppSpacing.sectionGap),
      bottom: PrimaryButton(
        label: 'Reintentar pago',
        onPressed: () => Navigator.of(context).pushReplacementNamed(
          AppRoutes.cargaPago,
          arguments: ModalRoute.of(context)?.settings.arguments,
        ),
      ),
      children: [
        const SuccessBurst(
          iconAsset: 'assets/icons/alert_circle.svg',
          iconWidth: 24,
          iconHeight: 24,
          glowAsset: 'assets/images/burst_glow_soft.png',
          glowOpacity: 0.5,
          centerOffsetY: -4,
          decorations: SuccessBurst.errorDecorations,
        ),
        const SizedBox(height: 36),
        Text(
          'No pudimos procesar tu pago',
          style: AppTypography.display.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Mercado Pago rechazó la operación. Revisá que tu medio de pago '
          'tenga fondos disponibles o probá con otro método.',
          style: AppTypography.body,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
