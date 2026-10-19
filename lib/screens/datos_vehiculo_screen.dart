import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Carrier vehicle type/capacity/photos/equipment, start of the carrier
/// vehicle-&-documents verification flow (sub-flow B). Implemented from the
/// Figma "datos-vehiculo" design (file neRKyJz313WM7CEdoZdgGl, node 18:4),
/// reusing the tokens in `lib/theme/`.
class DatosVehiculoScreen extends StatefulWidget {
  const DatosVehiculoScreen({super.key});

  @override
  State<DatosVehiculoScreen> createState() => _DatosVehiculoScreenState();
}

// Figma reuses the exact same "truck" glyph on the Camioneta, Camión
// chico and Camión grande cards (verified against the file's asset
// hashes). The Figma layer for Utilitario is literally named "circle-x"
// (confirmed via get_metadata) — a leftover Lucide placeholder, not a
// deliberate icon — so it's swapped here for the closest matching Lucide
// icon, "car" (assets/icons/car.svg, sourced from lucide-static since the
// Figma file's own library has no vehicle icon besides "truck").
enum _VehicleType {
  camioneta('Camioneta', 'assets/icons/truck_type.svg'),
  camionChico('Camión chico', 'assets/icons/truck_type.svg'),
  camionGrande('Camión grande', 'assets/icons/truck_type.svg'),
  utilitario('Utilitario', 'assets/icons/car.svg');

  const _VehicleType(this.label, this.iconAsset);

  final String label;
  final String iconAsset;
}

class _DatosVehiculoScreenState extends State<DatosVehiculoScreen> {
  _VehicleType _selected = _VehicleType.camioneta;
  bool _ayudantesPropios = true;
  bool _sogasElevacion = false;
  bool _escaleras = true;
  bool _mantasProteccion = false;

  void _handleContinue(BuildContext context) {
    // TODO: persist the selected vehicle type, capacity and uploaded
    // photos before advancing.
    Navigator.of(context).pushNamed(AppRoutes.estadoDocumentacion);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.sm,
        ),
        child: CircleIconButton(
          iconAsset: 'assets/icons/arrow_left_sm.svg',
          onTap: () => Navigator.of(context).maybePop(),
        ),
      ),
      bottom: PrimaryButton(
        label: 'Continuar',
        onPressed: () => _handleContinue(context),
      ),
      children: [
        Text('Contanos sobre tu vehículo', style: AppTypography.headline),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          'Esto ayuda a los solicitantes a saber qué podés transportar',
          style: AppTypography.cardDescription,
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        _VehicleTypeGrid(
          selected: _selected,
          onSelect: (type) => setState(() => _selected = type),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Text(
          'Capacidad de carga',
          style: AppTypography.itemTitle.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppSpacing.xs),
        // TODO: open a picker to edit the declared capacity.
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.border, width: 1.5),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              SvgPicture.asset('assets/icons/weight.svg', width: 20, height: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  '14 m³ · hasta 1.200 kg',
                  style: AppTypography.itemTitle,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        const _PhotosSection(),
        const SizedBox(height: AppSpacing.sectionGap),
        Text(
          'Equipo disponible',
          style: AppTypography.itemTitle.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: AppSpacing.xs),
        AppCard(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          radius: AppRadius.xl,
          borderWidth: 1.5,
          shadow: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _EquipmentRow(
                iconAsset: 'assets/icons/users.svg',
                label: 'Ayudantes propios',
                value: _ayudantesPropios,
                onChanged: (v) => setState(() => _ayudantesPropios = v),
              ),
              const AppDivider(thin: true),
              _EquipmentRow(
                iconAsset: 'assets/icons/anchor.svg',
                label: 'Sogas para elevación',
                value: _sogasElevacion,
                onChanged: (v) => setState(() => _sogasElevacion = v),
              ),
              const AppDivider(thin: true),
              _EquipmentRow(
                iconAsset: 'assets/icons/ladder_waves.svg',
                label: 'Escaleras',
                value: _escaleras,
                onChanged: (v) => setState(() => _escaleras = v),
              ),
              const AppDivider(thin: true),
              _EquipmentRow(
                // Same "circle-x" placeholder situation as Utilitario above
                // — swapped for the closest matching Lucide icon, "layers"
                // (assets/icons/layers.svg, folded-fabric stand-in for
                // protective moving blankets).
                iconAsset: 'assets/icons/layers.svg',
                label: 'Mantas de protección',
                value: _mantasProteccion,
                onChanged: (v) => setState(() => _mantasProteccion = v),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _VehicleTypeGrid extends StatelessWidget {
  const _VehicleTypeGrid({required this.selected, required this.onSelect});

  final _VehicleType selected;
  final ValueChanged<_VehicleType> onSelect;

  @override
  Widget build(BuildContext context) {
    Widget row(List<_VehicleType> types) {
      return Row(
        children: [
          for (var i = 0; i < types.length; i++) ...[
            if (i > 0) const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _VehicleTypeCard(
                type: types[i],
                selected: types[i] == selected,
                onTap: () => onSelect(types[i]),
              ),
            ),
          ],
        ],
      );
    }

    return Column(
      children: [
        row(const [_VehicleType.camioneta, _VehicleType.camionChico]),
        const SizedBox(height: AppSpacing.sm),
        row(const [_VehicleType.camionGrande, _VehicleType.utilitario]),
      ],
    );
  }
}

class _VehicleTypeCard extends StatelessWidget {
  const _VehicleTypeCard({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final _VehicleType type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Container(
        height: 110,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: selected ? AppColors.iconSurface : AppColors.surface,
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.border,
            width: selected ? 2 : 1.5,
          ),
          borderRadius: BorderRadius.circular(AppRadius.xl),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppColors.iconSurface : AppColors.border,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SvgPicture.asset(
                type.iconAsset,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              type.label,
              style: AppTypography.itemTitle.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotosSection extends StatelessWidget {
  const _PhotosSection();

  void _handleUpload(BuildContext context, String slot) {
    // TODO: open the camera/gallery picker for the $slot vehicle photo.
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/camera.svg', width: 20, height: 20),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  'Fotos de tu vehículo',
                  style: AppTypography.itemTitle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              for (final slot in const ['Frente', 'Lateral', 'Esp. de carga'])
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: slot == 'Esp. de carga' ? 0 : AppSpacing.sm,
                    ),
                    child: _VehiclePhotoSlot(
                      label: slot,
                      onTap: () => _handleUpload(context, slot),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'También podés elegir desde tu galería',
            style: AppTypography.vehicleLabel,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// Square dashed-accent upload slot used by the three vehicle-photo cells
/// ("Frente", "Lateral", "Esp. de carga").
class _VehiclePhotoSlot extends StatelessWidget {
  const _VehiclePhotoSlot({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: CustomPaint(
        painter: const DashedBorderPainter(
          color: AppColors.accent,
          radius: AppRadius.xl,
        ),
        child: Container(
          height: 128,
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.iconSurface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  'assets/icons/camera.svg',
                  width: 20,
                  height: 20,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '+ Subir',
                style: AppTypography.badgeLabel.copyWith(fontSize: 12),
              ),
              Text(
                label,
                style: AppTypography.featureLabel,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EquipmentRow extends StatelessWidget {
  const _EquipmentRow({
    required this.iconAsset,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String iconAsset;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final color = value ? AppColors.textPrimary : AppColors.textSecondary;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SvgPicture.asset(
            iconAsset,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              label,
              style: AppTypography.toggleLabel.copyWith(
                fontWeight: FontWeight.w500,
                color: color,
              ),
            ),
          ),
          AppToggle(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
