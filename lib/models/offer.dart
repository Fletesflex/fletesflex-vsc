/// A carrier (fletero/transportista) as shown on offers and profiles.
class Carrier {
  const Carrier({
    required this.name,
    required this.avatarAsset,
    required this.rating,
    required this.completedJobs,
  });

  final String name;

  // TODO: switch to a network URL once profiles come from the API.
  final String avatarAsset;
  final double rating;
  final int completedJobs;
}

/// A carrier's bid on a request.
class Offer {
  const Offer({
    required this.carrier,
    required this.price,
    required this.vehicle,
    required this.note,
  });

  final Carrier carrier;

  /// Final price in whole ARS.
  final int price;
  final String vehicle;
  final String note;
}

/// Sample data mirroring the Figma mockups until the API is wired up.
abstract final class SampleOffers {
  static const andres = Offer(
    carrier: Carrier(
      name: 'Andrés G.',
      avatarAsset: 'assets/images/avatar_andres.png',
      rating: 4.9,
      completedJobs: 184,
    ),
    price: 145000,
    vehicle: 'Ford Transit Grande',
    note: 'Cuenta con 2 peones para carga rápida. Sogas y frazadas '
        'protectoras.',
  );

  static const all = [
    andres,
    Offer(
      carrier: Carrier(
        name: 'Esteban R.',
        avatarAsset: 'assets/images/avatar_esteban.png',
        rating: 4.7,
        completedJobs: 92,
      ),
      price: 145000,
      vehicle: 'Mercedes Sprinter XL',
      note: 'Servicio súper puntual. Ayudo yo mismo y un peón adicional.',
    ),
    Offer(
      carrier: Carrier(
        name: 'Fletes Almagro',
        avatarAsset: 'assets/images/avatar_fletes_almagro.png',
        rating: 4.8,
        completedJobs: 312,
      ),
      price: 145000,
      vehicle: 'Camión Mudancero',
      note: 'Flota profesional. Caja cerrada. Emitimos factura si precisa.',
    ),
  ];
}
