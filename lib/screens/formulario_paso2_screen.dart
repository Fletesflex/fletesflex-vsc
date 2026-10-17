import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../utils/format.dart';
import '../widgets/widgets.dart';

/// An object the user wants moved.
class InventoryItem {
  const InventoryItem({
    required this.iconAsset,
    required this.name,
    required this.detail,
  });

  final String iconAsset;
  final String name;
  final String detail;
}

/// Estimated time window for the move.
enum TimeSlot {
  manana('Mañana (09-13 hs)'),
  tarde('Tarde (13-18 hs)'),
  noche('Noche (18-21 hs)');

  const TimeSlot(this.label);
  final String label;
}

/// Step 2 of the "Mudanza" request form (inventory, extra services and
/// date/time), implemented from the Figma "formulario-paso-2" design
/// (file o7nkeARTqRUSPsNBaYg2nb, node 2:156), reusing the tokens in
/// `lib/theme/`.
class FormularioPaso2Screen extends StatefulWidget {
  const FormularioPaso2Screen({super.key});

  @override
  State<FormularioPaso2Screen> createState() => _FormularioPaso2ScreenState();
}

class _FormularioPaso2ScreenState extends State<FormularioPaso2Screen> {
  // TODO: replace the sample inventory with items the user adds.
  final List<InventoryItem> _items = [
    const InventoryItem(
      iconAsset: 'assets/icons/sofa.svg',
      name: 'Sillón de 3 cuerpos',
      detail: 'Grande (aprox 2.1m)',
    ),
    const InventoryItem(
      iconAsset: 'assets/icons/refrigerator.svg',
      name: 'Heladera No Frost',
      detail: 'Grande (aprox 1.8m)',
    ),
    const InventoryItem(
      iconAsset: 'assets/icons/box.svg',
      name: 'Cajas medianas x 10',
      detail: 'Varios objetos embalados',
    ),
  ];

  bool _needsHelpers = true;
  bool _needsRopeLift = false;
  bool _needsStairs = true;

  DateTime _date = DateTime.now().add(const Duration(days: 7));
  TimeSlot _timeSlot = TimeSlot.manana;

  void _handleAddItem() {
    // TODO: open the "add object" flow.
  }

  void _handleUploadPhotos() {
    // TODO: open the photo picker.
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTimeSlot() async {
    final picked = await showModalBottomSheet<TimeSlot>(
      context: context,
      backgroundColor: AppColors.surface,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final slot in TimeSlot.values)
              ListTile(
                title: Text(slot.label, style: AppTypography.itemTitle),
                trailing: slot == _timeSlot
                    ? const Icon(Icons.check, color: AppColors.textPrimary)
                    : null,
                onTap: () => Navigator.of(context).pop(slot),
              ),
          ],
        ),
      ),
    );
    if (picked != null) setState(() => _timeSlot = picked);
  }

  void _handleViewSummary() {
    Navigator.of(context).pushNamed(AppRoutes.resumenPrecio);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Paso 2: Inventario',
      trailing: const StepIndicator(current: 1, total: 2),
      bottom: PrimaryButton(
        label: 'Ver resumen',
        onPressed: _handleViewSummary,
      ),
      children: [
        _buildInventorySection(),
        const _SectionDivider(),
        _buildServicesSection(),
        const _SectionDivider(),
        _buildDateTimeSection(),
      ],
    );
  }

  Widget _buildInventorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Objetos a trasladar', style: AppTypography.groupTitle),
        const SizedBox(height: 10),
        for (var i = 0; i < _items.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.xs),
          _InventoryItemTile(
            item: _items[i],
            onRemove: () => setState(() => _items.removeAt(i)),
          ),
        ],
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _SoftButton(
                iconAsset: 'assets/icons/plus_circle_sm.svg',
                label: 'Agregar objeto',
                onTap: _handleAddItem,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _SoftButton(
                iconAsset: 'assets/icons/camera.svg',
                label: 'Subir fotos',
                labelColor: AppColors.accentDeep,
                onTap: _handleUploadPhotos,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildServicesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Servicios adicionales', style: AppTypography.groupTitle),
        const SizedBox(height: AppSpacing.sm),
        ToggleRow(
          label: 'Necesito ayudantes/peones (Carga/Descarga)',
          value: _needsHelpers,
          onChanged: (v) => setState(() => _needsHelpers = v),
        ),
        const SizedBox(height: AppSpacing.sm),
        ToggleRow(
          label: 'Elevación con sogas por balcón',
          value: _needsRopeLift,
          onChanged: (v) => setState(() => _needsRopeLift = v),
        ),
        const SizedBox(height: AppSpacing.sm),
        ToggleRow(
          label: 'Subida/bajada por escalera',
          value: _needsStairs,
          onChanged: (v) => setState(() => _needsStairs = v),
        ),
      ],
    );
  }

  Widget _buildDateTimeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Fecha y Horario estimado', style: AppTypography.groupTitle),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _PickerField(
                iconAsset: 'assets/icons/calendar.svg',
                value: formatDateShort(_date),
                onTap: _pickDate,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _PickerField(
                iconAsset: 'assets/icons/clock.svg',
                value: _timeSlot.label,
                onTap: _pickTimeSlot,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.sectionGap),
      child: AppDivider(),
    );
  }
}

class _InventoryItemTile extends StatelessWidget {
  const _InventoryItemTile({required this.item, required this.onRemove});

  final InventoryItem item;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        children: [
          SvgPicture.asset(item.iconAsset, width: 20, height: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: AppTypography.itemTitle),
                const SizedBox(height: AppSpacing.badgeVertical),
                Text(item.detail, style: AppTypography.itemSubtitle),
              ],
            ),
          ),
          InkResponse(
            onTap: onRemove,
            radius: 20,
            child: SvgPicture.asset(
              'assets/icons/trash.svg',
              width: 20,
              height: 20,
            ),
          ),
        ],
      ),
    );
  }
}

/// Soft-yellow compact button with a leading icon.
class _SoftButton extends StatelessWidget {
  const _SoftButton({
    required this.iconAsset,
    required this.label,
    required this.onTap,
    this.labelColor = AppColors.textPrimary,
  });

  final String iconAsset;
  final String label;
  final Color labelColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.iconSurface,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(iconAsset, width: 16, height: 16),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTypography.smallAction.copyWith(color: labelColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Bordered tappable field showing an icon and the current picked value.
class _PickerField extends StatelessWidget {
  const _PickerField({
    required this.iconAsset,
    required this.value,
    required this.onTap,
  });

  final String iconAsset;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: AppColors.border, width: 1.5),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            children: [
              SvgPicture.asset(iconAsset, width: 18, height: 18),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
                child: Text(
                  value,
                  style: AppTypography.pickerValue,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
