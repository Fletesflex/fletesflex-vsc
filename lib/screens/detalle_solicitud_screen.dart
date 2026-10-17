import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/service_type.dart';
import '../routes.dart';
import '../theme/theme.dart';
import '../utils/format.dart';
import '../widgets/widgets.dart';

/// Carrier-side request detail, implemented from the Figma
/// "detalle-solicitud-transportista" design (file o7nkeARTqRUSPsNBaYg2nb,
/// node 2:736).
class DetalleSolicitudScreen extends StatelessWidget {
  const DetalleSolicitudScreen({super.key});

  // TODO: render the request passed as route argument; values mirror Figma.
  static const _photos = [
    'assets/images/photo_boxes.png',
    'assets/images/photo_fridge.png',
    'assets/images/photo_bed.png',
    'assets/images/photo_desk.png',
  ];
  static const _items = [
    'Heladera (70×60×170 cm)',
    'Sommier 2 plazas (140×190 cm)',
    'Escritorio (120×60×75 cm)',
    '4 cajas medianas (40×40×40 cm)',
  ];

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Detalle de solicitud',
      topBarStyle: TopBarStyle.centered,
      trailing: const ServiceBadge(ServiceType.mudanza, pill: true),
      elevatedBottom: true,
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xs,
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
              onPressed: () => Navigator.of(context).pushNamed(
                AppRoutes.confirmarSolicitud,
              ),
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
        const _RouteMap(),
        const SizedBox(height: AppSpacing.sectionGap),
        _DetailCard(
          title: 'Recorrido y Direcciones',
          child: Column(
            children: [
              const RouteTimelineStop(
                letter: 'A',
                caption: 'Origen',
                address: 'Av. Santa Fe 2345, Piso 4 B',
                meta: 'Palermo • Departamento',
                tag: RequirementTag(
                  iconAsset: 'assets/icons/elevator.svg',
                  label: 'Ascensor: Sí',
                  iconSize: 12,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const RouteTimelineStop(
                letter: 'C',
                caption: 'Parada intermedia',
                address: 'Av. Corrientes 5100',
                meta: 'Villa Crespo • Casa (Planta baja)',
              ),
              const SizedBox(height: AppSpacing.md),
              RouteTimelineStop(
                letter: 'B',
                caption: 'Destino',
                address: 'Cabildo 1820, Piso 2 A',
                meta: 'Belgrano • Departamento',
                isLast: true,
                markerColor: AppColors.successSurface,
                markerTextColor: AppColors.success,
                tag: const RequirementTag(
                  iconAsset: 'assets/icons/stairs.svg',
                  label: 'Ascensor: No (Escaleras)',
                  iconSize: 12,
                  color: AppColors.warningSurface,
                  textColor: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        _DetailCard(
          title: 'Objetos a trasladar',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: AppSpacing.xs,
                crossAxisSpacing: AppSpacing.xs,
                childAspectRatio: 168 / 110,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (final photo in _photos)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.sm),
                      child: Image.asset(photo, fit: BoxFit.cover),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              for (final (i, item) in _items.indexed) ...[
                if (i > 0) const SizedBox(height: 10),
                BulletText(item),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        const _DetailCard(
          title: 'Necesidades especiales',
          spacing: 14,
          child: Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              FeatureChip(
                iconAsset: 'assets/icons/users.svg',
                label: '2 Ayudantes',
              ),
              FeatureChip(
                iconAsset: 'assets/icons/trending_up.svg',
                label: 'Escalera',
              ),
              FeatureChip(
                iconAsset: 'assets/icons/anchor_muted.svg',
                label: 'Sogas balcón',
                enabled: false,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        const _DetailCard(
          title: 'Programación',
          spacing: 14,
          child: Row(
            children: [
              Expanded(
                child: _ScheduleItem(
                  iconAsset: 'assets/icons/calendar.svg',
                  label: 'Fecha',
                  value: 'Sábado 12 de Oct.',
                ),
              ),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: _ScheduleItem(
                  iconAsset: 'assets/icons/clock.svg',
                  label: 'Franja horaria',
                  value: '09:00 - 12:00 hs',
                ),
              ),
            ],
          ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/info.svg',
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Precio de referencia',
                    style: AppTypography.priceCaption,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Center(
                child: Text(
                  formatArs(45000),
                  style: AppTypography.priceAmount.copyWith(fontSize: 28),
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Sugerido según distancia (4.2 km), volumen de carga y peones '
                'solicitados.',
                style: AppTypography.helper,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// White card with a 16px Rubik title and body below.
class _DetailCard extends StatelessWidget {
  const _DetailCard({
    required this.title,
    required this.child,
    this.spacing = AppSpacing.md,
  });

  final String title;
  final Widget child;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      shadow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title, style: AppTypography.userName),
          SizedBox(height: spacing),
          child,
        ],
      ),
    );
  }
}

/// Static route preview with labelled A / C / B pins.
class _RouteMap extends StatelessWidget {
  const _RouteMap();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border, width: 1.5),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      // TODO: replace the static image with a live map.
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Pin positions are relative to the 354px-wide design frame.
          final scale = constraints.maxWidth / 354;
          Widget pin(double left, double top, String letter, Color color,
                  Color textColor, String label) =>
              Positioned(
                left: left * scale,
                top: top,
                child: MapPin(
                  letter: letter,
                  color: color,
                  textColor: textColor,
                  label: label,
                ),
              );

          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset('assets/images/map_route.png', fit: BoxFit.cover),
              ColoredBox(color: AppColors.background.withValues(alpha: 0.1)),
              pin(48.5, 118.5, 'A', AppColors.textPrimary, AppColors.accent,
                  'Palermo'),
              pin(178.5, 78.5, 'C', AppColors.accentDeep, AppColors.surface,
                  'V. Crespo'),
              pin(308.5, 28.5, 'B', AppColors.success, AppColors.surface,
                  'Belgrano'),
            ],
          );
        },
      ),
    );
  }
}

/// 28px round map marker with a small dark label underneath.
class MapPin extends StatelessWidget {
  const MapPin({
    super.key,
    required this.letter,
    required this.color,
    required this.textColor,
    required this.label,
  });

  final String letter;
  final Color color;
  final Color textColor;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Color(0x21000000),
                offset: Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Text(
            letter,
            style: AppTypography.marker.copyWith(color: textColor),
          ),
        ),
        const SizedBox(height: AppSpacing.xxs),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.textPrimary.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            label,
            style: AppTypography.navLabel.copyWith(
              color: AppColors.surface,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

/// One stop in a vertical route timeline: marker + connector on the left,
/// caption / address / meta (+ optional tag) on the right.
class RouteTimelineStop extends StatelessWidget {
  const RouteTimelineStop({
    super.key,
    required this.letter,
    required this.caption,
    required this.address,
    required this.meta,
    this.tag,
    this.isLast = false,
    this.markerColor,
    this.markerTextColor,
  });

  final String letter;
  final String caption;
  final String address;
  final String meta;
  final Widget? tag;
  final bool isLast;
  final Color? markerColor;
  final Color? markerTextColor;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            child: Column(
              children: [
                markerColor == null
                    ? RouteMarker(letter)
                    : Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: markerColor,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          letter,
                          style: AppTypography.marker.copyWith(
                            color: markerTextColor,
                          ),
                        ),
                      ),
                if (!isLast) ...[
                  const SizedBox(height: AppSpacing.xxs),
                  Expanded(
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Image.asset(
                        'assets/images/timeline_line.png',
                        height: 2,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(caption.toUpperCase(), style: AppTypography.caps),
                const SizedBox(height: AppSpacing.xxs),
                Text(address, style: AppTypography.addressTitle),
                const SizedBox(height: AppSpacing.xxs),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xxs,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(meta, style: AppTypography.routeText),
                    ?tag,
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 6px dark dot + text.
class BulletText extends StatelessWidget {
  const BulletText(this.text, {super.key, this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: AppColors.textPrimary,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(child: Text(text, style: style ?? AppTypography.fieldValue)),
      ],
    );
  }
}

class _ScheduleItem extends StatelessWidget {
  const _ScheduleItem({
    required this.iconAsset,
    required this.label,
    required this.value,
  });

  final String iconAsset;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.border,
            borderRadius: BorderRadius.circular(10),
          ),
          child: SvgPicture.asset(iconAsset, width: 18, height: 18),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: AppTypography.micro.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppTypography.buttonSmall,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
