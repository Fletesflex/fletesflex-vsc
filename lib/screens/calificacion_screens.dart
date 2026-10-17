import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/rating.dart';
import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Shows the "rate your service" dialog on top of [child] once it's built,
/// implemented from the Figma "aviso-calificacion-solicitante" (70:4) and
/// "aviso-calificacion-transportista" (70:117) designs
/// (file o7nkeARTqRUSPsNBaYg2nb).
///
/// [target] is who must be rated: requesters rate the carrier (blocking —
/// no way to dismiss), carriers rate the requester (dismissible).
class RatingPromptHost extends StatefulWidget {
  const RatingPromptHost({
    super.key,
    required this.target,
    required this.child,
  });

  final RatingTarget target;
  final Widget child;

  @override
  State<RatingPromptHost> createState() => _RatingPromptHostState();
}

class _RatingPromptHostState extends State<RatingPromptHost> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final blocking = widget.target == RatingTarget.carrier;
      showDialog<void>(
        context: context,
        barrierDismissible: !blocking,
        barrierColor: AppColors.textPrimary.withValues(
          alpha: blocking ? 0.7 : 0.5,
        ),
        builder: (_) => RatingPromptDialog(target: widget.target),
      );
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// The prompt card itself.
class RatingPromptDialog extends StatelessWidget {
  const RatingPromptDialog({super.key, required this.target});

  final RatingTarget target;

  bool get _blocking => target == RatingTarget.carrier;

  void _rateNow(BuildContext context) {
    Navigator.of(context)
      ..pop()
      ..pushNamed(
        target == RatingTarget.carrier
            ? AppRoutes.calificacionSolicitante
            : AppRoutes.calificacionTransportista,
      );
  }

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        28,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.1),
            offset: const Offset(0, 16),
            blurRadius: 16,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RatingPromptBurst(
            iconAsset: _blocking
                ? 'assets/icons/star_accent_lg.svg'
                : 'assets/icons/thumbs_up.svg',
          ),
          SizedBox(height: _blocking ? AppSpacing.lg : AppSpacing.sectionGap),
          Text(
            _blocking
                ? 'Calificá tu servicio para continuar'
                : '¡Servicio finalizado! Calificá tu experiencia',
            style: AppTypography.display.copyWith(fontSize: 22, height: 1.25),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            _blocking
                ? 'Para poder publicar una nueva solicitud, primero necesitás '
                    'calificar el servicio completado. Tu opinión ayuda a '
                    'mejorar la comunidad.'
                : 'Contanos cómo te fue con la mudanza. Tu valoración ayuda a '
                    'mantener la confianza de FletesFlex.',
            style: AppTypography.body.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: _blocking ? AppSpacing.lg : AppSpacing.sectionGap),
          PendingServiceCard(
            category: _blocking ? 'Mudanza local' : 'Flete local',
            date: _blocking ? 'Sáb, 5 de sep' : '5 de sep, 2026',
            personCaption:
                _blocking ? 'Tu transportista' : 'Cliente / Solicitante',
            personName: target.name,
            avatarAsset: _blocking
                ? 'assets/images/avatar_carlos_mendez.png'
                : 'assets/images/avatar_maria.png',
          ),
          SizedBox(height: _blocking ? AppSpacing.lg : AppSpacing.sectionGap),
          PillButton(
            label: 'Calificar ahora',
            onPressed: () => _rateNow(context),
          ),
          if (!_blocking) ...[
            const SizedBox(height: AppSpacing.sm),
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Text(
                'Más tarde',
                style: AppTypography.linkSmall.copyWith(
                  color: AppColors.textMuted,
                  decorationColor: AppColors.textMuted,
                ),
              ),
            ),
          ],
        ],
      ),
    );

    return PopScope(
      canPop: !_blocking,
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Stack(
          children: [
            card,
            if (!_blocking)
              Positioned(
                top: AppSpacing.md,
                right: AppSpacing.md,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.border,
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/icons/x_circle.svg',
                      width: 14,
                      height: 14,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// Full-screen block shown when a requester tries to publish with a rating
/// pending, implemented from the Figma "bloqueo-calificacion-pendiente"
/// design (file o7nkeARTqRUSPsNBaYg2nb, node 71:295).
class BloqueoCalificacionScreen extends StatelessWidget {
  const BloqueoCalificacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.md,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.textPrimary,
                borderRadius: BorderRadius.circular(AppRadius.chip),
              ),
              child: SvgPicture.asset(
                'assets/icons/truck_logo.svg',
                width: 18,
                height: 18,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              'FletesFlex',
              style: AppTypography.greetingTitle.copyWith(fontSize: 18),
            ),
          ],
        ),
      ),
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        60,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      bottom: PillButton(
        label: 'Calificar ahora',
        onPressed: () => Navigator.of(context).pushReplacementNamed(
          AppRoutes.calificacionSolicitante,
        ),
      ),
      children: [
        const Center(
          child: RatingPromptBurst(
            iconAsset: 'assets/icons/star_accent_lg.svg',
          ),
        ),
        const SizedBox(height: 28),
        Text(
          'Tenés una calificación pendiente',
          style: AppTypography.display.copyWith(fontSize: 22, height: 1.25),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          'Completala para poder publicar una nueva solicitud. Tu opinión '
          'ayuda a mantener la confianza en la comunidad.',
          style: AppTypography.body.copyWith(fontSize: 14),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),
        PendingServiceCard(
          category: 'Mudanza local',
          date: '5 de sep, 2026',
          personCaption: 'Tu transportista',
          personName: RatingTarget.carrier.name,
          avatarAsset: 'assets/images/avatar_carlos_mendez.png',
          filled: false,
          avatarSize: 44,
        ),
      ],
    );
  }
}

/// Star rating + tags + comment form, implemented from the Figma
/// "calificacion-solicitante-transportista" (70:224) and
/// "calificacion-transportista-solicitante" (70:305) designs
/// (file o7nkeARTqRUSPsNBaYg2nb).
class CalificarScreen extends StatefulWidget {
  const CalificarScreen({super.key, required this.target});

  final RatingTarget target;

  @override
  State<CalificarScreen> createState() => _CalificarScreenState();
}

class _CalificarScreenState extends State<CalificarScreen> {
  int _stars = 0;
  final _tags = <String>{};
  final _comment = TextEditingController();

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  void _submit() {
    // TODO: send the rating to the API.
    Navigator.of(context).pushReplacementNamed(
      AppRoutes.confirmacionCalificacion,
      arguments: RatingResult(
        target: widget.target,
        stars: _stars,
        tags: [
          for (final t in widget.target.tags)
            if (_tags.contains(t)) t,
        ],
        comment: _comment.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final target = widget.target;

    return AppPage(
      header: Container(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.sm,
        ),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [
            Material(
              color: AppColors.surface,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: InkWell(
                onTap: () => Navigator.of(context).maybePop(),
                borderRadius: BorderRadius.circular(AppRadius.sm),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/chevron_left.svg',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                target.screenTitle,
                style: AppTypography.appBarTitle,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 40),
          ],
        ),
      ),
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        32,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      bottom: PillButton(
        label: 'Enviar calificación',
        onPressed: _stars == 0 ? null : _submit,
      ),
      children: [
        Center(
          child: Container(
            width: 88,
            height: 88,
            padding: const EdgeInsets.all(AppSpacing.xxs),
            decoration: BoxDecoration(
              color: AppColors.border,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.accent, width: 2),
            ),
            child: AppAvatar(target.avatarAsset, size: 76),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          target.name,
          style: AppTypography.greetingTitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          target.role,
          style: AppTypography.greeting,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 28),
        StarRatingInput(
          value: _stars,
          onChanged: (v) => setState(() => _stars = v),
        ),
        const SizedBox(height: 28),
        Text('¿Qué te gustó?', style: AppTypography.userName),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.xs,
          runSpacing: AppSpacing.xs,
          children: [
            for (final tag in target.tags)
              SelectableTag(
                label: tag,
                selected: _tags.contains(tag),
                onTap: () => setState(() {
                  if (!_tags.remove(tag)) _tags.add(tag);
                }),
              ),
          ],
        ),
        const SizedBox(height: 28),
        TextField(
          controller: _comment,
          minLines: 4,
          maxLines: 6,
          cursorColor: AppColors.accent,
          style: AppTypography.fieldValue,
          decoration: InputDecoration(
            hintText: 'Contanos más sobre tu experiencia (opcional)',
            hintStyle: AppTypography.fieldValue.copyWith(
              color: AppColors.textSecondary.withValues(alpha: 0.6),
            ),
            contentPadding: const EdgeInsets.all(AppSpacing.md),
          ),
        ),
      ],
    );
  }
}

/// Thank-you screen after rating, implemented from the Figma
/// "confirmacion-calificacion" design (file o7nkeARTqRUSPsNBaYg2nb,
/// node 70:370). Receives a [RatingResult] as the route argument.
class ConfirmacionCalificacionScreen extends StatelessWidget {
  const ConfirmacionCalificacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final result =
        ModalRoute.of(context)?.settings.arguments as RatingResult? ??
            const RatingResult(
              target: RatingTarget.carrier,
              stars: 5,
              tags: ['Puntualidad', 'Buen trato'],
            );
    final target = result.target;

    return AppPage(
      bodyPadding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        32,
        AppSpacing.lg,
        AppSpacing.sectionGap,
      ),
      bottom: PrimaryButton(
        label: 'Volver al inicio',
        onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
          target == RatingTarget.carrier
              ? AppRoutes.home
              : AppRoutes.transportistaSolicitudes,
          (route) => false,
        ),
      ),
      children: [
        const SuccessBurst(
          ringAsset: 'assets/icons/burst_ring_green.svg',
          decorations: [
            OrbitDecoration('assets/icons/sparkle_dark_3.svg', -55, -35, 16),
            OrbitDecoration('assets/icons/circle_accent.svg', 50, -45, 12),
            OrbitDecoration('assets/icons/sparkle_dark.svg', 55, 25, 14),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          '¡Gracias por tu calificación!',
          style: AppTypography.display.copyWith(fontSize: 28),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Tu opinión quedó registrada en el perfil del usuario. Esto ayuda a '
          'toda la comunidad de FletesFlex.',
          style: AppTypography.body.copyWith(height: 1.45),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.lg),
        AppCard(
          borderWidth: 0,
          borderColor: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'TU OPINIÓN REGISTRADA',
                style: AppTypography.buttonSmall.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const AppDivider(thin: true),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  AppAvatar(target.avatarAsset, size: 48),
                  const SizedBox(width: AppSpacing.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(target.name, style: AppTypography.userName),
                      const SizedBox(height: 2),
                      Text(
                        target == RatingTarget.carrier
                            ? 'Transportista asignado'
                            : 'Solicitante',
                        style: AppTypography.routeText,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              const AppDivider(thin: true),
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  for (var i = 0; i < 5; i++) ...[
                    if (i > 0) const SizedBox(width: AppSpacing.xxs),
                    SvgPicture.asset(
                      i < result.stars
                          ? 'assets/icons/star_filled_20.svg'
                          : 'assets/icons/star_empty_sm.svg',
                      width: 20,
                      height: 20,
                    ),
                  ],
                ],
              ),
              if (result.tags.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    for (final tag in result.tags)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.accent.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Text('✓ $tag', style: AppTypography.tag),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// A past review shown on the carrier's ratings profile.
class _PastReview {
  const _PastReview(this.stars, this.date, this.text, this.author);

  final int stars;
  final String date;
  final String text;
  final String author;
}

/// Carrier profile focused on received ratings, implemented from the Figma
/// "perfil-transportista-calificaciones" design (file o7nkeARTqRUSPsNBaYg2nb,
/// node 71:4).
class PerfilCalificacionesScreen extends StatelessWidget {
  const PerfilCalificacionesScreen({super.key});

  // TODO: load from the API; samples mirror Figma.
  static const _reviews = [
    _PastReview(5, '2 sep 2026',
        'Excelente servicio, muy puntual y cuidadoso con los muebles. '
            'Recomendado.',
        'María G.'),
    _PastReview(
        5, '28 ago 2026', 'Llegó a horario, todo perfecto. Muy amable.', 'Juan P.'),
    _PastReview(4, '25 ago 2026',
        'Buen servicio en general, tardó un poco en llegar pero fue cuidadoso.',
        'Laura M.'),
    _PastReview(5, '20 ago 2026',
        'Muy profesional, el vehículo estaba impecable.', 'Roberto S.'),
    _PastReview(3, '15 ago 2026',
        'Cumplió pero la comunicación podría mejorar.', 'Ana L.'),
  ];

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Perfil del transportista',
      topBarStyle: TopBarStyle.centered,
      bodyPadding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.sectionGap,
          ),
          child: Column(
            children: [
              const AppAvatar(
                'assets/images/avatar_carlos_mendez.png',
                size: 100,
                ringColor: AppColors.accent,
              ),
              const SizedBox(height: AppSpacing.md),
              Text('Carlos Méndez', style: AppTypography.sectionTitle),
              const SizedBox(height: AppSpacing.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('4.8', style: AppTypography.priceAmount),
                  const SizedBox(width: AppSpacing.xs),
                  for (var i = 0; i < 5; i++) ...[
                    if (i > 0) const SizedBox(width: 2),
                    SvgPicture.asset(
                      'assets/icons/star_rating_20.svg',
                      width: 20,
                      height: 20,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.xxs),
              Text('• 127 servicios realizados', style: AppTypography.greeting),
              const SizedBox(height: AppSpacing.md),
              const Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                alignment: WrapAlignment.center,
                children: [
                  _VerifiedChip(
                    iconAsset: 'assets/icons/check_verified.svg',
                    label: 'Identidad verificada',
                  ),
                  _VerifiedChip(
                    iconAsset: 'assets/icons/truck_verified.svg',
                    label: 'Vehículo verificado',
                  ),
                ],
              ),
            ],
          ),
        ),
        const AppDivider(),
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            48,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Calificaciones recientes', style: AppTypography.appBarTitle),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                'Opiniones de clientes que completaron traslados',
                style: AppTypography.routeText.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              for (final (i, review) in _reviews.indexed) ...[
                if (i > 0) const SizedBox(height: AppSpacing.md),
                AppCard(
                  padding: const EdgeInsets.all(AppSpacing.cardPadding),
                  radius: AppRadius.xl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          for (var s = 0; s < 5; s++) ...[
                            if (s > 0) const SizedBox(width: 2),
                            SvgPicture.asset(
                              s < review.stars
                                  ? 'assets/icons/star_rating_14.svg'
                                  : 'assets/icons/star_rating_14_off.svg',
                              width: 14,
                              height: 14,
                            ),
                          ],
                          const Spacer(),
                          Text(
                            review.date,
                            style: AppTypography.itemSubtitle,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        '"${review.text}"',
                        style: AppTypography.fieldValue.copyWith(height: 1.4),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/dot_dark_8.svg',
                            width: 8,
                            height: 8,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            review.author,
                            style: AppTypography.featureLabel.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _VerifiedChip extends StatelessWidget {
  const _VerifiedChip({required this.iconAsset, required this.label});

  final String iconAsset;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.successSurface,
        borderRadius: BorderRadius.circular(AppRadius.chip),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(iconAsset, width: 14, height: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTypography.tag.copyWith(color: AppColors.success),
          ),
        ],
      ),
    );
  }
}

/// A finished service in the history list.
class _HistoryItem {
  const _HistoryItem(this.category, this.date, this.route, this.person);

  final String category;
  final String date;
  final String route;

  /// "Transportista: Jorge Rossi" / "Cliente: Pedro Martínez".
  final String person;
}

/// "Mis servicios" history with a pending-rating card on top, implemented
/// from the Figma "historial-solicitante-pendiente" (71:149) and
/// "historial-transportista-pendiente" (71:216) designs
/// (file o7nkeARTqRUSPsNBaYg2nb). For requesters ([target] = carrier) the
/// pending rating blocks new requests; for carriers it is a soft reminder.
class HistorialServiciosScreen extends StatefulWidget {
  const HistorialServiciosScreen({super.key, required this.target});

  final RatingTarget target;

  @override
  State<HistorialServiciosScreen> createState() =>
      _HistorialServiciosScreenState();
}

class _HistorialServiciosScreenState extends State<HistorialServiciosScreen> {
  static const _tabs = ['Todos', 'Activos', 'Completados'];
  String _tab = 'Completados';

  bool get _isRequester => widget.target == RatingTarget.carrier;

  // TODO: load from the API; samples mirror Figma.
  List<_HistoryItem> get _completed => _isRequester
      ? const [
          _HistoryItem('Flete local', '28 de ago, 2026',
              'Caballito → Villa Urquiza', 'Transportista: Jorge Rossi'),
          _HistoryItem('Mensajería', '15 de ago, 2026', 'Retiro → San Telmo',
              'Cadete: Lucas Gómez'),
        ]
      : const [
          _HistoryItem('Flete local', '28 de ago, 2026',
              'Caballito → Villa Urquiza', 'Cliente: Pedro Martínez'),
          _HistoryItem('Flete local', '12 de ago, 2026', 'Nuñez → Recoleta',
              'Cliente: Ana Laura Ruiz'),
        ];

  void _rate() {
    Navigator.of(context).pushNamed(
      _isRequester
          ? AppRoutes.calificacionSolicitante
          : AppRoutes.calificacionTransportista,
    );
  }

  @override
  Widget build(BuildContext context) {
    final showCompleted = _tab != 'Activos';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.sm,
                AppSpacing.lg,
                AppSpacing.md,
              ),
              child: Row(
                children: [
                  InkResponse(
                    onTap: () => Navigator.of(context).maybePop(),
                    radius: 20,
                    child: SizedBox(
                      width: 24,
                      height: 24,
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/chevron_left_sm.svg',
                          width: 14.4,
                          height: 14.4,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text('Mis servicios', style: AppTypography.headline),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  for (final tab in _tabs)
                    Expanded(
                      child: InkWell(
                        onTap: () => setState(() => _tab = tab),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSpacing.sm,
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: tab == _tab
                                    ? AppColors.accent
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          child: Text(
                            tab,
                            style: AppTypography.fieldValue.copyWith(
                              fontWeight: tab == _tab
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: tab == _tab
                                  ? AppColors.textPrimary
                                  : AppColors.textMuted,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                children: [
                  if (showCompleted) ...[
                    _PendingRatingCard(
                      blocking: _isRequester,
                      category: _isRequester ? 'Mudanza local' : 'Flete local',
                      person: _isRequester
                          ? 'Transportista: Carlos Méndez'
                          : 'Cliente: María González',
                      onRate: _rate,
                    ),
                    for (final item in _completed) ...[
                      const SizedBox(height: AppSpacing.md),
                      _CompletedCard(item: item),
                    ],
                  ] else
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Text(
                        'No tenés servicios activos.',
                        style: AppTypography.greeting,
                        textAlign: TextAlign.center,
                      ),
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

class _PendingRatingCard extends StatelessWidget {
  const _PendingRatingCard({
    required this.blocking,
    required this.category,
    required this.person,
    required this.onRate,
  });

  final bool blocking;
  final String category;
  final String person;
  final VoidCallback onRate;

  @override
  Widget build(BuildContext context) {
    final statusColor = blocking ? AppColors.danger : AppColors.warning;

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      radius: AppRadius.xl,
      borderColor: blocking ? AppColors.accent : AppColors.border,
      borderWidth: blocking ? 2 : 1.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CategoryLabel(category, highlighted: true),
              Text('5 de sep, 2026', style: AppTypography.itemSubtitle),
            ],
          ),
          const SizedBox(height: 14),
          const AppDivider(thin: true),
          const SizedBox(height: 14),
          Text('Palermo → Belgrano', style: AppTypography.userName),
          const SizedBox(height: 6),
          Text(
            person,
            style: AppTypography.greeting,
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: blocking ? AppColors.dangerSurface : AppColors.warningSoft,
              borderRadius: BorderRadius.circular(AppRadius.chip),
            ),
            child: Row(
              children: [
                SvgPicture.asset(
                  blocking
                      ? 'assets/icons/alert_triangle.svg'
                      : 'assets/icons/info_sm.svg',
                  width: 16,
                  height: 16,
                  colorFilter: ColorFilter.mode(statusColor, BlendMode.srcIn),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    blocking
                        ? 'Pendiente de calificar — acción requerida'
                        : 'Pendiente de calificar',
                    style: AppTypography.tag.copyWith(color: statusColor),
                  ),
                ),
              ],
            ),
          ),
          if (blocking) ...[
            const SizedBox(height: 14),
            Text(
              'No podés publicar nuevas solicitudes hasta calificar.',
              style: AppTypography.tag.copyWith(color: AppColors.danger),
            ),
          ],
          const SizedBox(height: 14),
          SizedBox(
            height: 44,
            child: Material(
              color: blocking ? AppColors.accent : AppColors.surface,
              shape: StadiumBorder(
                side: blocking
                    ? BorderSide.none
                    : const BorderSide(color: AppColors.accent, width: 1.5),
              ),
              child: InkWell(
                onTap: onRate,
                customBorder: const StadiumBorder(),
                child: Center(
                  child: Text(
                    blocking ? 'Calificar ahora' : 'Calificar',
                    style: AppTypography.featureLabel.copyWith(fontSize: 14),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletedCard extends StatelessWidget {
  const _CompletedCard({required this.item});

  final _HistoryItem item;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      radius: AppRadius.xl,
      borderWidth: 1,
      shadow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _CategoryLabel(item.category),
              Text(item.date, style: AppTypography.itemSubtitle),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            item.route,
            style: AppTypography.userName.copyWith(fontSize: 15),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(item.person, style: AppTypography.routeText),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: AppSpacing.xxs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.successDarkSurface,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Completado',
                  style: AppTypography.badgeLabel.copyWith(
                    color: AppColors.successDark,
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pushNamed(
                  AppRoutes.perfilCalificaciones,
                ),
                child: Text(
                  'Ver calificación',
                  style: AppTypography.linkSmall.copyWith(fontSize: 13),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryLabel extends StatelessWidget {
  const _CategoryLabel(this.label, {this.highlighted = false});

  final String label;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: highlighted ? 10 : AppSpacing.xs,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: highlighted ? AppColors.iconSurface : AppColors.border,
        borderRadius: BorderRadius.circular(highlighted ? AppRadius.chip : 6),
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTypography.badgeLabel.copyWith(
          fontWeight: FontWeight.w800,
          color: highlighted ? AppColors.textPrimary : AppColors.textSecondary,
        ),
      ),
    );
  }
}
