import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Editable personal-data form, implemented from the Figma "datos-personales"
/// design (file neRKyJz313WM7CEdoZdgGl, node 2064:2). Shared by both the
/// requester's and the carrier's "Mi perfil" screens. Visual only — no
/// backend wiring yet.
class DatosPersonalesScreen extends StatefulWidget {
  const DatosPersonalesScreen({super.key});

  @override
  State<DatosPersonalesScreen> createState() => _DatosPersonalesScreenState();
}

class _DatosPersonalesScreenState extends State<DatosPersonalesScreen> {
  final _nombre = TextEditingController(text: 'Mateo');
  final _apellido = TextEditingController(text: 'Silva');
  final _email = TextEditingController(text: 'mateo.silva@gmail.com');

  @override
  void dispose() {
    _nombre.dispose();
    _apellido.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: const AppPageHeader(title: 'Datos personales'),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Guardar cambios',
            onPressed: () {
              // TODO: persist the updated personal data.
            },
          ),
          const SizedBox(height: AppSpacing.sm),
          InkWell(
            onTap: () {
              // TODO: confirm and delete the account.
            },
            child: Text(
              'Eliminar mi cuenta',
              style: AppTypography.itemTitle.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.danger,
              ),
            ),
          ),
        ],
      ),
      children: [
        Center(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.iconSurface,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.accent, width: 3),
                    ),
                    child: Text(
                      'M',
                      style: AppTypography.headline.copyWith(fontSize: 40),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      onTap: () {
                        // TODO: open the photo picker.
                      },
                      customBorder: const CircleBorder(),
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.textPrimary,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.background,
                            width: 3,
                          ),
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/camera.svg',
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(
                            AppColors.surface,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              InkWell(
                onTap: () {
                  // TODO: open the photo picker.
                },
                child: Text(
                  'Cambiar foto',
                  style: AppTypography.itemTitle.copyWith(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _FieldLabel('Nombre'),
                  const SizedBox(height: AppSpacing.xxs),
                  FormTextField(
                    controller: _nombre,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.md,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _FieldLabel('Apellido'),
                  const SizedBox(height: AppSpacing.xxs),
                  FormTextField(
                    controller: _apellido,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.md,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _FieldLabel('Teléfono'),
            const SizedBox(height: AppSpacing.xxs),
            Container(
              height: 52,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: AppColors.segmentedTrack,
                border: Border.all(color: AppColors.border, width: 1.5),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '+54 9 11 5834 9281',
                      style: AppTypography.fieldValue.copyWith(
                        fontSize: 15,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  const VerifiedBadge(label: '✓ Verificado'),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Para cambiar tu número, vas a tener que verificar el nuevo '
              'por SMS.',
              style: AppTypography.fieldLabel,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _FieldLabel('Email (opcional)'),
            const SizedBox(height: AppSpacing.xxs),
            FormTextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Manrope Bold 13 / #121212 field label ("Nombre", "Teléfono"…), matching
/// the Figma spec exactly rather than the smaller, muted [FormTextField]
/// built-in label.
class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTypography.label);
  }
}
