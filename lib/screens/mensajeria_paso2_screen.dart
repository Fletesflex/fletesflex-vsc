import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// What kind of package the sender is shipping.
enum _PackageType { documentos, cajaChica, bolsaMochila, otro }

/// Step 2 of the "Mensajería" request form (package details), implemented
/// from the Figma "mensajeria-paso-2-paquete" design (file
/// neRKyJz313WM7CEdoZdgGl, node 42:86), reusing the tokens in `lib/theme/`.
class MensajeriaPaso2Screen extends StatefulWidget {
  const MensajeriaPaso2Screen({super.key});

  @override
  State<MensajeriaPaso2Screen> createState() => _MensajeriaPaso2ScreenState();
}

class _MensajeriaPaso2ScreenState extends State<MensajeriaPaso2Screen> {
  final _instructions = TextEditingController();
  var _packageType = _PackageType.cajaChica;
  var _weightKg = 5.0;

  @override
  void dispose() {
    _instructions.dispose();
    super.dispose();
  }

  void _handlePhoto() {
    // TODO: open the camera/gallery picker for the package photo.
  }

  void _handleNext() {
    // TODO: validate the package details before continuing.
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Nueva mensajería',
      topBarStyle: TopBarStyle.centered,
      children: [
        const StepIndicator(
          current: 1,
          total: 3,
          style: StepIndicatorStyle.bars,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text('Paso 2: Tu envío', style: AppTypography.textAction),
        const SizedBox(height: AppSpacing.sectionGap),
        Text('¿Qué vas a enviar?', style: AppTypography.headline),
        const SizedBox(height: AppSpacing.sectionGap),
        Row(
          children: [
            Expanded(
              child: _PackageTypeCard(
                iconAsset: 'assets/icons/mail.svg',
                label: 'Documentos / sobre',
                selected: _packageType == _PackageType.documentos,
                onTap: () =>
                    setState(() => _packageType = _PackageType.documentos),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _PackageTypeCard(
                iconAsset: 'assets/icons/box.svg',
                label: 'Caja chica',
                selected: _packageType == _PackageType.cajaChica,
                onTap: () =>
                    setState(() => _packageType = _PackageType.cajaChica),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: _PackageTypeCard(
                iconAsset: 'assets/icons/backpack.svg',
                label: 'Bolsa / mochila',
                selected: _packageType == _PackageType.bolsaMochila,
                onTap: () =>
                    setState(() => _packageType = _PackageType.bolsaMochila),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _PackageTypeCard(
                iconAsset: 'assets/icons/circle_question_mark.svg',
                label: 'Otro',
                selected: _packageType == _PackageType.otro,
                onTap: () => setState(() => _packageType = _PackageType.otro),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Peso aproximado', style: AppTypography.cardHeading),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: AppSpacing.xxs,
              ),
              decoration: BoxDecoration(
                color: AppColors.iconSurface,
                borderRadius: BorderRadius.circular(AppRadius.chip),
              ),
              child: Text(
                '~${_weightKg.round()} kg',
                style: AppTypography.chipSelected,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        _WeightSlider(
          value: _weightKg,
          onChanged: (value) => setState(() => _weightKg = value),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Text(
          'SACALE UNA FOTO AL PAQUETE (OPCIONAL)',
          style: AppTypography.caps,
        ),
        const SizedBox(height: AppSpacing.xs),
        UploadDropZone(
          title: 'Subir o tomar foto',
          titleStyle: AppTypography.textAction,
          iconAsset: 'assets/icons/camera_dark.svg',
          iconSize: 24,
          borderColor: AppColors.accent,
          padding: const EdgeInsets.all(AppSpacing.lg),
          onTap: _handlePhoto,
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Text('INSTRUCCIONES ESPECIALES (OPCIONAL)', style: AppTypography.caps),
        const SizedBox(height: AppSpacing.xs),
        FormTextField(
          controller: _instructions,
          hintText: 'Ej: Frágil, entregar en mano',
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.buttonVertical,
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        PillButton(label: 'Siguiente', onPressed: _handleNext),
      ],
    );
  }
}

/// One of the four package-type options ("Documentos / sobre", "Caja
/// chica", "Bolsa / mochila", "Otro"); the selected one gets an accent
/// border and elevated shadow.
class _PackageTypeCard extends StatelessWidget {
  const _PackageTypeCard({
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
      borderRadius: BorderRadius.circular(AppRadius.xl),
      child: Container(
        height: 110,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.border,
            width: selected ? 2 : 1.5,
          ),
          boxShadow: selected ? AppShadows.elevated : AppShadows.soft,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected ? AppColors.iconSurface : AppColors.border,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                iconAsset,
                width: 18,
                height: 18,
                colorFilter: ColorFilter.mode(
                  selected ? AppColors.textPrimary : AppColors.iconMuted,
                  BlendMode.srcIn,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              label,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: selected
                  ? AppTypography.chipSelected
                  : AppTypography.itemTitle,
            ),
          ],
        ),
      ),
    );
  }
}

/// Bordered card with a slider from 1 to 30 kg and a black dot thumb.
class _WeightSlider extends StatelessWidget {
  const _WeightSlider({required this.value, required this.onChanged});

  final double value;
  final ValueChanged<double> onChanged;

  static const double _min = 1;
  static const double _max = 30;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      shadow: false,
      radius: AppRadius.md,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 6,
              activeTrackColor: AppColors.accent,
              inactiveTrackColor: AppColors.border,
              thumbShape: const _WeightThumbShape(),
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: Slider(
              value: value.clamp(_min, _max),
              min: _min,
              max: _max,
              onChanged: onChanged,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('1 kg', style: _rangeLabelStyle),
              Text('30 kg', style: _rangeLabelStyle),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle get _rangeLabelStyle => AppTypography.itemSubtitle.copyWith(
    fontWeight: FontWeight.w600,
    color: AppColors.iconMuted,
  );
}

/// Solid dark circle with a white ring and a soft drop shadow, matching the
/// Figma thumb for [_WeightSlider].
class _WeightThumbShape extends SliderComponentShape {
  const _WeightThumbShape();

  static const double _radius = 12;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) =>
      const Size.fromRadius(_radius);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final canvas = context.canvas;
    canvas.drawCircle(
      center + const Offset(0, 4),
      _radius,
      Paint()
        ..color = AppColors.textPrimary.withValues(alpha: 0.15)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
    canvas.drawCircle(center, _radius, Paint()..color = AppColors.textPrimary);
    canvas.drawCircle(
      center,
      _radius - 1.5,
      Paint()
        ..color = AppColors.surface
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }
}
