import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Carrier payout-account form, implemented from the Figma "datos-de-cobro"
/// design (file neRKyJz313WM7CEdoZdgGl, node 2069:82), reusing the tokens in
/// `lib/theme/`. Visual only — no backend wiring yet.
class DatosCobroScreen extends StatefulWidget {
  const DatosCobroScreen({super.key});

  @override
  State<DatosCobroScreen> createState() => _DatosCobroScreenState();
}

class _DatosCobroScreenState extends State<DatosCobroScreen> {
  final _titular = TextEditingController(text: 'Martín Rodríguez');
  final _cuil = TextEditingController(text: '20-34567890-1');
  final _cbu = TextEditingController(text: 'martin.rodriguez.mp');

  @override
  void dispose() {
    _titular.dispose();
    _cuil.dispose();
    _cbu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: const AppPageHeader(
        title: 'Datos de cobro',
        subtitle: 'Acá te depositamos lo que ganás con cada servicio.',
      ),
      bottom: PrimaryButton(
        label: 'Guardar datos',
        // TODO: persist the updated payout data.
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      children: [
        Text('Titular de la cuenta', style: AppTypography.label),
        const SizedBox(height: AppSpacing.xxs),
        FormTextField(
          controller: _titular,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text('CUIL / CUIT', style: AppTypography.label),
        const SizedBox(height: AppSpacing.xxs),
        FormTextField(
          controller: _cuil,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text('CBU, CVU o alias', style: AppTypography.label),
        const SizedBox(height: AppSpacing.xxs),
        FormTextField(
          controller: _cbu,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.md,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'La cuenta tiene que estar a tu nombre.',
          style: AppTypography.fieldLabel,
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: AppColors.iconSurface,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/icons/lock.svg', width: 20, height: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'Tus datos bancarios se guardan de forma segura y solo se '
                  'usan para acreditar tus cobros.',
                  style: AppTypography.cardDescription.copyWith(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
