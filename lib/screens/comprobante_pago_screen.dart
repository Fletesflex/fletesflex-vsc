import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/offer.dart';
import '../theme/theme.dart';
import '../utils/format.dart';
import '../widgets/widgets.dart';

/// Payment receipt, implemented from the Figma "comprobante-pago" design
/// (file o7nkeARTqRUSPsNBaYg2nb, node 30:525).
class ComprobantePagoScreen extends StatelessWidget {
  const ComprobantePagoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final offer = ModalRoute.of(context)?.settings.arguments as Offer? ??
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
          children: [
            const ShadowBackButton(),
            Expanded(
              child: Text(
                'Fletes Flex',
                style: AppTypography.greetingTitle,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.md,
      ),
      bottom: Row(
        children: [
          Expanded(
            child: _OutlineAction(
              iconAsset: 'assets/icons/download.svg',
              label: 'Descargar PDF',
              onTap: () {
                // TODO: generate and download the PDF receipt.
              },
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _OutlineAction(
              iconAsset: 'assets/icons/share.svg',
              label: 'Compartir',
              onTap: () {
                // TODO: share the receipt.
              },
            ),
          ),
        ],
      ),
      children: [
        Text(
          'Comprobante de Pago',
          style: AppTypography.headline.copyWith(height: 1.2),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(
          'Recibo oficial • Nro. #FLX-2024-08471',
          style: AppTypography.itemTitle.copyWith(
            color: AppColors.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppCard(
          borderWidth: 0,
          borderColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Detalles del flete', style: AppTypography.userName),
              const SizedBox(height: 14),
              const AppDivider(thin: true),
              const SizedBox(height: 14),
              // TODO: fill from the paid request.
              const _ReceiptRow(
                iconAsset: 'assets/icons/icon_bg_box.svg',
                label: 'Servicio',
                child: _ReceiptValue('Mudanza chica'),
              ),
              const SizedBox(height: 14),
              _ReceiptRow(
                iconAsset: 'assets/icons/icon_bg_driver.svg',
                label: 'Transportista asignado',
                child: Row(
                  children: [
                    AppAvatar(offer.carrier.avatarAsset, size: 22),
                    const SizedBox(width: AppSpacing.xs),
                    _ReceiptValue(offer.carrier.name),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const _ReceiptRow(
                iconAsset: 'assets/icons/icon_bg_calendar.svg',
                label: 'Fecha y Hora',
                child: _ReceiptValue('Sáb 12 Oct, 2024 • 10:00–13:00'),
              ),
              const SizedBox(height: 14),
              _ReceiptRow(
                iconAsset: 'assets/icons/icon_bg_pin.svg',
                label: 'Origen',
                alignTop: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Av. Santa Fe 3200, Palermo',
                      style: AppTypography.checkLabel.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    Image.asset(
                      'assets/images/line_dashed.png',
                      height: 1,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(height: 6),
                    Text('DESTINO', style: AppTypography.infoLabel),
                    const SizedBox(height: 1),
                    Text(
                      'Cabildo 1500, Belgrano',
                      style: AppTypography.checkLabel.copyWith(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        AppCard(
          borderWidth: 0,
          borderColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Servicio de mudanza',
                    style: AppTypography.body.copyWith(
                      color: AppColors.textMuted,
                      height: 1,
                    ),
                  ),
                  Text(
                    formatArs(offer.price),
                    style: AppTypography.appBarTitle,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              const AppDivider(thin: true),
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total pagado', style: AppTypography.appBarTitle),
                  Text(
                    formatArs(offer.price),
                    style: AppTypography.priceAmount.copyWith(fontSize: 28),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.successBrightSurface,
                    border: Border.all(color: AppColors.successBright),
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/dot_success.svg',
                        width: 6,
                        height: 6,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Liberado al transportista',
                        style: AppTypography.buttonSmall.copyWith(
                          fontSize: 13,
                          color: AppColors.successBright,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.iconSurface,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/credit_card_md.svg',
                width: 18,
                height: 18,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pagado con Mercado Pago',
                      style: AppTypography.featureLabel,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      'Tarjeta Visa terminada en 4242',
                      style: AppTypography.itemSubtitle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 40px white circle with a soft drop shadow and a back arrow.
class ShadowBackButton extends StatelessWidget {
  const ShadowBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? () => Navigator.of(context).maybePop(),
      customBorder: const CircleBorder(),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surface,
          shape: BoxShape.circle,
          boxShadow: AppShadows.elevated,
        ),
        child: SvgPicture.asset(
          'assets/icons/arrow_left_md.svg',
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}

class _ReceiptRow extends StatelessWidget {
  const _ReceiptRow({
    required this.iconAsset,
    required this.label,
    required this.child,
    this.alignTop = false,
  });

  final String iconAsset;
  final String label;
  final Widget child;
  final bool alignTop;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          alignTop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(iconAsset, width: 32, height: 32),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label.toUpperCase(), style: AppTypography.infoLabel),
              const SizedBox(height: 2),
              child,
            ],
          ),
        ),
      ],
    );
  }
}

class _ReceiptValue extends StatelessWidget {
  const _ReceiptValue(this.text);

  final String text;

  @override
  Widget build(BuildContext context) =>
      Text(text, style: AppTypography.infoValue);
}

class _OutlineAction extends StatelessWidget {
  const _OutlineAction({
    required this.iconAsset,
    required this.label,
    required this.onTap,
  });

  final String iconAsset;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      shape: const StadiumBorder(
        side: BorderSide(color: AppColors.accent, width: 1.5),
      ),
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: SizedBox(
          height: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(iconAsset, width: 16, height: 16),
              const SizedBox(width: AppSpacing.xs),
              Text(
                label,
                style: AppTypography.buttonSmall.copyWith(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
