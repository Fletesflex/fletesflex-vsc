import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Sample case number shared by the report/claim screens until the API is
/// wired up.
const _caseNumber = '#FF-2048';

/// "Recibimos tu reporte": confirmation shown after submitting the "¿Qué
/// pasó?" report sheet from the chat, implemented from the Figma
/// "reclamo-enviado" design (file neRKyJz313WM7CEdoZdgGl, node 2073:2).
class ReporteEnviadoScreen extends StatelessWidget {
  const ReporteEnviadoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: AppPageHeader(
        title: 'Recibimos tu reporte',
        subtitle: 'Gracias por avisarnos. Vamos a revisarlo.',
        onBack: () => Navigator.of(context).maybePop(),
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Ver mi reclamo',
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.tuReclamo),
          ),
          CenteredTextLink(
            label: 'Volver al chat',
            onTap: () => Navigator.of(context).maybePop(),
          ),
        ],
      ),
      children: const [
        _CaseNumberCard(statusLabel: 'En revisión'),
        SizedBox(height: AppSpacing.md),
        _StepsCard(),
      ],
    );
  }
}

/// "Tu reclamo": tracking screen for a submitted report, implemented from
/// the Figma "reclamo-estado" design (file neRKyJz313WM7CEdoZdgGl, node
/// 2073:55).
class TuReclamoScreen extends StatelessWidget {
  const TuReclamoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: AppPageHeader(
        title: 'Tu reclamo',
        subtitle: 'Caso $_caseNumber · Enviado hoy, 10:42',
        onBack: () => Navigator.of(context).maybePop(),
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Agregar información',
            variant: ButtonVariant.outlined,
            onPressed: () => Navigator.of(
              context,
            ).pushNamed(AppRoutes.reclamoAgregarInfo),
          ),
          CenteredTextLink(
            label: 'Hablar con soporte',
            onTap: () {
              // TODO: open the support chat/contact flow.
            },
          ),
        ],
      ),
      children: [
        const _Banner(
          iconAsset: 'assets/icons/pause_circle.svg',
          text:
              'El pago de este servicio está en pausa mientras lo revisamos.',
        ),
        const SizedBox(height: AppSpacing.md),
        const _ClaimTimelineCard(),
        const SizedBox(height: AppSpacing.md),
        AppCard(
          padding: const EdgeInsets.all(AppSpacing.md),
          radius: AppRadius.xl,
          elevatedShadow: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lo que reportaste', style: AppTypography.groupTitle),
              const SizedBox(height: AppSpacing.sm),
              const _DetailRow(
                label: 'Motivo',
                value: 'El transportista no llegó',
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: const [
                  _EvidenceThumb(),
                  SizedBox(width: 10),
                  _EvidenceThumb(),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// "Agregar información": lets the requester attach more evidence to an
/// open claim, implemented from the Figma "reclamo-agregar-info" design
/// (file neRKyJz313WM7CEdoZdgGl, node 2073:127).
class AgregarInformacionScreen extends StatefulWidget {
  const AgregarInformacionScreen({super.key});

  @override
  State<AgregarInformacionScreen> createState() =>
      _AgregarInformacionScreenState();
}

class _AgregarInformacionScreenState extends State<AgregarInformacionScreen> {
  final _details = TextEditingController();

  @override
  void dispose() {
    _details.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: AppPageHeader(
        title: 'Agregar información',
        subtitle: 'Sumá fotos o capturas que ayuden a revisar tu caso.',
        onBack: () => Navigator.of(context).maybePop(),
      ),
      bottom: PrimaryButton(
        label: 'Enviar información',
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      children: [
        Text('Fotos o capturas de pantalla', style: AppTypography.label),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            const _EvidenceThumb(),
            const SizedBox(width: 10),
            const _EvidenceThumb(),
            const SizedBox(width: 10),
            _AddEvidenceTile(
              onTap: () {
                // TODO: open the camera/gallery picker for evidence photos.
              },
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Text('JPG o PNG, hasta 10 MB cada una.', style: AppTypography.helper),
        const SizedBox(height: AppSpacing.sectionGap),
        Text('Contanos algo más (opcional)', style: AppTypography.label),
        const SizedBox(height: AppSpacing.sm),
        _TextAreaField(
          controller: _details,
          height: 110,
          hintText:
              'Ej: esperé 40 minutos en la dirección y no pude '
              'comunicarme.',
        ),
      ],
    );
  }
}

/// "Reporte sobre tu servicio": lets the carrier respond to a report filed
/// against one of their services, implemented from the Figma
/// "reclamo-recibido-transportista" design (file neRKyJz313WM7CEdoZdgGl,
/// node 2073:171).
class ReporteTransportistaScreen extends StatefulWidget {
  const ReporteTransportistaScreen({super.key});

  @override
  State<ReporteTransportistaScreen> createState() =>
      _ReporteTransportistaScreenState();
}

class _ReporteTransportistaScreenState
    extends State<ReporteTransportistaScreen> {
  final _version = TextEditingController();

  @override
  void dispose() {
    _version.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: AppPageHeader(
        title: 'Reporte sobre tu servicio',
        subtitle: 'Caso $_caseNumber · Respondé para que podamos revisarlo.',
        onBack: () => Navigator.of(context).maybePop(),
      ),
      bottom: PrimaryButton(
        label: 'Enviar mi respuesta',
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      children: [
        AppCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 14,
          ),
          radius: AppRadius.xl,
          elevatedShadow: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              _DetailRow(
                label: 'Servicio',
                value: 'Mudanza · Palermo → Belgrano',
              ),
              SizedBox(height: AppSpacing.sm),
              _DetailRow(label: 'Fecha', value: 'Sáb 12 Oct, 10:00'),
              SizedBox(height: AppSpacing.sm),
              _DetailRow(label: 'Reportado por', value: 'Lucía R.'),
              SizedBox(height: AppSpacing.sm),
              _DetailRow(label: 'Motivo', value: 'No llegaste al servicio'),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Text('Tu versión de lo que pasó', style: AppTypography.label),
        const SizedBox(height: AppSpacing.sm),
        _TextAreaField(
          controller: _version,
          height: 100,
          hintText: 'Contanos qué pasó con tus palabras.',
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Text('Fotos o capturas (opcional)', style: AppTypography.label),
        const SizedBox(height: AppSpacing.sm),
        _AddEvidenceTile(
          onTap: () {
            // TODO: open the camera/gallery picker for evidence photos.
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Revisamos las dos versiones antes de decidir.',
          style: AppTypography.helper,
        ),
      ],
    );
  }
}

/// "Resolvimos tu reclamo": requester-facing resolution screen, implemented
/// from the Figma "reclamo-resuelto-solicitante" design (file
/// neRKyJz313WM7CEdoZdgGl, node 2073:218).
class ReclamoResueltoSolicitanteScreen extends StatelessWidget {
  const ReclamoResueltoSolicitanteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: AppPageHeader(
        title: 'Resolvimos tu reclamo',
        subtitle: 'Caso $_caseNumber',
        onBack: () => Navigator.of(context).maybePop(),
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Volver al inicio',
            onPressed: () => Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false),
          ),
          CenteredTextLink(
            label: 'Ver detalle del caso',
            onTap: () =>
                Navigator.of(context).pushNamed(AppRoutes.tuReclamo),
          ),
        ],
      ),
      children: [
        const _DecisionHero(
          background: AppColors.successSurface,
          iconAsset: 'assets/icons/check_circle_badge.svg',
          iconColor: AppColors.success,
        ),
        const SizedBox(height: AppSpacing.md),
        AppCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 14,
          ),
          radius: AppRadius.xl,
          elevatedShadow: true,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DetailRow(label: 'Decisión', value: 'A tu favor'),
              SizedBox(height: AppSpacing.sm),
              _DetailRow(
                label: 'Qué pasó',
                value: 'No pudimos confirmar que el servicio se realizó',
              ),
              SizedBox(height: AppSpacing.sm),
              _DetailRow(label: 'Pago', value: 'Te devolvemos \$145.000'),
            ],
          ),
        ),
      ],
    );
  }
}

/// "Resolvimos el reporte": carrier-facing resolution screen, implemented
/// from the Figma "reclamo-resuelto-transportista" design (file
/// neRKyJz313WM7CEdoZdgGl, node 2073:258).
class ReclamoResueltoTransportistaScreen extends StatelessWidget {
  const ReclamoResueltoTransportistaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: AppPageHeader(
        title: 'Resolvimos el reporte',
        subtitle: 'Caso $_caseNumber',
        onBack: () => Navigator.of(context).maybePop(),
      ),
      bottom: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PrimaryButton(
            label: 'Entendido',
            onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.transportistaSolicitudes,
              (route) => false,
            ),
          ),
          CenteredTextLink(
            label: 'Contactar a soporte',
            onTap: () {
              // TODO: open the support chat/contact flow.
            },
          ),
        ],
      ),
      children: [
        const _DecisionHero(
          background: AppColors.iconSurface,
          iconAsset: 'assets/icons/alert_triangle.svg',
          iconColor: AppColors.warning,
        ),
        const SizedBox(height: AppSpacing.md),
        AppCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: 14,
          ),
          radius: AppRadius.xl,
          elevatedShadow: true,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _DetailRow(label: 'Decisión', value: 'A favor del solicitante'),
              SizedBox(height: AppSpacing.sm),
              _DetailRow(
                label: 'Qué pasó',
                value: 'No pudimos confirmar que el servicio se realizó',
              ),
              SizedBox(height: AppSpacing.sm),
              _DetailRow(
                label: 'Cobro',
                value: 'El pago de este servicio no se acredita',
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const _Banner(
          iconAsset: 'assets/icons/alert_triangle.svg',
          text:
              'Tu cuenta recibe una advertencia. Si se repite, puede ser '
              'suspendida.',
        ),
      ],
    );
  }
}

/// "card-caso": case number + status pill, shown on [ReporteEnviadoScreen].
class _CaseNumberCard extends StatelessWidget {
  const _CaseNumberCard({required this.statusLabel});

  final String statusLabel;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 14,
      ),
      radius: AppRadius.xl,
      elevatedShadow: true,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NÚMERO DE CASO',
                  style: AppTypography.badgeLabel.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _caseNumber,
                  style: AppTypography.cardHeading.copyWith(fontSize: 20),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: AppSpacing.xxs,
            ),
            decoration: BoxDecoration(
              color: AppColors.iconSurface,
              borderRadius: BorderRadius.circular(AppRadius.chip),
            ),
            child: Text(
              statusLabel,
              style: AppTypography.badgeLabel.copyWith(
                color: AppColors.verificationAmber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// "card-pasos": "¿Qué pasa ahora?" numbered explainer, shown on
/// [ReporteEnviadoScreen].
class _StepsCard extends StatelessWidget {
  const _StepsCard();

  static const _steps = [
    (
      'Pausamos el pago',
      'El pago de este servicio queda en pausa mientras lo revisamos.',
    ),
    (
      'Revisamos tu caso',
      'Miramos el chat y la información de ambas partes. Puede demorar '
          'hasta 48 hs hábiles.',
    ),
    ('Te avisamos', 'Te mandamos la resolución por acá y por notificación.'),
  ];

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      radius: AppRadius.xl,
      elevatedShadow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('¿Qué pasa ahora?', style: AppTypography.groupTitle),
          for (final (i, step) in _steps.indexed) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 28,
                  height: 28,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.accent,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${i + 1}',
                    style: AppTypography.cardHeading.copyWith(fontSize: 13),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.$1,
                        style: AppTypography.itemTitle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        step.$2,
                        style: AppTypography.itemSubtitle.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// "banner": a one-line icon + message callout on a soft-yellow surface,
/// shared by [TuReclamoScreen] and [ReclamoResueltoTransportistaScreen].
class _Banner extends StatelessWidget {
  const _Banner({required this.iconAsset, required this.text});

  final String iconAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.iconSurface,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            iconAsset,
            width: 20,
            height: 20,
            colorFilter: const ColorFilter.mode(
              AppColors.warning,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: AppTypography.checkLabel.copyWith(height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}

enum _TimelineStepState { done, current, upcoming }

/// "card-estado": vertical rail of 3 steps (reporte recibido → en revisión →
/// resuelto), shown on [TuReclamoScreen]. The claim is always shown mid-
/// review, matching the sample data.
class _ClaimTimelineCard extends StatelessWidget {
  const _ClaimTimelineCard();

  static const _steps = [
    ('Reporte recibido', 'Hoy, 10:42', _TimelineStepState.done),
    ('En revisión', 'Estamos mirando el caso', _TimelineStepState.current),
    (
      'Resuelto',
      'Te avisamos cuando haya decisión',
      _TimelineStepState.upcoming,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      radius: AppRadius.xl,
      elevatedShadow: true,
      child: Column(
        children: [
          for (final (i, step) in _steps.indexed)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    _TimelineDot(step.$3),
                    if (i < _steps.length - 1)
                      Container(
                        width: 2,
                        height: 28,
                        color: step.$3 == _TimelineStepState.done
                            ? AppColors.accent
                            : AppColors.border,
                      ),
                  ],
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: i < _steps.length - 1 ? 10 : 0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step.$1,
                          style: step.$3 == _TimelineStepState.upcoming
                              ? AppTypography.itemTitle.copyWith(
                                  color: AppColors.textMuted,
                                )
                              : AppTypography.itemTitle.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          step.$2,
                          style: AppTypography.itemSubtitle.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _TimelineDot extends StatelessWidget {
  const _TimelineDot(this.state);

  final _TimelineStepState state;

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case _TimelineStepState.done:
        return Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppColors.accent,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            'assets/icons/check_sm.svg',
            width: 14,
            height: 14,
          ),
        );
      case _TimelineStepState.current:
        return SvgPicture.asset(
          'assets/icons/radio_on.svg',
          width: 24,
          height: 24,
        );
      case _TimelineStepState.upcoming:
        return Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: AppColors.border,
            shape: BoxShape.circle,
          ),
        );
    }
  }
}

/// Label + right-aligned value row shared by the summary/decision cards
/// ("Motivo", "Servicio", "Decisión", …).
class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTypography.itemSubtitle.copyWith(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: AppTypography.itemTitle.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}

/// 72px gray tile standing in for an already-attached evidence photo.
class _EvidenceThumb extends StatelessWidget {
  const _EvidenceThumb();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.segmentedTrack,
        borderRadius: BorderRadius.circular(AppRadius.sm + 2),
      ),
      child: SvgPicture.asset(
        'assets/icons/image.svg',
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(
          AppColors.textMuted,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

/// 72px dashed yellow tile for attaching a new evidence photo.
class _AddEvidenceTile extends StatelessWidget {
  const _AddEvidenceTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm + 2),
      child: CustomPaint(
        painter: DashedBorderPainter(
          color: AppColors.accent,
          radius: AppRadius.sm + 2,
          strokeWidth: 2,
        ),
        child: Container(
          width: 72,
          height: 72,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.iconSurface,
            borderRadius: BorderRadius.circular(AppRadius.sm + 2),
          ),
          child: SvgPicture.asset(
            'assets/icons/plus.svg',
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}

/// Bordered multiline text field used for the free-text report/claim
/// fields.
class _TextAreaField extends StatelessWidget {
  const _TextAreaField({
    required this.controller,
    required this.height,
    required this.hintText,
  });

  final TextEditingController controller;
  final double height;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.md),
      borderSide: const BorderSide(color: AppColors.border, width: 1.5),
    );

    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        cursorColor: AppColors.accent,
        style: AppTypography.fieldValue,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTypography.fieldValue.copyWith(
            color: AppColors.textMuted,
          ),
          filled: true,
          fillColor: AppColors.surface,
          contentPadding: const EdgeInsets.all(AppSpacing.md),
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: const BorderSide(color: AppColors.accent, width: 2),
          ),
        ),
      ),
    );
  }
}

/// Centered icon-in-circle hero shown above the decision card on the two
/// "resuelto" screens.
class _DecisionHero extends StatelessWidget {
  const _DecisionHero({
    required this.background,
    required this.iconAsset,
    required this.iconColor,
  });

  final Color background;
  final String iconAsset;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 88,
        height: 88,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: background, shape: BoxShape.circle),
        child: SvgPicture.asset(
          iconAsset,
          width: 40,
          height: 40,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
        ),
      ),
    );
  }
}
