import 'package:flutter/material.dart';

import '../models/offer.dart';
import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Offers received for a published request, implemented from the Figma
/// "listado-de-ofertas" design (file o7nkeARTqRUSPsNBaYg2nb, node 2:316).
class ListadoOfertasScreen extends StatelessWidget {
  const ListadoOfertasScreen({super.key});

  // TODO: load offers for the user's active request.
  static const _offers = SampleOffers.all;

  void _viewProfile(BuildContext context, Offer offer) {
    Navigator.of(context).pushNamed(
      AppRoutes.perfilTransportista,
      arguments: offer,
    );
  }

  void _choose(BuildContext context, Offer offer) {
    Navigator.of(context).pushNamed(
      AppRoutes.confirmacionTransportista,
      arguments: offer,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Ofertas recibidas', style: AppTypography.pageTitle),
            ),
            AppTag(
              '${_offers.length} nuevas',
              color: AppColors.successSurface,
              textColor: AppColors.success,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          'Palermo → Caballito • Sáb 24 de Oct',
          style: AppTypography.routeText,
        ),
        const SizedBox(height: AppSpacing.md),
        for (final (i, offer) in _offers.indexed) ...[
          if (i > 0) const SizedBox(height: AppSpacing.md),
          OfferCard(
            offer: offer,
            highlighted: i == 0,
            onViewProfile: () => _viewProfile(context, offer),
            onChoose: () => _choose(context, offer),
          ),
        ],
      ],
    );
  }
}
