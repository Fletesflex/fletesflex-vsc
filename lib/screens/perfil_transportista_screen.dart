import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/offer.dart';
import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Carrier public profile, implemented from the Figma
/// "perfil-publico-transportista" design (file o7nkeARTqRUSPsNBaYg2nb,
/// node 4:58). Receives the [Offer] being viewed as the route argument.
class PerfilTransportistaScreen extends StatelessWidget {
  const PerfilTransportistaScreen({super.key, this.showChooseAction = true});

  /// Hide the sticky "Elegir esta oferta" bar when the profile is opened
  /// outside of an offer context.
  final bool showChooseAction;

  // TODO: load the full profile from the API; values below mirror Figma.
  static const _features = [
    ('assets/icons/users.svg', '2 Ayudantes'),
    ('assets/icons/anchor.svg', 'Sogas'),
    ('assets/icons/trending_up.svg', 'Escalera'),
    ('assets/icons/shield.svg', 'Mantas de protección'),
    ('assets/icons/truck_xs.svg', 'Carro de carga'),
  ];
  static const _specialties = [
    'Mudanzas grandes',
    'Objetos frágiles',
    'Electrodomésticos',
    'Pianos y objetos pesados',
  ];
  static const _reviews = [
    _Review(
      author: 'Ana L.',
      avatarAsset: 'assets/images/avatar_ana.png',
      when: 'Hace 2 semanas',
      stars: 5,
      text: 'Excelente servicio. Llegó puntual, muy cuidadoso con los '
          'muebles. Súper recomendable.',
    ),
    _Review(
      author: 'Carlos M.',
      avatarAsset: 'assets/images/avatar_carlos.png',
      when: 'Hace 1 mes',
      stars: 4,
      text: 'Muy buen trabajo, rápido y prolijo. Los ayudantes fueron muy '
          'amables.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final offer = ModalRoute.of(context)?.settings.arguments as Offer?;

    return AppPage(
      title: 'Perfil del transportista',
      topBarStyle: TopBarStyle.centered,
      bodyPadding: EdgeInsets.zero,
      elevatedBottom: true,
      bottom: showChooseAction
          ? SizedBox(
              height: 52,
              child: PrimaryButton(
                label: 'Elegir esta oferta',
                onPressed: () => Navigator.of(context).pushNamed(
                  AppRoutes.exitoConfirmacion,
                  arguments: offer,
                ),
              ),
            )
          : null,
      children: [
        _Hero(
          carrier: offer?.carrier ??
              const Carrier(
                name: 'Martín Rodríguez',
                avatarAsset: 'assets/images/avatar_martin.png',
                rating: 4.9,
                completedJobs: 127,
              ),
        ),
        const AppDivider(),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const ProfileSection(
                iconAsset: 'assets/icons/truck_sm.svg',
                title: 'Vehículo',
                child: _VehicleCard(),
              ),
              const SizedBox(height: AppSpacing.lg),
              ProfileSection(
                iconAsset: 'assets/icons/briefcase.svg',
                title: 'Experiencia',
                child: _ExperienceCard(specialties: _specialties),
              ),
              const SizedBox(height: AppSpacing.lg),
              ProfileSection(
                iconAsset: 'assets/icons/toolbox.svg',
                title: 'Equipo disponible',
                child: _EquipmentCard(features: _features),
              ),
              const SizedBox(height: AppSpacing.lg),
              ProfileSection(
                iconAsset: 'assets/icons/star_section.svg',
                title: 'Reseñas',
                count: 127,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final (i, review) in _reviews.indexed) ...[
                      if (i > 0) const SizedBox(height: AppSpacing.sm),
                      ReviewCard(
                        author: review.author,
                        avatarAsset: review.avatarAsset,
                        when: review.when,
                        stars: review.stars,
                        text: review.text,
                      ),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    Center(
                      child: TextLinkButton(
                        label: 'Ver todas las reseñas',
                        color: AppColors.textPrimary,
                        onPressed: () {
                          // TODO: open the full reviews list.
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Review {
  const _Review({
    required this.author,
    required this.avatarAsset,
    required this.when,
    required this.stars,
    required this.text,
  });

  final String author;
  final String avatarAsset;
  final String when;
  final int stars;
  final String text;
}

class _Hero extends StatelessWidget {
  const _Hero({required this.carrier});

  final Carrier carrier;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          AppAvatar(
            carrier.avatarAsset,
            size: 100,
            ringColor: AppColors.accent,
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xxs,
            children: [
              Text(carrier.name, style: AppTypography.sectionTitle),
              const VerifiedBadge(),
            ],
          ),
          const SizedBox(height: 6),
          RatingRow(
            rating: carrier.rating,
            suffix: '• ${carrier.completedJobs} viajes realizados',
            large: true,
          ),
        ],
      ),
    );
  }
}

class _VehicleCard extends StatelessWidget {
  const _VehicleCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      radius: AppRadius.xl,
      shadow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: Image.asset(
              'assets/images/vehicle_ducato.png',
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 14),
          Text('Fiat Ducato Maxi', style: AppTypography.cardTitle),
          const SizedBox(height: AppSpacing.xxs),
          Text('Furgón cerrado', style: AppTypography.itemTitle),
          const SizedBox(height: AppSpacing.xxs),
          Text(
            'Capacidad: 14 m³ · hasta 1.200 kg',
            style: AppTypography.routeText,
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({required this.specialties});

  final List<String> specialties;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      radius: AppRadius.xl,
      shadow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/calendar.svg',
                width: 18,
                height: 18,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '3 años en FletesFlex',
                style: AppTypography.itemTitle.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          const AppDivider(thin: true),
          const SizedBox(height: AppSpacing.md),
          Text(
            'ESPECIALIDADES',
            style: AppTypography.priceCaption.copyWith(
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [for (final s in specialties) OutlinedPill(s)],
          ),
        ],
      ),
    );
  }
}

class _EquipmentCard extends StatelessWidget {
  const _EquipmentCard({required this.features});

  final List<(String, String)> features;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      radius: AppRadius.xl,
      shadow: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Martín cuenta con las siguientes herramientas para asegurar que '
            'tu traslado se realice de forma segura y profesional:',
            style: AppTypography.cardDescription,
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              for (final (icon, label) in features)
                FeatureChip(iconAsset: icon, label: label),
            ],
          ),
        ],
      ),
    );
  }
}
