import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// When the delivery should happen.
enum _DeliveryTiming { now, scheduled }

/// Step 1 of the "Mensajería" request form (pickup/delivery addresses and
/// timing), implemented from the Figma "mensajeria-paso-1-direcciones"
/// design (file neRKyJz313WM7CEdoZdgGl, node 42:4), reusing the tokens in
/// `lib/theme/`.
class MensajeriaPaso1Screen extends StatefulWidget {
  const MensajeriaPaso1Screen({super.key});

  @override
  State<MensajeriaPaso1Screen> createState() => _MensajeriaPaso1ScreenState();
}

class _MensajeriaPaso1ScreenState extends State<MensajeriaPaso1Screen> {
  final _pickupAddress = TextEditingController();
  final _pickupReference = TextEditingController();
  final _deliveryAddress = TextEditingController();
  final _deliveryReference = TextEditingController();
  var _timing = _DeliveryTiming.now;

  @override
  void dispose() {
    _pickupAddress.dispose();
    _pickupReference.dispose();
    _deliveryAddress.dispose();
    _deliveryReference.dispose();
    super.dispose();
  }

  void _handleNext(BuildContext context) {
    // TODO: validate the addresses and timing before continuing.
    Navigator.of(context).pushNamed(AppRoutes.mensajeriaPaso2);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Nueva mensajería',
      topBarStyle: TopBarStyle.centered,
      children: [
        const StepIndicator(
          current: 0,
          total: 3,
          style: StepIndicatorStyle.bars,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text('Paso 1: Direcciones', style: AppTypography.textAction),
        const SizedBox(height: AppSpacing.sectionGap),
        Text('¿A dónde llevamos tu envío?', style: AppTypography.headline),
        const SizedBox(height: AppSpacing.sectionGap),
        FormSectionCard(
          icon: SvgPicture.asset(
            'assets/icons/icon_bg_pin.svg',
            width: 28,
            height: 28,
          ),
          title: 'Dirección de retiro',
          children: [
            LabeledField(
              label: 'DIRECCIÓN',
              child: FormTextField(
                controller: _pickupAddress,
                hintText: 'Ej: Av. Córdoba 1234, CABA',
                leadingIconAsset: 'assets/icons/map_pin.svg',
                fillColor: AppColors.background,
                keyboardType: TextInputType.streetAddress,
              ),
            ),
            LabeledField(
              label: 'REFERENCIA (OPCIONAL)',
              child: FormTextField(
                controller: _pickupReference,
                hintText: 'Ej: Depto 4B, timbre 2',
                fillColor: AppColors.background,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        FormSectionCard(
          icon: Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.iconSurface,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/flag_triangle_right.svg',
              width: 14,
              height: 14,
            ),
          ),
          title: 'Dirección de entrega',
          children: [
            LabeledField(
              label: 'DIRECCIÓN',
              child: FormTextField(
                controller: _deliveryAddress,
                hintText: 'Ej: Av. Libertador 5678, Vicente López',
                leadingIconAsset: 'assets/icons/flag_triangle_right.svg',
                fillColor: AppColors.background,
                keyboardType: TextInputType.streetAddress,
              ),
            ),
            LabeledField(
              label: 'REFERENCIA (OPCIONAL)',
              child: FormTextField(
                controller: _deliveryReference,
                hintText: 'Ej: Portería, preguntar por Ana',
                fillColor: AppColors.background,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        FormSectionCard(
          icon: SvgPicture.asset(
            'assets/icons/icon_bg_calendar.svg',
            width: 28,
            height: 28,
          ),
          title: 'Fecha y horario',
          children: [
            Row(
              children: [
                Expanded(
                  child: _TimingChip(
                    iconAsset: 'assets/icons/bolt.svg',
                    label: 'Lo antes posible',
                    selected: _timing == _DeliveryTiming.now,
                    onTap: () => setState(() => _timing = _DeliveryTiming.now),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _TimingChip(
                    iconAsset: 'assets/icons/calendar_xs.svg',
                    label: 'Programar',
                    selected: _timing == _DeliveryTiming.scheduled,
                    onTap: () =>
                        setState(() => _timing = _DeliveryTiming.scheduled),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        PillButton(label: 'Siguiente', onPressed: () => _handleNext(context)),
      ],
    );
  }
}

/// Equal-width timing option with a leading icon (e.g. "Lo antes posible" /
/// "Programar"); the selected one is solid accent, the rest white-bordered.
class _TimingChip extends StatelessWidget {
  const _TimingChip({
    required this.iconAsset,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String iconAsset;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.surface,
          border: selected
              ? null
              : Border.all(color: AppColors.border, width: 1.5),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(iconAsset, width: 16, height: 16),
            const SizedBox(width: AppSpacing.xs),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: selected
                    ? AppTypography.chipSelected
                    : AppTypography.chip,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
