import 'package:flutter/material.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Which account state "Mi perfil" simulates. Swap this constant to preview
/// each Figma state — there's no backend yet to derive it from.
enum ProfileDemoState {
  /// Requester only: shows the "Sumate como transportista" upsell card.
  soloSolicitante,

  /// Requester who submitted carrier verification: shows the "Verificación
  /// en revisión" status card instead of the upsell.
  verificacionEnRevision,

  /// Both roles active: shows the "Solicitante | Transportista" mode
  /// selector on both profile screens instead of either card above.
  dobleRol,
}

const ProfileDemoState _demoState = ProfileDemoState.soloSolicitante;

/// Requester's own profile ("Mi perfil"), implemented from the Figma
/// "perfil-solicitante" / "perfil-solicitante-verificacion-en-revision" /
/// "perfil-solicitante-doble-rol" designs (file neRKyJz313WM7CEdoZdgGl,
/// nodes 2054:149, 2057:297, 2057:150). Visual only — [_demoState] simulates
/// which account state is shown.
class PerfilSolicitanteScreen extends StatelessWidget {
  const PerfilSolicitanteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dobleRol = _demoState == ProfileDemoState.dobleRol;
    final pending = _demoState == ProfileDemoState.verificacionEnRevision;

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const RequesterNavBar(current: RequesterTab.perfil),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.sectionGap),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text('Mi perfil', style: AppTypography.headline),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.lg,
                ),
                children: [
                  const ProfileHeroCard(
                    initial: 'M',
                    name: 'Mateo Silva',
                    roleLabel: 'Solicitante',
                    servicesCount: 12,
                    rating: 4.9,
                  ),
                  const SizedBox(height: 14),
                  if (dobleRol)
                    const ProfileModeSelector(current: ProfileMode.solicitante)
                  else if (pending)
                    const CarrierUpsellCard.pending()
                  else
                    CarrierUpsellCard(
                      onTap: () =>
                          Navigator.of(context)
                              .pushNamed(AppRoutes.verificacionIntro),
                    ),
                  const SizedBox(height: 14),
                  const ProfileSectionLabel('CUENTA'),
                  const SizedBox(height: AppSpacing.xs),
                  ProfileMenuCard(
                    rows: [
                      ProfileMenuRow(
                        iconAsset: 'assets/icons/user_sm.svg',
                        label: 'Datos personales',
                        onTap: () {
                          // TODO: open the personal-data editor.
                        },
                      ),
                      ProfileMenuRow(
                        iconAsset: 'assets/icons/history.svg',
                        label: 'Mis servicios',
                        onTap: () =>
                            Navigator.of(context)
                                .pushNamed(AppRoutes.historialSolicitante),
                      ),
                      ProfileMenuRow(
                        iconAsset: 'assets/icons/star_section.svg',
                        label: 'Mis calificaciones',
                        onTap: () =>
                            Navigator.of(context)
                                .pushNamed(AppRoutes.perfilCalificaciones),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const ProfileSectionLabel('AYUDA'),
                  const SizedBox(height: AppSpacing.xs),
                  ProfileMenuCard(
                    rows: [
                      ProfileMenuRow(
                        iconAsset: 'assets/icons/circle_question_mark.svg',
                        label: 'Ayuda y soporte',
                        onTap: () {
                          // TODO: open help & support.
                        },
                      ),
                      ProfileMenuRow(
                        iconAsset: 'assets/icons/lock.svg',
                        label: 'Términos y privacidad',
                        onTap: () {
                          // TODO: open terms & privacy.
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ProfileLogoutButton(
                    onTap: () {
                      // TODO: sign the user out.
                      Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil(AppRoutes.login, (_) => false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Carrier's own profile ("Mi perfil"), implemented from the Figma
/// "perfil-transportista" / "perfil-transportista-doble-rol" designs (file
/// neRKyJz313WM7CEdoZdgGl, nodes 2054:2, 2057:438). Visual only —
/// [_demoState] simulates which account state is shown; the mode selector
/// only appears once both roles are active.
class MiPerfilTransportistaScreen extends StatelessWidget {
  const MiPerfilTransportistaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dobleRol = _demoState == ProfileDemoState.dobleRol;

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const CarrierNavBar(current: CarrierTab.perfil),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: AppSpacing.sectionGap),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Text('Mi perfil', style: AppTypography.headline),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.lg,
                ),
                children: [
                  const ProfileHeroCard(
                    initial: 'M',
                    name: 'Martín R.',
                    roleLabel: 'Transportista',
                    servicesCount: 126,
                    rating: 4.8,
                    verified: true,
                  ),
                  if (dobleRol) ...[
                    const SizedBox(height: 14),
                    const ProfileModeSelector(
                      current: ProfileMode.transportista,
                    ),
                  ],
                  const SizedBox(height: 14),
                  const ProfileSectionLabel('CUENTA'),
                  const SizedBox(height: AppSpacing.xs),
                  ProfileMenuCard(
                    rows: [
                      ProfileMenuRow(
                        iconAsset: 'assets/icons/user_sm.svg',
                        label: 'Datos personales',
                        onTap: () {
                          // TODO: open the personal-data editor.
                        },
                      ),
                      ProfileMenuRow(
                        iconAsset: 'assets/icons/truck_sm.svg',
                        label: 'Mi vehículo',
                        onTap: () =>
                            Navigator.of(context)
                                .pushNamed(AppRoutes.datosVehiculo),
                      ),
                      ProfileMenuRow(
                        iconAsset: 'assets/icons/file.svg',
                        label: 'Documentación',
                        badge: '2 de 4',
                        onTap: () =>
                            Navigator.of(context)
                                .pushNamed(AppRoutes.estadoDocumentacion),
                      ),
                      ProfileMenuRow(
                        iconAsset: 'assets/icons/star_section.svg',
                        label: 'Mis calificaciones',
                        onTap: () =>
                            Navigator.of(context)
                                .pushNamed(AppRoutes.perfilCalificaciones),
                      ),
                      ProfileMenuRow(
                        iconAsset: 'assets/icons/history.svg',
                        label: 'Historial de servicios',
                        onTap: () =>
                            Navigator.of(context)
                                .pushNamed(AppRoutes.historialTransportista),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const ProfileSectionLabel('AYUDA'),
                  const SizedBox(height: AppSpacing.xs),
                  ProfileMenuCard(
                    rows: [
                      ProfileMenuRow(
                        iconAsset: 'assets/icons/circle_question_mark.svg',
                        label: 'Ayuda y soporte',
                        onTap: () {
                          // TODO: open help & support.
                        },
                      ),
                      ProfileMenuRow(
                        iconAsset: 'assets/icons/lock.svg',
                        label: 'Términos y privacidad',
                        onTap: () {
                          // TODO: open terms & privacy.
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  ProfileLogoutButton(
                    onTap: () {
                      // TODO: sign the user out.
                      Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil(AppRoutes.login, (_) => false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
