import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/request.dart';
import '../models/service_type.dart';
import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Carrier home: available requests marketplace, implemented from the Figma
/// "transportista-solicitudes" design (file o7nkeARTqRUSPsNBaYg2nb,
/// node 2:548).
class TransportistaSolicitudesScreen extends StatefulWidget {
  const TransportistaSolicitudesScreen({super.key});

  @override
  State<TransportistaSolicitudesScreen> createState() =>
      _TransportistaSolicitudesScreenState();
}

class _TransportistaSolicitudesScreenState
    extends State<TransportistaSolicitudesScreen> {
  // TODO: load from the API; 18 is the total shown in the design.
  static const _requests = SampleRequests.all;
  static const _activeCount = 18;

  /// Null = "Todas".
  ServiceType? _filter;

  List<TransportRequest> get _visible => _filter == null
      ? _requests
      : _requests.where((r) => r.type == _filter).toList();

  void _openZoneFilter() {
    // TODO: open the zone/radius filter.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const CarrierNavBar(current: CarrierTab.solicitudes),
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(
            top: AppSpacing.md,
            bottom: AppSpacing.lg,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('En servicio 🟢', style: AppTypography.greeting),
                        const SizedBox(height: 2),
                        Text(
                          'Hola, Martín 👋',
                          style: AppTypography.greetingTitle,
                        ),
                      ],
                    ),
                  ),
                  const AppAvatar('assets/images/avatar_martin_sm.png', size: 44),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: _LocationBanner(onTap: _openZoneFilter),
            ),
            const SizedBox(height: AppSpacing.md),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  FilterChipButton(
                    label: 'Todas',
                    selected: _filter == null,
                    onTap: () => setState(() => _filter = null),
                  ),
                  for (final type in ServiceType.values) ...[
                    const SizedBox(width: AppSpacing.xs),
                    FilterChipButton(
                      label: type.label,
                      selected: _filter == type,
                      onTap: () => setState(() => _filter = type),
                    ),
                  ],
                  const SizedBox(width: AppSpacing.xs),
                  FilterChipButton(
                    label: 'Zona',
                    iconAsset: 'assets/icons/sliders.svg',
                    selected: false,
                    onTap: _openZoneFilter,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sectionGap),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Solicitudes disponibles', style: AppTypography.userName),
                  Text(
                    '$_activeCount activas',
                    style: AppTypography.featureLabel,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            for (final (i, request) in _visible.indexed) ...[
              if (i > 0) const SizedBox(height: AppSpacing.md),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                ),
                child: RequestCard(
                  request: request,
                  onOpen: () => Navigator.of(context).pushNamed(
                    AppRoutes.detalleSolicitud,
                    arguments: request,
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

class _LocationBanner extends StatelessWidget {
  const _LocationBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/map_pin_sm.svg',
                width: 16,
                height: 16,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Radio de búsqueda: CABA y alrededores',
                  style: AppTypography.pickerValue,
                ),
              ),
              SvgPicture.asset(
                'assets/icons/chevron_right.svg',
                width: 16,
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Rounded filter chip: accent when selected, white with border otherwise.
class FilterChipButton extends StatelessWidget {
  const FilterChipButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.iconAsset,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final String? iconAsset;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.surface,
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.border,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconAsset != null) ...[
              SvgPicture.asset(iconAsset!, width: 14, height: 14),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: AppTypography.featureLabel.copyWith(
                color: selected
                    ? AppColors.textPrimary
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
