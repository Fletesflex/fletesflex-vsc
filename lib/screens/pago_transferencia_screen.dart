import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/offer.dart';
import '../routes.dart';
import '../theme/theme.dart';
import '../utils/format.dart';
import '../widgets/widgets.dart';
import 'comprobante_pago_screen.dart';
import 'resumen_pago_screen.dart';

/// Bank-transfer instructions + receipt upload, implemented from the Figma
/// "pago-transferencia" design (file o7nkeARTqRUSPsNBaYg2nb, node 33:4).
class PagoTransferenciaScreen extends StatefulWidget {
  const PagoTransferenciaScreen({super.key});

  @override
  State<PagoTransferenciaScreen> createState() =>
      _PagoTransferenciaScreenState();
}

class _PagoTransferenciaScreenState extends State<PagoTransferenciaScreen> {
  // TODO: load the platform's bank account from config/API.
  static const _alias = 'FLETESFLEX.PAGOS';
  static const _cbu = '0170001240000012345678';

  /// Name of the uploaded receipt; null until the user attaches one.
  String? _receipt;

  void _copy(String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Copiado: $value')));
  }

  void _pickReceipt() {
    // TODO: open the camera / file picker.
    setState(() => _receipt = 'comprobante_transferencia.pdf');
  }

  @override
  Widget build(BuildContext context) {
    final offer =
        ModalRoute.of(context)?.settings.arguments as Offer? ??
        SampleOffers.andres;

    return AppPage(
      header: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xs,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ShadowBackButton(),
            Text(
              'Paso 3 de 3',
              style: AppTypography.infoValue.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      elevatedBottom: true,
      bottom: PillButton(
        label: 'Ya transferí, enviar comprobante',
        onPressed: _receipt == null
            ? null
            : () => Navigator.of(context).pushReplacementNamed(
                AppRoutes.verificandoTransferencia,
                arguments: offer,
              ),
      ),
      children: [
        Text(
          'Pagá por transferencia',
          style: AppTypography.display.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          'Transferí el monto exacto y subí el comprobante para que lo '
          'verifiquemos.',
          style: AppTypography.body.copyWith(
            color: AppColors.textMuted,
            height: 1.4,
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Container(
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          decoration: BoxDecoration(
            color: AppColors.iconSurface,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatArs(transferPrice(offer.price)),
                style: AppTypography.priceAmount.copyWith(fontSize: 36),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Row(
                children: [
                  const DiscountPill(),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Precio con descuento por transferencia',
                      style: AppTypography.pickerValue.copyWith(
                        color: AppColors.successBright,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        AppCard(
          radius: AppRadius.xl,
          borderWidth: 0,
          borderColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Datos de la cuenta', style: AppTypography.userName),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 1,
                child: SvgPicture.asset(
                  'assets/icons/line_faint.svg',
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              _CopyField(
                label: 'Alias de cuenta',
                value: _alias,
                valueStyle: AppTypography.appBarTitle,
                onCopy: () => _copy(_alias),
              ),
              const SizedBox(height: AppSpacing.md),
              _CopyField(
                label: 'CBU',
                value: _cbu,
                valueStyle: AppTypography.infoValue,
                onCopy: () => _copy(_cbu),
              ),
              const SizedBox(height: AppSpacing.md),
              const _KeyValue('Banco', 'Banco Galicia'),
              const SizedBox(height: 10),
              const _KeyValue('Titular', 'FletesFlex S.R.L.'),
              const SizedBox(height: 10),
              const _KeyValue('CUIT', '30-71727374-9'),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        UploadDropZone(
          title: _receipt ?? 'Subí tu comprobante',
          subtitle: _receipt == null
              ? 'Foto, captura de pantalla o PDF'
              : 'Tocá para cambiarlo',
          onTap: _pickReceipt,
        ),
      ],
    );
  }
}

class _CopyField extends StatelessWidget {
  const _CopyField({
    required this.label,
    required this.value,
    required this.valueStyle,
    required this.onCopy,
  });

  final String label;
  final String value;
  final TextStyle valueStyle;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label.toUpperCase(), style: AppTypography.infoLabel),
              const SizedBox(height: 2),
              Text(value, style: valueStyle),
            ],
          ),
        ),
        Material(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(AppRadius.chip),
          child: InkWell(
            onTap: onCopy,
            borderRadius: BorderRadius.circular(AppRadius.chip),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xs),
              child: SvgPicture.asset(
                'assets/icons/copy.svg',
                width: 16,
                height: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _KeyValue extends StatelessWidget {
  const _KeyValue(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.routeText.copyWith(color: AppColors.textMuted),
        ),
        Text(value, style: AppTypography.pickerValue),
      ],
    );
  }
}
