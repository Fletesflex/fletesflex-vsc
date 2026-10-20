import 'package:flutter/material.dart';

import '../models/notification.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Requester notifications screen, implemented from the Figma
/// "avisos-solicitante" design (file neRKyJz313WM7CEdoZdgGl, node 2057:7).
/// Visual only: filters and "marcar todo como leído" only update local
/// state. Shares [AvisosEmptyState] with the carrier screen for the
/// no-notifications case.
class AvisosSolicitanteScreen extends StatefulWidget {
  const AvisosSolicitanteScreen({super.key});

  @override
  State<AvisosSolicitanteScreen> createState() =>
      _AvisosSolicitanteScreenState();
}

class _AvisosSolicitanteScreenState extends State<AvisosSolicitanteScreen> {
  List<NotificationGroup> _groups = SampleNotifications.requester;
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
      bottomNavigationBar: const RequesterNavBar(current: RequesterTab.avisos),
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
                          NotificationListCard(items: group.items),
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
