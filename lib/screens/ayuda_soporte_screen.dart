import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../widgets/widgets.dart';

class _Faq {
  const _Faq(this.question, this.answer);

  final String question;
  final String answer;
}

/// Help & support screen, implemented from the Figma "ayuda-soporte" design
/// (file neRKyJz313WM7CEdoZdgGl, node 2064:57). The FAQ list expands one
/// question at a time. Visual only — contact actions are TODOs.
class AyudaSoporteScreen extends StatefulWidget {
  const AyudaSoporteScreen({super.key});

  @override
  State<AyudaSoporteScreen> createState() => _AyudaSoporteScreenState();
}

class _AyudaSoporteScreenState extends State<AyudaSoporteScreen> {
  static const _faqs = [
    _Faq(
      '¿Cómo se paga el servicio?',
      'Pagás desde la app con Mercado Pago o por transferencia. El '
          'servicio queda reservado una vez acreditado el pago.',
    ),
    _Faq(
      '¿Puedo cancelar un servicio?',
      'Sí, podés cancelar desde "Mis servicios" antes de que el '
          'transportista inicie el traslado.',
    ),
    _Faq(
      '¿Qué pasa si el transportista no llega?',
      'Contactate con soporte desde el chat del servicio y te ayudamos a '
          'reasignar o reembolsar el pedido.',
    ),
    _Faq(
      '¿Cómo verifican a los transportistas?',
      'Validamos su identidad, documentación del vehículo y antecedentes '
          'antes de habilitarlos en la plataforma.',
    ),
  ];

  int? _openIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AppPage(
      header: const AppPageHeader(
        title: 'Ayuda y soporte',
        subtitle: '¿En qué te podemos ayudar?',
      ),
      children: [
        IconLinkCard(
          borderColor: AppColors.accent,
          borderWidth: 2,
          rows: [
            IconLinkRow(
              iconAsset: 'assets/icons/message_circle.svg',
              title: 'Escribinos por WhatsApp',
              subtitle: 'Hablá con una persona del equipo. Te respondemos '
                  'lo antes posible.',
              onTap: () {
                // TODO: open WhatsApp with the support contact.
              },
            ),
            IconLinkRow(
              iconAsset: 'assets/icons/mail.svg',
              title: 'Mandanos un mail',
              subtitle: 'soporte@fletesflex.com',
              onTap: () {
                // TODO: open the mail client with the support address.
              },
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        const ProfileSectionLabel('PREGUNTAS FRECUENTES'),
        const SizedBox(height: AppSpacing.xs),
        FaqCard(
          rows: [
            for (final (i, faq) in _faqs.indexed)
              FaqRow(
                question: faq.question,
                answer: faq.answer,
                expanded: _openIndex == i,
                onTap: () => setState(() {
                  _openIndex = _openIndex == i ? null : i;
                }),
              ),
          ],
        ),
      ],
    );
  }
}
