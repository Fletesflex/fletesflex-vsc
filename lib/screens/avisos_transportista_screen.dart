import 'package:flutter/material.dart';

import '../models/notification.dart';
import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Carrier notifications screen, implemented from the Figma "avisos" /
/// "avisos-vacio" designs (file neRKyJz313WM7CEdoZdgGl, nodes 2053:2 and
/// 2053:108). Visual only: filters and "marcar todo como leído" only update
/// local state.
class AvisosTransportistaScreen extends StatefulWidget {
  const AvisosTransportistaScreen({super.key});

  @override
  State<AvisosTransportistaScreen> createState() =>
      _AvisosTransportistaScreenState();
}

class _AvisosTransportistaScreenState extends State<AvisosTransportistaScreen> {
  List<NotificationGroup> _groups = SampleNotifications.carrier;
  NotificationFilter _filter = NotificationFilter.all;

  void _markAllRead() {
    setState(() {
      _groups = [
        for (final group in _groups)
          NotificationGroup(
            label: group.label,
            items: [for (final item in group.items) item.markRead()],
          ),
      ];
    });
  }

  void _onTapNotification(AppNotification notification) {
    setState(() {
      _groups = [
        for (final group in _groups)
          NotificationGroup(
            label: group.label,
            items: [
              for (final item in group.items)
                identical(item, notification) ? item.markRead() : item,
            ],
          ),
      ];
    });

    final String? route;
    switch (notification.type) {
      case AppNotificationType.jobAssigned:
        route = AppRoutes.notificacionTransportista;
      case AppNotificationType.newMessage:
        route = AppRoutes.chat;
      case AppNotificationType.documentApproved:
      case AppNotificationType.documentRejected:
        route = AppRoutes.estadoDocumentacion;
      case AppNotificationType.ratingPrompt:
        route = AppRoutes.avisoCalificacionTransportista;
      case AppNotificationType.newOffer:
      case AppNotificationType.other:
        route = null;
    }
    if (route != null) Navigator.of(context).pushNamed(route);
  }

  List<NotificationGroup> get _visibleGroups {
    if (_filter == NotificationFilter.all) return _groups;
    return [
      for (final group in _groups)
        if (group.items.any((item) => item.unread))
          NotificationGroup(
            label: group.label,
            items: group.items.where((item) => item.unread).toList(),
          ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isEmpty = _groups.every((group) => group.items.isEmpty);

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const CarrierNavBar(current: CarrierTab.avisos),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.sectionGap),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Avisos', style: AppTypography.headline),
                  if (!isEmpty) MarkAllReadButton(onTap: _markAllRead),
                ],
              ),
            ),
            Expanded(
              child: isEmpty
                  ? const Center(child: AvisosEmptyState())
                  : ListView(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg,
                        AppSpacing.md,
                        AppSpacing.lg,
                        AppSpacing.lg,
                      ),
                      children: [
                        NotificationFilterBar(
                          selected: _filter,
                          onChanged: (filter) =>
                              setState(() => _filter = filter),
                        ),
                        const SizedBox(height: AppSpacing.sectionGap),
                        for (final (i, group) in _visibleGroups.indexed) ...[
                          if (i > 0)
                            const SizedBox(height: AppSpacing.sectionGap),
                          NotificationGroupLabel(group.label),
                          const SizedBox(height: 10),
                          NotificationListCard(
                            items: group.items,
                            onTapItem: _onTapNotification,
                          ),
                        ],
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
