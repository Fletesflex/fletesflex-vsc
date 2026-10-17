import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/service_type.dart';
import '../routes.dart';
import '../theme/theme.dart';
import '../utils/format.dart';
import '../widgets/widgets.dart';

/// Status tabs of the carrier's offers.
enum OfferStatusTab {
  pendientes('Pendientes', 'pendientes'),
  aceptadas('Aceptadas', 'aceptadas'),
  finalizadas('Finalizadas', 'finalizadas'),
  rechazadas('Rechazadas', 'rechazadas');

  const OfferStatusTab(this.label, this.emptyNoun);

  final String label;

  /// Used in the empty-state title ("Todavía no tenés ofertas …").
  final String emptyNoun;
}

/// One of the carrier's own offers.
class _MyOffer {
  const _MyOffer(this.type, this.reference, this.route, this.when, this.budget);

  final ServiceType type;
  final String reference;
  final String route;
  final String when;
  final int budget;
}

/// Carrier's offers by status, implemented from the Figma
/// "mis-ofertas-pendientes" (node 6:5) and "mis-ofertas-empty" (node 6:140)
/// designs (file o7nkeARTqRUSPsNBaYg2nb). Pass an [OfferStatusTab] as the
/// route argument to open a specific tab.
class MisOfertasScreen extends StatefulWidget {
  const MisOfertasScreen({super.key});

  @override
  State<MisOfertasScreen> createState() => _MisOfertasScreenState();
}

class _MisOfertasScreenState extends State<MisOfertasScreen> {
  // TODO: load from the API. Only "Pendientes" has data in the design.
  static const _offers = {
    OfferStatusTab.pendientes: [
      _MyOffer(ServiceType.mudanza, '#9482', 'Palermo → Belgrano',
          'Sáb 12 Oct · 09:00', 48000),
      _MyOffer(ServiceType.flete, '#8571', 'Flores → Lanús',
          'Mar 15 Oct · 11:00', 22000),
      _MyOffer(ServiceType.mensajeria, '#7324', 'Recoleta → Microcentro',
          'Hoy · 16:30', 9500),
    ],
  };

  OfferStatusTab? _tab;

  @override
  Widget build(BuildContext context) {
    final tab = _tab ??
        (ModalRoute.of(context)?.settings.arguments as OfferStatusTab? ??
            OfferStatusTab.pendientes);
    final offers = _offers[tab] ?? const <_MyOffer>[];

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const CarrierNavBar(current: CarrierTab.ofertas),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.md,
                AppSpacing.lg,
                AppSpacing.xs,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mis ofertas',
                    style: AppTypography.greetingTitle.copyWith(fontSize: 28),
                  ),
                  _SquareIconButton(
                    iconAsset: 'assets/icons/search.svg',
                    onTap: () {
                      // TODO: search offers.
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            UnderlineTabs<OfferStatusTab>(
              tabs: {for (final t in OfferStatusTab.values) t: t.label},
              selected: tab,
              onChanged: (t) => setState(() => _tab = t),
            ),
            Expanded(
              child: offers.isEmpty
                  ? _EmptyState(tab: tab)
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        AppSpacing.sectionGap,
                        AppSpacing.lg,
                        AppSpacing.lg,
                      ),
                      children: [
                        const HintBanner(
                          iconAsset: 'assets/icons/message_circle_more.svg',
                          text: 'Las ofertas aceptadas incluyen chat directo '
                              'con el solicitante.',
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ofertas ${tab.emptyNoun}',
                              style: AppTypography.userName,
                            ),
                            Text(
                              '${offers.length} activas',
                              style: AppTypography.featureLabel,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.md),
                        for (final (i, offer) in offers.indexed) ...[
                          if (i > 0) const SizedBox(height: AppSpacing.md),
                          _MyOfferCard(offer: offer),
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SquareIconButton extends StatelessWidget {
  const _SquareIconButton({required this.iconAsset, required this.onTap});

  final String iconAsset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.xs),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: SvgPicture.asset(iconAsset, width: 18, height: 18),
      ),
    );
  }
}

/// Horizontal text tabs with a 3px accent underline on the selected one and
/// a hairline below the row.
class UnderlineTabs<T> extends StatelessWidget {
  const UnderlineTabs({
    super.key,
    required this.tabs,
    required this.selected,
    required this.onChanged,
  });

  final Map<T, String> tabs;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final (i, entry) in tabs.entries.indexed) ...[
              if (i > 0) const SizedBox(width: AppSpacing.md),
              InkWell(
                onTap: () => onChanged(entry.key),
                child: IntrinsicWidth(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.value,
                        style: AppTypography.fieldValue.copyWith(
                          fontWeight: entry.key == selected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: entry.key == selected
                              ? AppColors.textPrimary
                              : AppColors.textSecondary,
                        ),
                      ),
                      Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: entry.key == selected
                              ? AppColors.accent
                              : Colors.transparent,
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Soft-yellow banner with an amber border, icon and short message.
class HintBanner extends StatelessWidget {
  const HintBanner({super.key, required this.iconAsset, required this.text});

  final String iconAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.iconSurface,
        border: Border.all(color: AppColors.accentDeep),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          SvgPicture.asset(iconAsset, width: 20, height: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: AppTypography.checkLabel.copyWith(height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyOfferCard extends StatelessWidget {
  const _MyOfferCard({required this.offer});

  final _MyOffer offer;

  void _open(BuildContext context) {
    Navigator.of(context).pushNamed(AppRoutes.detalleSolicitud);
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      radius: AppRadius.xl,
      onTap: () => _open(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ServiceBadge(offer.type),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  'Ref: ${offer.reference}',
                  style: AppTypography.itemSubtitle.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const AppTag(
                'Pendiente',
                textColor: AppColors.accentDeep,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              SvgPicture.asset(
                offer.type == ServiceType.mensajeria
                    ? 'assets/icons/bike.svg'
                    : 'assets/icons/truck_md.svg',
                width: 16,
                height: 16,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  offer.route,
                  style: AppTypography.routeTitle,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/calendar_xs_2.svg',
                width: 14,
                height: 14,
              ),
              const SizedBox(width: AppSpacing.xxs),
              Text(offer.when, style: AppTypography.routeText),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.only(top: AppSpacing.sm),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('TU PRESUPUESTO', style: AppTypography.micro),
                    const SizedBox(height: 1),
                    Text(
                      formatArs(offer.budget),
                      style: AppTypography.priceSmall,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Ver detalle', style: AppTypography.featureLabel),
                    const SizedBox(width: AppSpacing.xxs),
                    SvgPicture.asset(
                      'assets/icons/chevron_right.svg',
                      width: 14,
                      height: 14,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textPrimary,
                        BlendMode.srcIn,
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

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.tab});

  final OfferStatusTab tab;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(32, 60, 32, 40),
      child: Column(
        children: [
          const OrbitIllustration(
            size: 160,
            rings: [
              ('assets/images/orbit_glow.png', 140, 0.4),
              ('assets/icons/burst_ring.svg', 100, 1),
            ],
            centerSize: 64,
            iconAsset: 'assets/icons/clipboard_check.svg',
            decorations: [
              OrbitDecoration('assets/icons/dot_accent_8.svg', 24, 30, 8),
              OrbitDecoration('assets/icons/dot_dark_6.svg', 128, 38, 6),
              OrbitDecoration('assets/icons/dot_accent_8.svg', 124, 114, 8),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            'Todavía no tenés ofertas ${tab.emptyNoun}',
            style: AppTypography.appBarTitle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            // TODO: confirm copy for the tabs other than "Finalizadas".
            'Cuando completes un servicio coordinado por la app, aparecerá '
            'listado en esta pestaña.',
            style: AppTypography.body.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 28),
          Material(
            color: AppColors.iconSurface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            child: InkWell(
              onTap: () => Navigator.of(context).pushReplacementNamed(
                AppRoutes.transportistaSolicitudes,
              ),
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.sm,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Explorar solicitudes',
                      style: AppTypography.buttonSmall.copyWith(fontSize: 15),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    SvgPicture.asset(
                      'assets/icons/chevron_right.svg',
                      width: 16,
                      height: 16,
                      colorFilter: const ColorFilter.mode(
                        AppColors.textPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
