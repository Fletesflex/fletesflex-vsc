import 'package:flutter/material.dart';

import '../theme/theme.dart';

/// A single notification card shown on the Avisos screens.
class AppNotification {
  const AppNotification({
    required this.iconAsset,
    required this.iconBackground,
    required this.title,
    required this.body,
    required this.time,
    this.unread = false,
  });

  final String iconAsset;
  final Color iconBackground;
  final String title;
  final String body;
  final String time;
  final bool unread;

  AppNotification markRead() => unread ? AppNotification(
        iconAsset: iconAsset,
        iconBackground: iconBackground,
        title: title,
        body: body,
        time: time,
      ) : this;
}

/// A day-grouped section of [AppNotification]s (e.g. "HOY", "AYER").
class NotificationGroup {
  const NotificationGroup({required this.label, required this.items});

  final String label;
  final List<AppNotification> items;
}

/// Sample data mirroring the Figma mockups until the API is wired up.
abstract final class SampleNotifications {
  static const carrier = [
    NotificationGroup(
      label: 'HOY',
      items: [
        AppNotification(
          iconAsset: 'assets/icons/notif_truck.svg',
          iconBackground: AppColors.iconSurface,
          title: '¡Te asignaron el trabajo!',
          body: 'Lucía R. te eligió para la mudanza Palermo → Belgrano.',
          time: 'Hace 5 min',
          unread: true,
        ),
        AppNotification(
          iconAsset: 'assets/icons/notif_msg.svg',
          iconBackground: AppColors.iconSurfaceNeutral,
          title: 'Nuevo mensaje de Lucía R.',
          body: 'Hola, ¿podés llegar 10 minutos antes?',
          time: 'Hace 20 min',
          unread: true,
        ),
        AppNotification(
          iconAsset: 'assets/icons/notif_shield.svg',
          iconBackground: AppColors.successSurface,
          title: 'Documento aprobado',
          body: 'Tu seguro del vehículo fue aprobado.',
          time: '09:12',
        ),
      ],
    ),
    NotificationGroup(
      label: 'AYER',
      items: [
        AppNotification(
          iconAsset: 'assets/icons/notif_alert.svg',
          iconBackground: AppColors.dangerSurface,
          title: 'Documento rechazado',
          body: 'La VTV que subiste está vencida. Subí una vigente.',
          time: 'Ayer, 18:40',
        ),
        AppNotification(
          iconAsset: 'assets/icons/notif_star.svg',
          iconBackground: AppColors.iconSurface,
          title: 'Calificá tu último servicio',
          body: 'Contanos cómo fue el flete Caballito → Avellaneda.',
          time: 'Ayer, 14:05',
        ),
      ],
    ),
  ];

  static const requester = [
    NotificationGroup(
      label: 'HOY',
      items: [
        AppNotification(
          iconAsset: 'assets/icons/notif_tag.svg',
          iconBackground: AppColors.iconSurface,
          title: 'Nueva oferta recibida',
          body: 'Carlos M. ofertó \$48.000 para tu mudanza Palermo → '
              'Belgrano.',
          time: 'Hace 5 min',
          unread: true,
        ),
        AppNotification(
          iconAsset: 'assets/icons/notif_msg.svg',
          iconBackground: AppColors.iconSurfaceNeutral,
          title: 'Nuevo mensaje de Carlos M.',
          body: 'Perfecto, nos vemos a las 9.',
          time: 'Hace 20 min',
          unread: true,
        ),
        AppNotification(
          iconAsset: 'assets/icons/notif_check_circle.svg',
          iconBackground: AppColors.successSurface,
          title: 'Tu servicio fue confirmado',
          body: 'Jorge R. confirmó el flete Caballito → Villa Urquiza.',
          time: '09:12',
        ),
      ],
    ),
    NotificationGroup(
      label: 'AYER',
      items: [
        AppNotification(
          iconAsset: 'assets/icons/notif_clock.svg',
          iconBackground: AppColors.iconSurface,
          title: 'Tu pedido no recibió ofertas',
          body: 'Mensajería Retiro → San Telmo. Podés volver a publicarla.',
          time: 'Ayer, 18:40',
        ),
        AppNotification(
          iconAsset: 'assets/icons/notif_star.svg',
          iconBackground: AppColors.iconSurface,
          title: 'Calificá a Jorge R.',
          body: 'Contanos cómo fue el flete Caballito → Avellaneda.',
          time: 'Ayer, 14:05',
        ),
      ],
    ),
  ];
}
