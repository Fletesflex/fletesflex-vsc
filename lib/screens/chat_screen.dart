import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// A chat message. [location] messages render as a map card.
class ChatMessage {
  const ChatMessage({
    required this.text,
    required this.time,
    required this.mine,
    this.moderated = false,
    this.location,
  });

  final String text;
  final String time;

  /// Sent by the current user (yellow bubble on the right).
  final bool mine;

  /// Contact data was masked by the moderation filter.
  final bool moderated;

  /// (street, area) of a shared location.
  final (String, String)? location;
}

/// Masks phone numbers and e-mails ("11 5555 5555" → "** **** ****").
/// Returns null when nothing had to be masked.
String? moderateContactData(String text) {
  final pattern = RegExp(
    r'[\w.+-]+@[\w-]+\.[\w.]+|(?:\+?\d[\d\s-]{6,}\d)',
  );
  if (!pattern.hasMatch(text)) return null;
  return text.replaceAllMapped(
    pattern,
    (m) => m.group(0)!.replaceAll(RegExp(r'[^\s]'), '*'),
  );
}

/// Moderated requester ↔ carrier chat, implemented from the Figma designs
/// "chat-moderado" (35:4), "chat-moderacion-activa" (35:95),
/// "chat-respuestas-rapidas" (35:190), "reporte-problema" (35:303) and
/// "chat-archivado" (35:422) (file o7nkeARTqRUSPsNBaYg2nb).
///
/// These are states of one screen: sending contact data triggers the
/// moderation warning, quick replies sit above the input, the menu opens
/// the report sheet, and [archived] shows the read-only finished variant.
class ChatScreen extends StatefulWidget {
  const ChatScreen({
    super.key,
    this.archived = false,
    this.openReportOnStart = false,
  });

  final bool archived;

  /// Open the "¿Qué pasó?" report sheet right away (support entry point).
  final bool openReportOnStart;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // TODO: load the conversation from the API; samples mirror Figma.
  static const _contactName = 'Carlos M.';
  static const _quickReplies = [
    'Ya llegué',
    'Estoy en camino',
    '¿Coordinamos horario?',
    'Compartir ubicación',
  ];

  final _input = TextEditingController();
  final _scroll = ScrollController();
  late final List<ChatMessage> _messages = widget.archived
      ? const [
          ChatMessage(
            text: 'Ya estoy abajo, ¿bajo por las cosas?',
            time: '10:14',
            mine: false,
          ),
          ChatMessage(text: 'Sí, te abro. Subí al 4to B', time: '10:15', mine: true),
          ChatMessage(
            text: 'Listo, ya cargué todo en la Fiorino',
            time: '10:18',
            mine: false,
          ),
          ChatMessage(
            text: 'Genial, muchas gracias Carlos!',
            time: '10:19',
            mine: true,
          ),
          ChatMessage(
            text: 'Ya llegamos a Belgrano, ¿dónde dejo las cosas?',
            time: '10:45',
            mine: false,
          ),
          ChatMessage(text: 'En el living, te abro', time: '10:47', mine: true),
        ]
      : [
          const ChatMessage(
            text: '¡Hola Lucía! Confirmo que llego el sábado a las 10 en '
                'punto.',
            time: '14:02',
            mine: false,
          ),
          const ChatMessage(
            text: 'Llevo mantas para proteger los muebles, ¿tenés cajas o '
                'necesitás que lleve?',
            time: '14:03',
            mine: false,
          ),
          const ChatMessage(
            text: '¡Genial, gracias Carlos!',
            time: '14:05',
            mine: true,
          ),
          const ChatMessage(
            text: 'Tengo algunas cajas pero si podés traer unas extras mejor.',
            time: '14:06',
            mine: true,
          ),
        ];

  @override
  void initState() {
    super.initState();
    if (widget.openReportOnStart) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _openReport());
    }
  }

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  String get _now {
    final t = TimeOfDay.now();
    return '${t.hour.toString().padLeft(2, '0')}:'
        '${t.minute.toString().padLeft(2, '0')}';
  }

  void _send(String raw) {
    final text = raw.trim();
    if (text.isEmpty) return;
    final masked = moderateContactData(text);
    setState(() {
      _messages.add(
        ChatMessage(
          text: masked ?? text,
          time: _now,
          mine: true,
          moderated: masked != null,
        ),
      );
      _input.clear();
    });
    _scrollToEnd();
  }

  void _shareLocation() {
    // TODO: use the device location.
    setState(() {
      _messages.add(
        ChatMessage(
          text: '',
          time: _now,
          mine: true,
          location: ('Av. Santa Fe 3200', 'Palermo, CABA'),
        ),
      );
    });
    _scrollToEnd();
  }

  void _onQuickReply(String reply) {
    if (reply == 'Compartir ubicación') {
      _shareLocation();
    } else {
      _send(reply);
    }
  }

  void _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scroll.hasClients) return;
      _scroll.animateTo(
        _scroll.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _openReport() async {
    final sent = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      barrierColor: AppColors.scrim,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.lg),
        ),
      ),
      builder: (_) => const ReportProblemSheet(),
    );
    if (sent == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recibimos tu reporte. Te contactamos pronto.')),
      );
    }
  }

  void _openMenu() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      builder: (sheetContext) => SafeArea(
        child: ListTile(
          leading: SvgPicture.asset(
            'assets/icons/alert_triangle.svg',
            width: 18,
            height: 18,
          ),
          title: Text('Reportar un problema', style: AppTypography.itemTitle),
          onTap: () {
            Navigator.of(sheetContext).pop();
            _openReport();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final archived = widget.archived;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _Header(
            name: _contactName,
            archived: archived,
            onMenu: _openMenu,
          ),
          if (!archived) const _SecurityBanner(),
          Expanded(
            child: ListView.separated(
              controller: _scroll,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.lg,
              ),
              itemCount: _messages.length,
              separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (_, i) => _MessageRow(message: _messages[i]),
            ),
          ),
          if (archived)
            _ArchivedFooter(
              contactFirstName: _contactName.split(' ').first,
            )
          else
            _Composer(
              controller: _input,
              quickReplies: _quickReplies,
              onQuickReply: _onQuickReply,
              onSend: () => _send(_input.text),
            ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.name,
    required this.archived,
    required this.onMenu,
  });

  final String name;
  final bool archived;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            offset: const Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.xs,
            AppSpacing.md,
            AppSpacing.sm,
          ),
          child: Row(
            children: [
              _HeaderIcon(
                asset: archived
                    ? 'assets/icons/chevron_left_bold.svg'
                    : 'assets/icons/chevron_left.svg',
                onTap: () => Navigator.of(context).maybePop(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AppAvatar(
                      'assets/images/avatar_carlos_chat.png',
                      size: 40,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(name, style: AppTypography.userName),
                            const SizedBox(width: 6),
                            SvgPicture.asset(
                              archived
                                  ? 'assets/icons/offline_dot.svg'
                                  : 'assets/icons/dot_success.svg',
                              width: 6,
                              height: 6,
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: archived ? AppSpacing.xs : 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: archived
                                ? AppColors.border
                                : AppColors.iconSurface,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            archived ? 'FINALIZADO' : 'CHAT MODERADO',
                            style: AppTypography.navLabel.copyWith(
                              fontWeight: FontWeight.bold,
                              color: archived
                                  ? AppColors.archivedText
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _HeaderIcon(
                asset: archived
                    ? 'assets/icons/menu.svg'
                    : 'assets/icons/more_vertical.svg',
                onTap: onMenu,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({required this.asset, required this.onTap});

  final String asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 20,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Center(
          child: SvgPicture.asset(asset, width: 20, height: 20),
        ),
      ),
    );
  }
}

class _SecurityBanner extends StatelessWidget {
  const _SecurityBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: 10,
      ),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.iconSurface)),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.iconSurface,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/shield.svg',
              width: 14,
              height: 14,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Por tu seguridad, no compartas datos de contacto personal o de '
              'pago fuera de la app.',
              style: AppTypography.helper.copyWith(height: 16 / 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageRow extends StatelessWidget {
  const _MessageRow({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final bubble = _Bubble(message: message);

    if (!message.mine) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const AppAvatar('assets/images/avatar_carlos_mini.png', size: 28),
          const SizedBox(width: AppSpacing.xs),
          Flexible(child: bubble),
          const SizedBox(width: 40),
        ],
      );
    }

    final row = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(width: 40),
        if (message.moderated) ...[
          Container(
            width: 24,
            height: 24,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppColors.iconSurface,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/alert_triangle.svg',
              width: 14,
              height: 14,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
        Flexible(child: bubble),
      ],
    );
    if (!message.moderated) return row;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        row,
        const SizedBox(height: 6),
        Container(
          constraints: const BoxConstraints(maxWidth: 280),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
          decoration: BoxDecoration(
            color: AppColors.iconSurface,
            borderRadius: BorderRadius.circular(AppRadius.chip),
          ),
          child: Text(
            'No podés compartir datos de contacto por acá. Todo lo importante '
            'lo coordinamos dentro del chat.',
            style: AppTypography.micro.copyWith(
              color: AppColors.textPrimary,
              height: 16 / 11,
            ),
          ),
        ),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final mine = message.mine;
    final timeStyle = AppTypography.chatTime.copyWith(
      color: mine
          ? AppColors.textPrimary.withValues(alpha: 0.8)
          : AppColors.textMuted,
    );
    final location = message.location;

    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      padding: location != null
          ? const EdgeInsets.all(10)
          : const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: mine ? AppColors.accent : AppColors.surface,
        border: message.moderated
            ? Border.all(
                color: AppColors.accent.withValues(alpha: 0.25),
                width: 2,
              )
            : null,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(18),
          topRight: const Radius.circular(18),
          bottomLeft: Radius.circular(mine ? 18 : 4),
          bottomRight: Radius.circular(mine ? 4 : 18),
        ),
        boxShadow: mine
            ? null
            : [
                BoxShadow(
                  color: AppColors.textPrimary.withValues(alpha: 0.03),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (location != null) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.sm),
              child: SizedBox(
                height: 130,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/map_snippet.png',
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: const Alignment(0, -0.15),
                      child: SvgPicture.asset(
                        'assets/icons/map_pin_lg.svg',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/arrow_up_right.svg',
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.$1,
                        style: AppTypography.itemTitle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        location.$2,
                        style: AppTypography.micro.copyWith(
                          color: AppColors.textPrimary.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
          ] else ...[
            Text(message.text, style: AppTypography.chatMessage),
            const SizedBox(height: AppSpacing.xxs),
          ],
          Text(message.time, style: timeStyle, textAlign: TextAlign.right),
        ],
      ),
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.quickReplies,
    required this.onQuickReply,
    required this.onSend,
  });

  final TextEditingController controller;
  final List<String> quickReplies;
  final ValueChanged<String> onQuickReply;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.xxs,
              ),
              child: Row(
                children: [
                  for (final (i, reply) in quickReplies.indexed) ...[
                    if (i > 0) const SizedBox(width: AppSpacing.xs),
                    InkWell(
                      onTap: () => onQuickReply(reply),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          border: Border.all(color: AppColors.accent),
                          borderRadius: BorderRadius.circular(AppRadius.md),
                        ),
                        child: Text(
                          reply,
                          style: AppTypography.helper.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                children: [
                  _RoundButton(
                    size: 40,
                    color: AppColors.iconSurface,
                    asset: 'assets/icons/camera_dark.svg',
                    onTap: () {
                      // TODO: attach a photo.
                    },
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              textInputAction: TextInputAction.send,
                              onSubmitted: (_) => onSend(),
                              cursorColor: AppColors.accent,
                              style: AppTypography.chatMessage,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                filled: false,
                                hintText: 'Escribí un mensaje...',
                                hintStyle: AppTypography.chatMessage.copyWith(
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/icons/smile.svg',
                            width: 20,
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  _RoundButton(
                    size: 44,
                    color: AppColors.textPrimary,
                    asset: 'assets/icons/send.svg',
                    onTap: onSend,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
          ],
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.size,
    required this.color,
    required this.asset,
    required this.onTap,
  });

  final double size;
  final Color color;
  final String asset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: size,
          height: size,
          child: Center(child: SvgPicture.asset(asset, width: 20, height: 20)),
        ),
      ),
    );
  }
}

class _ArchivedFooter extends StatelessWidget {
  const _ArchivedFooter({required this.contactFirstName});

  final String contactFirstName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.md,
            AppSpacing.sm,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        color: AppColors.border,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/lock.svg',
                        width: 18,
                        height: 18,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Este servicio finalizó. El chat quedó archivado.',
                        style: AppTypography.checkLabel.copyWith(
                          color: AppColors.textSecondary,
                          height: 18 / 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              PrimaryButton(
                label: 'Calificar a $contactFirstName',
                leading: SvgPicture.asset(
                  'assets/icons/star_outline_md.svg',
                  width: 16,
                  height: 16,
                ),
                onPressed: () => Navigator.of(context).pushNamed(
                  AppRoutes.calificacionSolicitante,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// "¿Qué pasó?" bottom sheet: reason radio list, free text and submit.
/// Pops `true` when the report is sent.
class ReportProblemSheet extends StatefulWidget {
  const ReportProblemSheet({super.key});

  @override
  State<ReportProblemSheet> createState() => _ReportProblemSheetState();
}

class _ReportProblemSheetState extends State<ReportProblemSheet> {
  static const _reasons = [
    'El transportista no llegó',
    'Me pidieron pagar por fuera de la app',
    'Hubo un problema con los objetos',
    'Comportamiento inapropiado',
    'Otro',
  ];

  String? _reason;
  final _details = TextEditingController();

  @override
  void dispose() {
    _details.dispose();
    super.dispose();
  }

  void _submit() {
    // TODO: send the report to the API.
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.sm,
            AppSpacing.lg,
            AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.dragHandle,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text('¿Qué pasó?', style: AppTypography.headline),
              const SizedBox(height: AppSpacing.sectionGap),
              for (final reason in _reasons)
                InkWell(
                  onTap: () => setState(() => _reason = reason),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.sm,
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          reason == _reason
                              ? 'assets/icons/radio_on.svg'
                              : 'assets/icons/radio_off.svg',
                          width: 22,
                          height: 22,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            reason,
                            style: AppTypography.body.copyWith(
                              color: AppColors.textPrimary,
                              height: 1.2,
                              fontWeight: reason == _reason
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: AppSpacing.sectionGap),
              TextField(
                controller: _details,
                minLines: 3,
                maxLines: 5,
                cursorColor: AppColors.accent,
                style: AppTypography.fieldValue,
                decoration: InputDecoration(
                  hintText: 'Contanos más sobre lo que pasó...',
                  hintStyle: AppTypography.fieldValue.copyWith(
                    color: AppColors.textMuted,
                  ),
                  filled: true,
                  fillColor: AppColors.background,
                  contentPadding: const EdgeInsets.all(14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sectionGap),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _reason == null ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Enviar reporte',
                    style: AppTypography.button.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Tu reporte está protegido bajo nuestro sistema de prevención '
                'de falso flete y fraudes de FletesFlex.',
                style: AppTypography.micro.copyWith(height: 15 / 11),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
