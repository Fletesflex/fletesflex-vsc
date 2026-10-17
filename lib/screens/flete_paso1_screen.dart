import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Step 1 of the "Flete" request form (pickup/delivery addresses and
/// schedule), implemented from the Figma "flete-paso-1-direcciones" design
/// (file neRKyJz313WM7CEdoZdgGl, node 37:4), reusing the tokens in
/// `lib/theme/`.
class FletePaso1Screen extends StatefulWidget {
  const FletePaso1Screen({super.key});

  @override
  State<FletePaso1Screen> createState() => _FletePaso1ScreenState();
}

class _FletePaso1ScreenState extends State<FletePaso1Screen> {
  final _originAddress = TextEditingController();
  final _originFloor = TextEditingController();
  final _destinationAddress = TextEditingController();
  final _destinationFloor = TextEditingController();

  @override
  void dispose() {
    _originAddress.dispose();
    _originFloor.dispose();
    _destinationAddress.dispose();
    _destinationFloor.dispose();
    super.dispose();
  }

  void _handleOriginTypeTap() {
    // TODO: open the property-type picker for the pickup address.
  }

  void _handleDestinationTypeTap() {
    // TODO: open the property-type picker for the delivery address.
  }

  void _handlePickDate() {
    // TODO: open the date picker.
  }

  void _handlePickTime() {
    // TODO: open the time-slot picker.
  }

  void _handleAddStop() {
    // TODO: add an intermediate stop.
  }

  void _handleNext() {
    // TODO: validate the addresses and schedule before continuing.
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Nuevo flete',
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
        _SectionCard(
          iconAsset: 'assets/icons/icon_bg_pin.svg',
          title: 'Origen',
          children: [
            _LabeledField(
              label: 'DIRECCIÓN DE RETIRO',
              child: FormTextField(
                controller: _originAddress,
                hintText: 'Ingresá la dirección de retiro',
                leadingIconAsset: 'assets/icons/map_pin.svg',
                fillColor: AppColors.background,
                keyboardType: TextInputType.streetAddress,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: _LabeledField(
                    label: 'TIPO DE DOMICILIO',
                    child: FormTextField(
                      hintText: 'Casa / Depto',
                      fillColor: AppColors.background,
                      trailingIconAsset: 'assets/icons/chevron_down.svg',
                      readOnly: true,
                      onTap: _handleOriginTypeTap,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _LabeledField(
                    label: 'PISO / DEPTO',
                    child: FormTextField(
                      controller: _originFloor,
                      hintText: 'Ej: 4to B',
                      fillColor: AppColors.background,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        _SectionCard(
          iconAsset: 'assets/icons/icon_bg_pin.svg',
          title: 'Destino',
          children: [
            _LabeledField(
              label: 'DIRECCIÓN DE ENTREGA',
              child: FormTextField(
                controller: _destinationAddress,
                hintText: 'Ingresá la dirección de entrega',
                leadingIconAsset: 'assets/icons/map_pin.svg',
                fillColor: AppColors.background,
                keyboardType: TextInputType.streetAddress,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: _LabeledField(
                    label: 'TIPO DE DOMICILIO',
                    child: FormTextField(
                      hintText: 'Casa / Depto',
                      fillColor: AppColors.background,
                      trailingIconAsset: 'assets/icons/chevron_down.svg',
                      readOnly: true,
                      onTap: _handleDestinationTypeTap,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _LabeledField(
                    label: 'PISO / DEPTO',
                    child: FormTextField(
                      controller: _destinationFloor,
                      hintText: 'Ej: PB',
                      fillColor: AppColors.background,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        _AddStopRow(onTap: _handleAddStop),
        const SizedBox(height: AppSpacing.sectionGap),
        _SectionCard(
          iconAsset: 'assets/icons/icon_bg_calendar.svg',
          title: 'Fecha y horario',
          children: [
            Row(
              children: [
                Expanded(
                  child: _LabeledField(
                    label: 'FECHA',
                    child: FormTextField(
                      hintText: 'Elegí la fecha',
                      leadingIconAsset: 'assets/icons/calendar_sm.svg',
                      fillColor: AppColors.background,
                      readOnly: true,
                      onTap: _handlePickDate,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _LabeledField(
                    label: 'HORARIO ESTIMADO',
                    child: FormTextField(
                      hintText: 'Horario estimado',
                      leadingIconAsset: 'assets/icons/clock.svg',
                      fillColor: AppColors.background,
                      readOnly: true,
                      onTap: _handlePickTime,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        PillButton(label: 'Siguiente', onPressed: _handleNext),
      ],
    );
  }
}

/// White rounded card with an icon + title header, a divider, and a
/// vertical list of fields below (origin/destination/schedule sections).
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.iconAsset,
    required this.title,
    required this.children,
  });

  final String iconAsset;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderWidth: 0,
      borderColor: Colors.transparent,
      radius: AppRadius.xl,
      elevatedShadow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SvgPicture.asset(iconAsset, width: 28, height: 28),
              const SizedBox(width: AppSpacing.xs),
              Text(title, style: AppTypography.groupTitle),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const AppDivider(thin: true),
          const SizedBox(height: AppSpacing.md),
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0) const SizedBox(height: AppSpacing.md),
            children[i],
          ],
        ],
      ),
    );
  }
}

/// Uppercase caption above a [FormTextField] (e.g. "TIPO DE DOMICILIO").
class _LabeledField extends StatelessWidget {
  const _LabeledField({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTypography.caps),
        const SizedBox(height: AppSpacing.xxs),
        child,
      ],
    );
  }
}

/// Left-aligned "+ Agregar parada intermedia" trigger.
class _AddStopRow extends StatelessWidget {
  const _AddStopRow({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xxs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset('assets/icons/plus.svg', width: 16, height: 16),
            const SizedBox(width: AppSpacing.xs),
            Text('Agregar parada intermedia', style: AppTypography.textAction),
          ],
        ),
      ),
    );
  }
}
