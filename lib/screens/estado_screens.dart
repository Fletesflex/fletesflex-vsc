import 'package:flutter/material.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Generic connectivity-error screen, implemented from the Figma
/// "estado-sin-conexion" design (file neRKyJz313WM7CEdoZdgGl, node 2069:287).
/// Not linked from anywhere yet — only the route is registered; wiring it up
/// to real connectivity checks is a TODO for the functional stage.
class SinConexionScreen extends StatelessWidget {
  const SinConexionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusMessageScreen(
      iconAsset: 'assets/icons/wifi_off.svg',
      title: 'Sin conexión',
      message: 'Revisá tu conexión a internet e intentá de nuevo.',
      primaryLabel: 'Reintentar',
      // TODO: retry the failed request once this screen is wired up.
      onPrimary: () => Navigator.of(context).maybePop(),
    );
  }
}

/// Generic error screen, implemented from the Figma
/// "estado-error-generico" design (file neRKyJz313WM7CEdoZdgGl, node
/// 2069:314). Not linked from anywhere yet — only the route is registered;
/// wiring it up to real error states is a TODO for the functional stage.
class AlgoSalioMalScreen extends StatelessWidget {
  const AlgoSalioMalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusMessageScreen(
      iconAsset: 'assets/icons/alert_triangle.svg',
      title: 'Algo salió mal',
      message: 'No pudimos cargar esta pantalla. Probá de nuevo en unos '
          'minutos.',
      primaryLabel: 'Reintentar',
      // TODO: retry the failed request once this screen is wired up.
      onPrimary: () => Navigator.of(context).maybePop(),
      secondaryLabel: 'Volver al inicio',
      onSecondary: () => Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutes.home, (route) => false),
    );
  }
}

/// Blocking account-suspended screen, implemented from the Figma
/// "estado-cuenta-suspendida" design (file neRKyJz313WM7CEdoZdgGl, node
/// 2069:339).
class CuentaSuspendidaScreen extends StatelessWidget {
  const CuentaSuspendidaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusMessageScreen(
      iconAsset: 'assets/icons/ban.svg',
      iconBackground: AppColors.dangerSurface,
      title: 'Tu cuenta está suspendida',
      message: 'Detectamos actividad que no cumple con nuestros términos. '
          'Si creés que es un error, escribinos y lo revisamos.',
      primaryLabel: 'Contactar a soporte',
      // TODO: open the support contact channel.
      onPrimary: () {},
      secondaryLabel: 'Cerrar sesión',
      secondaryColor: AppColors.danger,
      onSecondary: () => Navigator.of(
        context,
      ).pushNamedAndRemoveUntil(AppRoutes.login, (route) => false),
    );
  }
}

/// Camera-permission primer shown before the DNI capture steps, implemented
/// from the Figma "permiso-camara" design (file neRKyJz313WM7CEdoZdgGl, node
/// 2069:363).
class PermisoCamaraScreen extends StatelessWidget {
  const PermisoCamaraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusMessageScreen(
      iconAsset: 'assets/icons/camera.svg',
      iconColor: AppColors.textPrimary,
      title: 'Necesitamos tu cámara',
      message: 'La usamos para sacar la foto de tu DNI y tu selfie. No la '
          'usamos para nada más.',
      primaryLabel: 'Permitir cámara',
      // TODO: request the real camera permission before continuing.
      onPrimary: () =>
          Navigator.of(context).pushReplacementNamed(AppRoutes.capturaDniFrente),
      secondaryLabel: 'Ahora no',
      secondaryColor: AppColors.textSecondary,
      onSecondary: () => Navigator.of(context).maybePop(),
    );
  }
}

/// Location-permission primer, implemented from the Figma
/// "permiso-ubicacion" design (file neRKyJz313WM7CEdoZdgGl, node 2069:387).
/// Not linked from anywhere yet — only the route is registered; wiring it up
/// to the real location permission flow is a TODO for the functional stage.
class PermisoUbicacionScreen extends StatelessWidget {
  const PermisoUbicacionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusMessageScreen(
      iconAsset: 'assets/icons/map_pin.svg',
      title: 'Activá tu ubicación',
      message: 'Así te mostramos pedidos cerca tuyo y completás las '
          'direcciones más rápido.',
      primaryLabel: 'Permitir ubicación',
      // TODO: request the real location permission before continuing.
      onPrimary: () => Navigator.of(context).maybePop(),
      secondaryLabel: 'Ahora no',
      secondaryColor: AppColors.textSecondary,
      onSecondary: () => Navigator.of(context).maybePop(),
    );
  }
}
