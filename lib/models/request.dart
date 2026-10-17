import 'service_type.dart';

/// A transport request as seen by carriers in the marketplace.
class TransportRequest {
  const TransportRequest({
    required this.type,
    required this.route,
    required this.when,
    required this.distance,
    required this.referencePrice,
    required this.postedAgo,
    this.requirements = const [],
  });

  final ServiceType type;

  /// "Palermo → Belgrano".
  final String route;

  /// "Sáb 12 Oct · 09:00".
  final String when;

  /// "~4.2 km".
  final String distance;

  /// Client's reference price in whole ARS.
  final int referencePrice;

  /// "Hace 5 min" / "Urgente ⚡".
  final String postedAgo;

  /// (icon asset, label) pairs, e.g. helpers or stairs.
  final List<(String, String)> requirements;
}

/// Sample data mirroring the Figma mockups until the API is wired up.
abstract final class SampleRequests {
  static const all = [
    TransportRequest(
      type: ServiceType.mudanza,
      route: 'Palermo → Belgrano',
      when: 'Sáb 12 Oct · 09:00',
      distance: '~4.2 km',
      referencePrice: 45000,
      postedAgo: 'Hace 5 min',
      requirements: [
        ('assets/icons/users_muted.svg', 'Ayudantes (2)'),
        ('assets/icons/trending_up_muted.svg', 'Escalera'),
      ],
    ),
    TransportRequest(
      type: ServiceType.flete,
      route: 'Caballito → Avellaneda',
      when: 'Lun 14 Oct · 14:00',
      distance: '~8.7 km',
      referencePrice: 30000,
      postedAgo: 'Hace 15 min',
    ),
    TransportRequest(
      type: ServiceType.mensajeria,
      route: 'Recoleta → Microcentro',
      when: 'Hoy · 16:30',
      distance: '~3.1 km',
      referencePrice: 12000,
      postedAgo: 'Urgente ⚡',
    ),
  ];
}
