/// Who is being rated.
enum RatingTarget {
  /// The requester rates the carrier.
  carrier(
    name: 'Carlos Méndez',
    role: 'Transportista',
    avatarAsset: 'assets/images/avatar_carlos_rate.png',
    screenTitle: 'Calificar servicio',
    tags: [
      'Puntualidad',
      'Cuidado de objetos',
      'Buen trato',
      'Vehículo en buen estado',
    ],
  ),

  /// The carrier rates the requester.
  requester(
    name: 'María González',
    role: 'Solicitante',
    avatarAsset: 'assets/images/avatar_maria_rate.png',
    screenTitle: 'Calificar solicitante',
    tags: [
      'Puntualidad',
      'Claridad en instrucciones',
      'Buen trato',
      'Objetos correctamente descriptos',
    ],
  );

  const RatingTarget({
    required this.name,
    required this.role,
    required this.avatarAsset,
    required this.screenTitle,
    required this.tags,
  });

  // TODO: these sample people mirror Figma; take them from the service.
  final String name;
  final String role;
  final String avatarAsset;
  final String screenTitle;

  /// Selectable "¿Qué te gustó?" tags.
  final List<String> tags;
}

/// A submitted rating, passed to the confirmation screen.
class RatingResult {
  const RatingResult({
    required this.target,
    required this.stars,
    required this.tags,
    this.comment = '',
  });

  final RatingTarget target;
  final int stars;
  final List<String> tags;
  final String comment;
}
