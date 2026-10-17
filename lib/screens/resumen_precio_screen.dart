import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Request summary with the suggested price, implemented from the Figma
/// "resumen-y-precio" design (file o7nkeARTqRUSPsNBaYg2nb, node 2:234).
class ResumenPrecioScreen extends StatelessWidget {
  const ResumenPrecioScreen({super.key});

  // TODO: receive the request built in the form steps instead of samples.
  static const _origin = 'Palermo: Av. Santa Fe 2345, Piso 4 B';
  static const _destination = 'Caballito: Av. Rivadavia 5420, Casa';
  static const _schedule = 'Sábado 24 de Octubre — Mañana (09-13 hs)';
  static const _inventory = '• Sillón de 3 cuerpos (Grande) • Heladera No '
      'Frost (Grande) • 10 x Cajas medianas embaladas';
  static const _suggestedPrice = 145000;

  void _handleConfirm(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      AppRoutes.publicacionActiva,
      (route) => route.settings.name == AppRoutes.home,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Confirmá tu mudanza',
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Confirmar y publicar',
            onPressed: () => _handleConfirm(context),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextLinkButton(
            label: 'Editar datos',
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const RouteSummary(origin: _origin, destination: _destination),
              const SizedBox(height: AppSpacing.md),
              const AppDivider(thin: true),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/calendar.svg',
                    width: 18,
                    height: 18,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(_schedule, style: AppTypography.itemTitle),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              const AppDivider(thin: true),
              const SizedBox(height: AppSpacing.md),
              Text('INVENTARIO DE MUDANZA', style: AppTypography.overline),
              const SizedBox(height: AppSpacing.xs),
              Text(_inventory, style: AppTypography.fieldValue),
              const SizedBox(height: AppSpacing.md),
              const AppDivider(thin: true),
              const SizedBox(height: AppSpacing.md),
              Text('SERVICIOS COMPLEMENTARIOS', style: AppTypography.overline),
              const SizedBox(height: AppSpacing.xs),
              const Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  AppTag('Necesita Ayudantes'),
                  AppTag(
                    'Subida por Escalera',
                    textColor: AppColors.accentDeep,
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        const PriceBox(
          caption: 'Precio estimado sugerido',
          amount: _suggestedPrice,
          helper: 'Los transportistas ofertarán en base a esta referencia.',
        ),
      ],
    );
  }
}

