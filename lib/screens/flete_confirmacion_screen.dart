import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import '../utils/format.dart';
import '../widgets/widgets.dart';

/// Step 3 of the "Flete" request form (confirmation), implemented from the
/// Figma "flete-confirmacion" design (file neRKyJz313WM7CEdoZdgGl, node
/// 41:4), reusing the tokens in `lib/theme/`.
class FleteConfirmacionScreen extends StatelessWidget {
  const FleteConfirmacionScreen({super.key});

  void _handleConfirm() {
    // TODO: submit the flete request and navigate to the success screen.
  }

  void _handleEdit(BuildContext context) {
    // TODO: return to a specific step to edit the request data.
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Confirmar flete',
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
        const _RouteScheduleCard(),
        const SizedBox(height: AppSpacing.md),
        const _ObjectsCard(),
        const SizedBox(height: AppSpacing.md),
        const _VehicleCard(),
        const SizedBox(height: AppSpacing.xs),
        const _PriceSection(),
        const SizedBox(height: AppSpacing.sectionGap),
        PillButton(
          label: 'Confirmar y publicar flete',
          onPressed: _handleConfirm,
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

/// "Recorrido y horario" card: origin, destination and scheduled date/time,
/// each as an icon + muted caption + value row, separated by hairlines.
class _RouteScheduleCard extends StatelessWidget {
  const _RouteScheduleCard();

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
          Text('Recorrido y horario', style: AppTypography.cardHeading),
          const SizedBox(height: AppSpacing.sectionGap),
          const _RouteInfoRow(
            iconAsset: 'assets/icons/map_pin.svg',
            label: 'Origen',
            value: 'Av. Córdoba 1234, CABA',
          ),
          const SizedBox(height: AppSpacing.sm),
          const SizedBox(width: double.infinity, child: AppDivider()),
          const SizedBox(height: AppSpacing.sm),
          const _RouteInfoRow(
            iconAsset: 'assets/icons/flag_triangle_right.svg',
            label: 'Destino',
            value: 'Av. Libertador 5678, Vicente López',
          ),
          const SizedBox(height: AppSpacing.sm),
          const SizedBox(width: double.infinity, child: AppDivider()),
          const SizedBox(height: AppSpacing.sm),
          const _RouteInfoRow(
            iconAsset: 'assets/icons/calendar_days.svg',
            label: 'Fecha y hora programada',
            value: 'Sábado 12 de octubre — 9:00 hs',
          ),
        ],
      ),
    );
  }
}

/// 18px icon + muted caption + value, used inside [_RouteScheduleCard].
class _RouteInfoRow extends StatelessWidget {
  const _RouteInfoRow({
    required this.iconAsset,
    required this.label,
    required this.value,
  });

  final String iconAsset;
  final String label;
  final String value;

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
              Text(value, style: AppTypography.addressValue),
            ],
          ),
        ),
      ],
    );
  }
}

/// Cargo summary card: a stack of overlapping thumbnails plus a title and
/// subtitle ("3 objetos cargados").
class _ObjectsCard extends StatelessWidget {
  const _ObjectsCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderWidth: 0,
      borderColor: Colors.transparent,
      radius: AppRadius.xl,
      elevatedShadow: true,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          const _ObjectThumbStack(
            photoAssets: [
              'assets/images/photo_fridge.png',
              'assets/images/photo_sofa.png',
              'assets/images/photo_boxes.png',
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3 objetos cargados', style: AppTypography.cardHeading),
                const SizedBox(height: 2),
                Text(
                  'Heladera, Sillón y caja de embalaje',
                  style: AppTypography.cardCaption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Row of overlapping 40px circular thumbnails with a white border.
class _ObjectThumbStack extends StatelessWidget {
  const _ObjectThumbStack({required this.photoAssets});

  final List<String> photoAssets;

  static const double _size = 40;
  static const double _overlap = 12;

  @override
  Widget build(BuildContext context) {
    final width = _size + (photoAssets.length - 1) * (_size - _overlap);
    return SizedBox(
      width: width,
      height: _size,
      child: Stack(
        children: [
          for (var i = 0; i < photoAssets.length; i++)
            Positioned(
              left: i * (_size - _overlap),
              child: Container(
                width: _size,
                height: _size,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surface, width: 2),
                ),
                child: ClipOval(
                  child: Image.asset(photoAssets[i], fit: BoxFit.cover),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Soft-yellow card showing the automatically-assigned vehicle.
class _VehicleCard extends StatelessWidget {
  const _VehicleCard();

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
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.textPrimary,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: SvgPicture.asset(
              'assets/icons/truck.svg',
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vehículo asignado para tu flete'.toUpperCase(),
                  style: AppTypography.vehicleLabel,
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text('Camioneta', style: AppTypography.vehicleTitle),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  'Calculado automáticamente según el volumen de tu carga.',
                  style: AppTypography.itemSubtitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Centered "Precio estimado" hero with the estimated total.
class _PriceSection extends StatelessWidget {
  const _PriceSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Precio estimado', style: AppTypography.priceEstimateLabel),
        const SizedBox(height: AppSpacing.xxs),
        Text(formatArs(130000), style: AppTypography.priceHero),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          'Basado en distancia, vehículo y volumen',
          style: AppTypography.itemSubtitle,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
