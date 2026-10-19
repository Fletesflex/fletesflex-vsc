import 'package:flutter/widgets.dart';

import 'models/rating.dart';
import 'screens/calificacion_screens.dart';
import 'screens/captura_dni_dorso_screen.dart';
import 'screens/captura_dni_frente_screen.dart';
import 'screens/carga_pago_screen.dart';
import 'screens/carga_seguro_vehiculo_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/comprobante_pago_screen.dart';
import 'screens/confirmacion_transportista_screen.dart';
import 'screens/confirmar_solicitud_screen.dart';
import 'screens/datos_vehiculo_screen.dart';
import 'screens/detalle_solicitud_screen.dart';
import 'screens/estado_documentacion_screen.dart';
import 'screens/exito_confirmacion_screen.dart';
import 'screens/flete_confirmacion_screen.dart';
import 'screens/flete_paso1_screen.dart';
import 'screens/flete_paso2_screen.dart';
import 'screens/flete_publicado_screen.dart';
import 'screens/formulario_paso1_screen.dart';
import 'screens/formulario_paso2_screen.dart';
import 'screens/home_screen.dart';
import 'screens/identidad_verificada_ok_screen.dart';
import 'screens/listado_ofertas_screen.dart';
import 'screens/login_screen.dart';
import 'screens/mensajeria_confirmacion_screen.dart';
import 'screens/mensajeria_paso1_screen.dart';
import 'screens/mensajeria_paso2_screen.dart';
import 'screens/mensajeria_publicada_screen.dart';
import 'screens/mis_ofertas_screen.dart';
import 'screens/notificacion_transportista_screen.dart';
import 'screens/oferta_enviada_screen.dart';
import 'screens/pago_resultado_screens.dart';
import 'screens/pago_transferencia_screen.dart';
import 'screens/perfil_transportista_screen.dart';
import 'screens/prueba_de_vida_selfie_screen.dart';
import 'screens/publicacion_activa_screen.dart';
import 'screens/resumen_pago_screen.dart';
import 'screens/resumen_precio_screen.dart';
import 'screens/transportista_solicitudes_screen.dart';
import 'screens/verificacion_intro_screen.dart';
import 'screens/verificacion_procesando_screen.dart';
import 'screens/verificacion_rechazada_screen.dart';
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
  static const String fletePaso2 = '/flete/paso-2';
  static const String fleteConfirmacion = '/flete/confirmacion';
  static const String fletePublicado = '/flete/publicado';

  // Requester: Mensajería request flow.
  static const String mensajeriaPaso1 = '/mensajeria/paso-1';
  static const String mensajeriaPaso2 = '/mensajeria/paso-2';
  static const String mensajeriaConfirmacion = '/mensajeria/confirmacion';
  static const String mensajeriaPublicada = '/mensajeria/publicada';

  // Requester: offers.
  static const String listadoOfertas = '/ofertas';
  static const String perfilTransportista = '/ofertas/perfil';
  static const String confirmacionTransportista = '/ofertas/confirmar';
  static const String exitoConfirmacion = '/ofertas/confirmada';

  // Requester: payment.
  static const String resumenPago = '/pago/resumen';
  static const String cargaPago = '/pago/procesando';
  static const String pagoConfirmado = '/pago/confirmado';
  static const String pagoRechazado = '/pago/rechazado';
  static const String comprobantePago = '/pago/comprobante';
  static const String pagoTransferencia = '/pago/transferencia';
  static const String verificandoTransferencia =
      '/pago/transferencia/verificando';
  static const String transferenciaConfirmada =
      '/pago/transferencia/confirmada';

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
  static const String notificacionTransportista =
      '/transportista/notificacion';

  // Carrier: identity & document verification.
  static const String verificacionIntro = '/transportista/verificacion';
  static const String capturaDniFrente =
      '/transportista/verificacion/dni-frente';
  static const String capturaDniDorso =
      '/transportista/verificacion/dni-dorso';
  static const String pruebaDeVidaSelfie =
      '/transportista/verificacion/selfie';
  static const String verificacionProcesando =
      '/transportista/verificacion/procesando';
  static const String identidadVerificada =
      '/transportista/verificacion/aprobada';
  static const String verificacionRechazada =
      '/transportista/verificacion/rechazada';

  // Carrier: vehicle & document verification (sub-flow B).
  static const String datosVehiculo = '/transportista/verificacion/vehiculo';
  static const String estadoDocumentacion =
      '/transportista/verificacion/documentos';
  static const String cargaSeguroVehiculo =
      '/transportista/verificacion/documentos/seguro';

  /// Route table for [MaterialApp.routes].
  static Map<String, WidgetBuilder> get table => {
    login: (_) => const LoginScreen(),
    home: (_) => const HomeScreen(),
    fletePaso1: (_) => const FletePaso1Screen(),
    fletePaso2: (_) => const FletePaso2Screen(),
    fleteConfirmacion: (_) => const FleteConfirmacionScreen(),
    fletePublicado: (_) => const FletePublicadoScreen(),
    mensajeriaPaso1: (_) => const MensajeriaPaso1Screen(),
    mensajeriaPaso2: (_) => const MensajeriaPaso2Screen(),
    mensajeriaConfirmacion: (_) => const MensajeriaConfirmacionScreen(),
    mensajeriaPublicada: (_) => const MensajeriaPublicadaScreen(),
    formularioPaso1: (_) => const FormularioPaso1Screen(),
    formularioPaso2: (_) => const FormularioPaso2Screen(),
    resumenPrecio: (_) => const ResumenPrecioScreen(),
    publicacionActiva: (_) => const PublicacionActivaScreen(),
    listadoOfertas: (_) => const ListadoOfertasScreen(),
    perfilTransportista: (_) => const PerfilTransportistaScreen(),
    confirmacionTransportista: (_) => const ConfirmacionTransportistaScreen(),
    exitoConfirmacion: (_) => const ExitoConfirmacionScreen(),
    resumenPago: (_) => const ResumenPagoScreen(),
    cargaPago: (_) => const CargaPagoScreen(),
    pagoConfirmado: (_) => const PagoConfirmadoScreen(),
    pagoRechazado: (_) => const PagoRechazadoScreen(),
    comprobantePago: (_) => const ComprobantePagoScreen(),
    pagoTransferencia: (_) => const PagoTransferenciaScreen(),
    verificandoTransferencia: (_) => const VerificandoTransferenciaScreen(),
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
    confirmacionCalificacion: (_) => const ConfirmacionCalificacionScreen(),
    perfilCalificaciones: (_) => const PerfilCalificacionesScreen(),
    historialSolicitante: (_) =>
        const HistorialServiciosScreen(target: RatingTarget.carrier),
    historialTransportista: (_) =>
        const HistorialServiciosScreen(target: RatingTarget.requester),
    transportistaSolicitudes: (_) => const TransportistaSolicitudesScreen(),
    detalleSolicitud: (_) => const DetalleSolicitudScreen(),
    confirmarSolicitud: (_) => const ConfirmarSolicitudScreen(),
    confirmacionOfertaEnviada: (_) => const OfertaEnviadaScreen(),
    misOfertas: (_) => const MisOfertasScreen(),
    notificacionTransportista: (_) => const NotificacionTransportistaScreen(),
    verificacionIntro: (_) => const VerificacionIntroScreen(),
    capturaDniFrente: (_) => const CapturaDniFrenteScreen(),
    capturaDniDorso: (_) => const CapturaDniDorsoScreen(),
    pruebaDeVidaSelfie: (_) => const PruebaDeVidaSelfieScreen(),
    verificacionProcesando: (_) => const VerificacionProcesandoScreen(),
    identidadVerificada: (_) => const IdentidadVerificadaOkScreen(),
    verificacionRechazada: (_) => const VerificacionRechazadaScreen(),
    datosVehiculo: (_) => const DatosVehiculoScreen(),
    estadoDocumentacion: (_) => const EstadoDocumentacionScreen(),
    cargaSeguroVehiculo: (_) => const CargaSeguroVehiculoScreen(),
  };
}
