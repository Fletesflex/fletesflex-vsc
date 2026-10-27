import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';
import 'comprobante_pago_screen.dart' show ShadowBackButton;

/// Requester view of a confirmed, in-progress service ("Tu servicio"),
/// implemented from the Figma "servicio-solicitante-confirmado" design
/// (file neRKyJz313WM7CEdoZdgGl, node 2067:2).
class ServicioSolicitanteScreen extends StatelessWidget {
  const ServicioSolicitanteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: const Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xs,
        ),
        child: Row(children: [ShadowBackButton()]),
      ),
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xs,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      bottom: CenteredTextLink(
        label: 'Cancelar servicio',
        color: AppColors.danger,
        onTap: () => Navigator.of(
          context,
        ).pushNamed(AppRoutes.cancelarServicioSolicitante),
      ),
      children: [
        Text('Tu servicio', style: AppTypography.headline.copyWith(fontSize: 28)),
        const SizedBox(height: AppSpacing.md),
        ServiceStatusCard(
          dateLabel: 'Sáb 12 Oct · 10:00–13:00',
          note: 'Te avisamos cuando salga hacia tu dirección.',
          statusLabel: 'Confirmado',
          statusColor: AppColors.success,
          statusBackground: AppColors.successSurface,
          current: ServiceStep.confirmado,
        ),
        const SizedBox(height: 14),
        PersonSummaryCard(
          caption: 'Transportista',
          name: 'Carlos M.',
          avatarAsset: 'assets/images/avatar_carlos_mendez.png',
          rating: 4.8,
          ratingSuffix: '(126 viajes)',
          detail: 'Fiat Fiorino · Carga liviana',
          onChat: () => Navigator.of(context).pushNamed(AppRoutes.chat),
        ),
        const SizedBox(height: 14),
        const RouteStopsCard(
          originAddress: 'Av. Santa Fe 3200, Palermo',
          originDetail: 'Piso 4 · con ascensor',
          destinationAddress: 'Av. Cabildo 2150, Belgrano',
          destinationDetail: 'Planta baja · sin escaleras',
          typeLabel: 'Mudanza chica · 2 ambientes',
        ),
        const SizedBox(height: 14),
        const AmountCard(caption: 'PAGADO', amount: 145000, pillLabel: 'Pagado'),
      ],
    );
  }
}

/// Carrier view right after being assigned a job, implemented from the
/// Figma "servicio-transportista-confirmado" design (file
/// neRKyJz313WM7CEdoZdgGl, node 2067:104).
class ServicioAsignadoScreen extends StatelessWidget {
  const ServicioAsignadoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: const Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xs,
        ),
        child: Row(children: [ShadowBackButton()]),
      ),
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xs,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Iniciar servicio',
            onPressed: () => Navigator.of(
              context,
            ).pushReplacementNamed(AppRoutes.servicioEnCurso),
          ),
          const SizedBox(height: AppSpacing.sm),
          CenteredTextLink(
            label: 'Cancelar servicio',
            color: AppColors.danger,
            onTap: () => Navigator.of(
              context,
            ).pushNamed(AppRoutes.cancelarServicioTransportista),
          ),
        ],
      ),
      children: [
        Text(
          'Servicio asignado',
          style: AppTypography.headline.copyWith(fontSize: 28),
        ),
        const SizedBox(height: AppSpacing.md),
        ServiceStatusCard(
          dateLabel: 'Sáb 12 Oct · 10:00–13:00',
          note: 'Iniciá el servicio cuando salgas hacia el retiro.',
          statusLabel: 'Confirmado',
          statusColor: AppColors.success,
          statusBackground: AppColors.successSurface,
          current: ServiceStep.confirmado,
        ),
        const SizedBox(height: 14),
        PersonSummaryCard(
          caption: 'Solicitante',
          name: 'Lucía R.',
          initial: 'L',
          rating: 4.9,
          ratingSuffix: '(12 servicios)',
          onChat: () => Navigator.of(context).pushNamed(AppRoutes.chat),
        ),
        const SizedBox(height: 14),
        const RouteStopsCard(
          originAddress: 'Av. Santa Fe 3200, Palermo',
          originDetail: 'Piso 4 · con ascensor',
          destinationAddress: 'Av. Cabildo 2150, Belgrano',
          destinationDetail: 'Planta baja · sin escaleras',
          typeLabel: 'Mudanza chica · 2 ambientes',
        ),
        const SizedBox(height: 14),
        const AmountCard(caption: 'VAS A COBRAR', amount: 145000),
      ],
    );
  }
}

/// Carrier view while the service is underway, implemented from the Figma
/// "servicio-transportista-en-curso" design (file neRKyJz313WM7CEdoZdgGl,
/// node 2067:205).
class ServicioEnCursoScreen extends StatelessWidget {
  const ServicioEnCursoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: const Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xs,
        ),
        child: Row(children: [ShadowBackButton()]),
      ),
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xs,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Finalizar servicio',
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.transportistaSolicitudes,
              (route) => false,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          CenteredTextLink(
            label: 'Reportar un problema',
            color: AppColors.textSecondary,
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.reporteProblema),
          ),
        ],
      ),
      children: [
        Text(
          'Servicio en curso',
          style: AppTypography.headline.copyWith(fontSize: 28),
        ),
        const SizedBox(height: AppSpacing.md),
        ServiceStatusCard(
          dateLabel: 'Sáb 12 Oct · 10:12',
          note: 'Cuando termines la entrega, finalizá el servicio.',
          statusLabel: 'En curso',
          statusColor: AppColors.verificationAmber,
          statusBackground: AppColors.iconSurface,
          current: ServiceStep.enCurso,
        ),
        const SizedBox(height: 14),
        PersonSummaryCard(
          caption: 'Solicitante',
          name: 'Lucía R.',
          initial: 'L',
          rating: 4.9,
          ratingSuffix: '(12 servicios)',
          onChat: () => Navigator.of(context).pushNamed(AppRoutes.chat),
        ),
        const SizedBox(height: 14),
        const RouteStopsCard(
          originAddress: 'Av. Santa Fe 3200, Palermo',
          originDetail: 'Piso 4 · con ascensor',
          destinationAddress: 'Av. Cabildo 2150, Belgrano',
          destinationDetail: 'Planta baja · sin escaleras',
          typeLabel: 'Mudanza chica · 2 ambientes',
        ),
        const SizedBox(height: 14),
        const AmountCard(caption: 'VAS A COBRAR', amount: 145000),
      ],
    );
  }
}

/// Requester prompt right after the carrier marks the service finished
/// ("¿Todo salió bien?"), implemented from the Figma
/// "servicio-solicitante-finalizado" design (file neRKyJz313WM7CEdoZdgGl,
/// node 2068:2).
class ServicioFinalizadoScreen extends StatelessWidget {
  const ServicioFinalizadoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: const Padding(
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.xs,
        ),
        child: Row(children: [ShadowBackButton()]),
      ),
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xs,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Todo salió bien',
            onPressed: () => Navigator.of(
              context,
            ).pushNamed(AppRoutes.calificacionSolicitante),
          ),
          const SizedBox(height: AppSpacing.sm),
          PrimaryButton(
            label: 'Hubo un problema',
            variant: ButtonVariant.outlined,
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.reporteProblema),
          ),
        ],
      ),
      children: [
        Text(
          '¿Todo salió bien?',
          style: AppTypography.headline.copyWith(fontSize: 28),
        ),
        const SizedBox(height: AppSpacing.md),
        AppCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sectionGap,
          ),
          radius: AppRadius.xl,
          elevatedShadow: true,
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.successSurface,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/icons/check_bold.svg',
                  width: 30,
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    AppColors.success,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Carlos finalizó el servicio',
                style: AppTypography.cardHeading.copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                'Confirmá que todo salió bien para cerrar el servicio y '
                'calificar a Carlos.',
                style: AppTypography.body.copyWith(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        AppCard(
          padding: EdgeInsets.zero,
          radius: AppRadius.xl,
          elevatedShadow: true,
          child: Column(
            children: [
              _SummaryRow('Servicio', 'Mudanza chica · Palermo → Belgrano'),
              const AppDivider(thin: true),
              _SummaryRow('Fecha', 'Sáb 12 Oct, 10:00–13:00'),
              const AppDivider(thin: true),
              _SummaryRow('Total pagado', r'$145.000'),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Text(
            label,
            style: AppTypography.routeText.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              value,
              style: AppTypography.itemTitle.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
