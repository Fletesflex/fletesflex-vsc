import 'package:flutter/widgets.dart';

import 'models/rating.dart';
import 'screens/calificacion_screens.dart';
import 'screens/carga_pago_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/comprobante_pago_screen.dart';
import 'screens/confirmar_solicitud_screen.dart';
import 'screens/detalle_solicitud_screen.dart';
import 'screens/exito_confirmacion_screen.dart';
import 'screens/flete_paso1_screen.dart';
import 'screens/formulario_paso1_screen.dart';
import 'screens/formulario_paso2_screen.dart';
import 'screens/home_screen.dart';
import 'screens/listado_ofertas_screen.dart';
import 'screens/login_screen.dart';
import 'screens/mis_ofertas_screen.dart';
import 'screens/oferta_enviada_screen.dart';
import 'screens/pago_resultado_screens.dart';
import 'screens/pago_transferencia_screen.dart';
import 'screens/perfil_transportista_screen.dart';
import 'screens/publicacion_activa_screen.dart';
import 'screens/resumen_pago_screen.dart';
import 'screens/resumen_precio_screen.dart';
import 'screens/transportista_solicitudes_screen.dart';
import 'screens/verificando_transferencia_screen.dart';

/// Named route paths for the app's screens.
abstract final class AppRoutes {
  static const String login = '/';
  static const String home = '/home';

  // Requester: Mudanza request flow.
  static const String formularioPaso1 = '/mudanza/paso-1';
  static const String formularioPaso2 = '/mudanza/paso-2';
  static const String resumenPrecio = '/mudanza/resumen';
  static const String publicacionActiva = '/mudanza/publicada';

  // Requester: Flete request flow.
  static const String fletePaso1 = '/flete/paso-1';

  // Requester: offers.
  static const String listadoOfertas = '/ofertas';
  static const String perfilTransportista = '/ofertas/perfil';
  static const String exitoConfirmacion = '/ofertas/confirmada';

  // Requester: payment.
  static const String resumenPago = '/pago/resumen';
  static const String cargaPago = '/pago/procesando';
  static const String pagoConfirmado = '/pago/confirmado';
  static const String pagoRechazado = '/pago/rechazado';
  static const String comprobantePago = '/pago/comprobante';
  static const String pagoTransferencia = '/pago/transferencia';
  static const String verificandoTransferencia = '/pago/transferencia/verificando';
  static const String transferenciaConfirmada = '/pago/transferencia/confirmada';

  // Chat.
  static const String chat = '/chat';
  static const String chatArchivado = '/chat/archivado';
  static const String reporteProblema = '/chat/reporte';

  // Ratings.
  static const String avisoCalificacionSolicitante = '/calificar/aviso';
  static const String avisoCalificacionTransportista =
      '/transportista/calificar/aviso';
  static const String bloqueoCalificacion = '/calificar/pendiente';

  /// Requester rates the carrier.
  static const String calificacionSolicitante = '/calificar';

  /// Carrier rates the requester.
  static const String calificacionTransportista = '/transportista/calificar';
  static const String confirmacionCalificacion = '/calificar/gracias';
  static const String perfilCalificaciones = '/transportista/calificaciones';
  static const String historialSolicitante = '/servicios';
  static const String historialTransportista = '/transportista/servicios';

  // Carrier.
  static const String transportistaSolicitudes = '/transportista';
  static const String detalleSolicitud = '/transportista/solicitud';
  static const String confirmarSolicitud = '/transportista/solicitud/tomar';
  static const String confirmacionOfertaEnviada =
      '/transportista/solicitud/enviada';
  static const String misOfertas = '/transportista/ofertas';

  /// Route table for [MaterialApp.routes].
  static Map<String, WidgetBuilder> get table => {
        login: (_) => const LoginScreen(),
        home: (_) => const HomeScreen(),
        fletePaso1: (_) => const FletePaso1Screen(),
        formularioPaso1: (_) => const FormularioPaso1Screen(),
        formularioPaso2: (_) => const FormularioPaso2Screen(),
        resumenPrecio: (_) => const ResumenPrecioScreen(),
        publicacionActiva: (_) => const PublicacionActivaScreen(),
        listadoOfertas: (_) => const ListadoOfertasScreen(),
        perfilTransportista: (_) => const PerfilTransportistaScreen(),
        exitoConfirmacion: (_) => const ExitoConfirmacionScreen(),
        resumenPago: (_) => const ResumenPagoScreen(),
        cargaPago: (_) => const CargaPagoScreen(),
        pagoConfirmado: (_) => const PagoConfirmadoScreen(),
        pagoRechazado: (_) => const PagoRechazadoScreen(),
        comprobantePago: (_) => const ComprobantePagoScreen(),
        pagoTransferencia: (_) => const PagoTransferenciaScreen(),
        verificandoTransferencia: (_) =>
            const VerificandoTransferenciaScreen(),
        transferenciaConfirmada: (_) =>
            const PagoConfirmadoScreen(byTransfer: true),
        chat: (_) => const ChatScreen(),
        chatArchivado: (_) => const ChatScreen(archived: true),
        reporteProblema: (_) => const ChatScreen(openReportOnStart: true),
        avisoCalificacionSolicitante: (_) => const RatingPromptHost(
              target: RatingTarget.carrier,
              child: HomeScreen(),
            ),
        avisoCalificacionTransportista: (_) => const RatingPromptHost(
              target: RatingTarget.requester,
              child: TransportistaSolicitudesScreen(),
            ),
        bloqueoCalificacion: (_) => const BloqueoCalificacionScreen(),
        calificacionSolicitante: (_) =>
            const CalificarScreen(target: RatingTarget.carrier),
        calificacionTransportista: (_) =>
            const CalificarScreen(target: RatingTarget.requester),
        confirmacionCalificacion: (_) =>
            const ConfirmacionCalificacionScreen(),
        perfilCalificaciones: (_) => const PerfilCalificacionesScreen(),
        historialSolicitante: (_) =>
            const HistorialServiciosScreen(target: RatingTarget.carrier),
        historialTransportista: (_) =>
            const HistorialServiciosScreen(target: RatingTarget.requester),
        transportistaSolicitudes: (_) =>
            const TransportistaSolicitudesScreen(),
        detalleSolicitud: (_) => const DetalleSolicitudScreen(),
        confirmarSolicitud: (_) => const ConfirmarSolicitudScreen(),
        confirmacionOfertaEnviada: (_) => const OfertaEnviadaScreen(),
        misOfertas: (_) => const MisOfertasScreen(),
      };
}
