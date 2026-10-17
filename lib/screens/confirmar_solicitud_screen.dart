import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/service_type.dart';
import '../routes.dart';
import '../theme/theme.dart';
import '../utils/format.dart';
import '../widgets/widgets.dart';

/// Carrier-side: take a fixed-price request after confirming requirements,
/// implemented from the Figma "confirmar-solicitud-precio-fijo" design
/// (file o7nkeARTqRUSPsNBaYg2nb, node 25:5).
class ConfirmarSolicitudScreen extends StatefulWidget {
  const ConfirmarSolicitudScreen({super.key});

  @override
  State<ConfirmarSolicitudScreen> createState() =>
      _ConfirmarSolicitudScreenState();
}

class _ConfirmarSolicitudScreenState extends State<ConfirmarSolicitudScreen> {
  // TODO: derive requirements and price from the request.
  static const _price = 45000;
  static const _slots = ['8:00', '8:30', '9:00', '9:30'];

  final _requirements = {
    'Confirmo que cuento con 2 ayudantes para esta mudanza': true,
    'Dispongo de escalera o rampa para subida/bajada': true,
    'Mi vehículo tiene capacidad para 2 ambientes': false,
  };
  String _slot = '8:30';

  bool get _allChecked => _requirements.values.every((v) => v);

  void _handleTake() {
    Navigator.of(context).pushNamed(AppRoutes.confirmacionOfertaEnviada);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Confirmar solicitud',
      topBarStyle: TopBarStyle.centered,
      elevatedBottom: true,
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 52,
            child: PrimaryButton(
              label: 'Tomar solicitud',
              onPressed: _allChecked ? _handleTake : null,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'El solicitante verá tu perfil junto a otros interesados y '
            'elegirá a quién asignarle el trabajo.',
            style: AppTypography.micro.copyWith(height: 1.4),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      children: [
        const RequestSummaryCard(
          type: ServiceType.mudanza,
          reference: '#9482',
          route: 'Palermo → Belgrano',
          schedule: 'Sábado 14 de septiembre · 09:00 hs',
          detail: '2 ambientes — Depto con escalera (3er piso)',
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Container(
          padding: const EdgeInsets.all(AppSpacing.sectionGap),
          decoration: BoxDecoration(
            color: AppColors.iconSurface,
            border: Border.all(color: AppColors.accent, width: 1.5),
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/icons/info.svg',
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Precio fijo de la plataforma',
                    style: AppTypography.priceCaption,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                formatArs(_price),
                style: AppTypography.priceAmount.copyWith(fontSize: 36),
              ),
              const SizedBox(height: 10),
              Text(
                'Este precio fue calculado por la plataforma y no es '
                'negociable.',
                style: AppTypography.helper.copyWith(height: 1.4),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Text(
          'Confirmá que cumplís estos requisitos',
          style: AppTypography.groupTitle,
        ),
        const SizedBox(height: 10),
        for (final (i, entry) in _requirements.entries.indexed) ...[
          if (i > 0) const SizedBox(height: 10),
          CheckTile(
            label: entry.key,
            value: entry.value,
            onChanged: (v) => setState(() => _requirements[entry.key] = v),
          ),
        ],
        const SizedBox(height: AppSpacing.sectionGap),
        Text('Horario estimado de llegada', style: AppTypography.groupTitle),
        const SizedBox(height: 10),
        SlotPicker(
          options: _slots,
          selected: _slot,
          onChanged: (v) => setState(() => _slot = v),
        ),
        const SizedBox(height: 10),
        Text(
          'Elegí el horario más cercano a tu disponibilidad',
          style: AppTypography.itemSubtitle,
        ),
      ],
    );
  }
}
