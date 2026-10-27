import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';
import 'comprobante_pago_screen.dart' show ShadowBackButton;

const _requesterReasons = [
  'Cambié de planes',
  'Encontré otra opción',
  'El horario ya no me sirve',
  'Me equivoqué en la solicitud',
  'Otro motivo',
];

const _carrierReasons = [
  'Tengo un problema con el vehículo',
  'No llego en el horario',
  'No pude comunicarme con el solicitante',
  'Cambió lo que hay que transportar',
  'Otro motivo',
];

/// Cancellation form shared by the requester and the carrier, implemented
/// from the Figma "cancelar-servicio-solicitante" (node 2068:45) and
/// "cancelar-servicio-transportista" (node 2068:103) designs (file
/// neRKyJz313WM7CEdoZdgGl). Visual only: "Cancelar servicio" just opens the
/// confirmation screen.
class CancelarServicioScreen extends StatefulWidget {
  const CancelarServicioScreen({super.key, required this.role});

  final ProfileMode role;

  @override
  State<CancelarServicioScreen> createState() =>
      _CancelarServicioScreenState();
}

class _CancelarServicioScreenState extends State<CancelarServicioScreen> {
  late String? _reason = _reasons.first;
  final _comment = TextEditingController();

  List<String> get _reasons => widget.role == ProfileMode.solicitante
      ? _requesterReasons
      : _carrierReasons;

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  void _confirm() {
    // TODO: send the cancellation (reason + comment) to the backend.
    Navigator.of(context).pushReplacementNamed(
      AppRoutes.servicioCancelado,
      arguments: widget.role,
    );
  }

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
            label: 'Cancelar servicio',
            variant: ButtonVariant.danger,
            onPressed: _reason == null ? null : _confirm,
          ),
          const SizedBox(height: AppSpacing.xs),
          CenteredTextLink(
            label: 'Volver',
            onTap: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
      children: [
        Text(
          'Cancelar servicio',
          style: AppTypography.headline.copyWith(fontSize: 28),
        ),
        const SizedBox(height: 6),
        Text(
          'Contanos por qué querés cancelar.',
          style: AppTypography.cardDescription.copyWith(
            fontSize: 14,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        CancelWarningBanner(
          onViewPolicy: () {
            // TODO: open the cancellation policy.
          },
        ),
        const SizedBox(height: 14),
        CancelReasonCard(
          reasons: _reasons,
          selected: _reason,
          onChanged: (reason) => setState(() => _reason = reason),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _comment,
          minLines: 2,
          maxLines: 4,
          cursorColor: AppColors.accent,
          style: AppTypography.fieldValue,
          decoration: InputDecoration(
            hintText: 'Comentario (opcional)',
            hintStyle: AppTypography.fieldValue.copyWith(
              color: AppColors.textMuted,
            ),
            contentPadding: const EdgeInsets.all(AppSpacing.md),
          ),
        ),
      ],
    );
  }
}

/// Cancellation confirmation, implemented from the Figma
/// "servicio-cancelado" design (file neRKyJz313WM7CEdoZdgGl, node
/// 2069:411). Receives the [ProfileMode] of who cancelled as the route
/// argument, so "Volver al inicio" lands on the right role's Home.
class ServicioCanceladoScreen extends StatelessWidget {
  const ServicioCanceladoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final role =
        ModalRoute.of(context)?.settings.arguments as ProfileMode? ??
            ProfileMode.solicitante;

    return AppPage(
      bodyPadding: const EdgeInsets.fromLTRB(32, 120, 32, AppSpacing.sectionGap),
      bottom: PrimaryButton(
        label: 'Volver al inicio',
        onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
          role == ProfileMode.solicitante
              ? AppRoutes.home
              : AppRoutes.transportistaSolicitudes,
          (route) => false,
        ),
      ),
      children: [
        Center(
          child: Container(
            width: 104,
            height: 104,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.iconSurface,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/circle_x.svg',
              width: 48,
              height: 48,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Cancelaste el servicio',
          style: AppTypography.headline.copyWith(fontSize: 24),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Le avisamos a la otra parte. Te vamos a avisar por acá cómo '
          'sigue el pago.',
          style: AppTypography.body.copyWith(fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
