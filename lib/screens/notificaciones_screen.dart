import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// A single notification-category toggle.
class _NotificationSetting {
  _NotificationSetting(this.iconAsset, this.title, this.subtitle, this.value);

  final String iconAsset;
  final String title;
  final String subtitle;
  bool value;
}

/// Notification preferences, implemented from the Figma
/// "ajustes-notificaciones" design (file neRKyJz313WM7CEdoZdgGl, node
/// 2069:196), reusing the tokens in `lib/theme/` and [AppToggle]. Shared by
/// both the requester's and the carrier's "Mi perfil". Visual only — the
/// switches toggle locally but nothing is persisted yet.
class NotificacionesScreen extends StatefulWidget {
  const NotificacionesScreen({super.key});

  @override
  State<NotificacionesScreen> createState() => _NotificacionesScreenState();
}

class _NotificacionesScreenState extends State<NotificacionesScreen> {
  final _settings = [
    _NotificationSetting(
      'assets/icons/nav_tag.svg',
      'Ofertas y asignaciones',
      'Cuando recibís una oferta o te eligen para un trabajo.',
      true,
    ),
    _NotificationSetting(
      'assets/icons/message_circle.svg',
      'Mensajes del chat',
      'Cuando alguien te escribe sobre un servicio.',
      true,
    ),
    _NotificationSetting(
      'assets/icons/credit_card.svg',
      'Pagos y cobros',
      'Pagos acreditados, comprobantes y cobros.',
      true,
    ),
    _NotificationSetting(
      'assets/icons/calendar.svg',
      'Recordatorios del servicio',
      'Un aviso antes de la hora acordada.',
      true,
    ),
    _NotificationSetting(
      'assets/icons/nav_bell.svg',
      'Novedades y promociones',
      'Beneficios y novedades de FletesFlex.',
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: const AppPageHeader(
        title: 'Notificaciones',
        subtitle: 'Elegí qué avisos querés recibir.',
      ),
      children: [
        AppCard(
          padding: EdgeInsets.zero,
          radius: AppRadius.xl,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.xl),
            child: Column(
              children: [
                for (final (i, setting) in _settings.indexed) ...[
                  if (i > 0) const AppDivider(thin: true),
                  _NotificationRow(
                    setting: setting,
                    onChanged: (v) => setState(() => setting.value = v),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Los avisos importantes sobre tu cuenta y tus servicios siempre '
          'te van a llegar.',
          style: AppTypography.itemSubtitle.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _NotificationRow extends StatelessWidget {
  const _NotificationRow({required this.setting, required this.onChanged});

  final _NotificationSetting setting;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 14,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.iconSurface,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: SvgPicture.asset(
              setting.iconAsset,
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(
                AppColors.textPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  setting.title,
                  style: AppTypography.cardTitle.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  setting.subtitle,
                  style: AppTypography.cardDescription.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          AppToggle(value: setting.value, onChanged: onChanged),
        ],
      ),
    );
  }
}
