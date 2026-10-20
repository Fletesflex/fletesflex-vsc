import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// SMS one-time-code screen, implemented from the Figma
/// "codigo-verificacion" design (file neRKyJz313WM7CEdoZdgGl, node 2051:2),
/// reusing the tokens in `lib/theme/`.
///
/// Expects the phone number entered on [LoginScreen] as the route
/// `arguments` (a [String], without the "+54 9" prefix).
class CodigoVerificacionScreen extends StatefulWidget {
  const CodigoVerificacionScreen({super.key});

  @override
  State<CodigoVerificacionScreen> createState() =>
      _CodigoVerificacionScreenState();
}

class _CodigoVerificacionScreenState extends State<CodigoVerificacionScreen> {
  static const _codeLength = 6;
  static const _resendSeconds = 42;

  final _controllers = List.generate(
    _codeLength,
    (_) => TextEditingController(),
  );
  final _focusNodes = List.generate(_codeLength, (_) => FocusNode());

  Timer? _timer;
  int _secondsLeft = _resendSeconds;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _secondsLeft = _resendSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft <= 1) {
        timer.cancel();
        setState(() => _secondsLeft = 0);
      } else {
        setState(() => _secondsLeft -= 1);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  bool get _isComplete =>
      _controllers.every((controller) => controller.text.isNotEmpty);

  void _handleDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < _codeLength - 1) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  void _handleResend() {
    // TODO: pedir un nuevo código SMS al backend.
    for (final controller in _controllers) {
      controller.clear();
    }
    _focusNodes.first.requestFocus();
    _startTimer();
  }

  void _handleChangeNumber() {
    Navigator.of(context).maybePop();
  }

  void _handleVerificar() {
    // TODO: verificar el código ingresado contra el backend. Si la cuenta
    // ya existe, navegar directo al Home del rol correspondiente en vez de
    // pasar por la pantalla de elegir rol.
    Navigator.of(context).pushNamed(AppRoutes.elegirRol);
  }

  @override
  Widget build(BuildContext context) {
    final rawPhone =
        (ModalRoute.of(context)?.settings.arguments as String?)?.trim();
    final displayPhone = (rawPhone == null || rawPhone.isEmpty)
        ? '+54 9 11 5834 9281'
        : '+54 9 $rawPhone';

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
                0,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: _BackButton(
                  onTap: () => Navigator.of(context).maybePop(),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.md,
                  AppSpacing.lg,
                  AppSpacing.lg,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ingresá el código', style: AppTypography.headline),
                    const SizedBox(height: AppSpacing.xs),
                    Text.rich(
                      TextSpan(
                        style: AppTypography.subtitle,
                        children: [
                          const TextSpan(
                            text: 'Te enviamos un código de 6 dígitos por '
                                'SMS al ',
                          ),
                          TextSpan(
                            text: '$displayPhone.',
                            style: AppTypography.subtitle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (var i = 0; i < _codeLength; i++)
                          _OtpBox(
                            controller: _controllers[i],
                            focusNode: _focusNodes[i],
                            onChanged: (value) => _handleDigitChanged(i, value),
                          ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Center(
                      child: _secondsLeft > 0
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/clock.svg',
                                  width: 16,
                                  height: 16,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.textSecondary,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.xxs),
                                Text(
                                  'Podés pedir un nuevo código en '
                                  '0:${_secondsLeft.toString().padLeft(2, '0')}',
                                  style: AppTypography.caption,
                                ),
                              ],
                            )
                          : TextLinkButton(
                              label: 'Reenviar código',
                              onPressed: _handleResend,
                              color: AppColors.textPrimary,
                            ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Center(
                      child: TextLinkButton(
                        label: 'Cambiar número',
                        onPressed: _handleChangeNumber,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: PrimaryButton(
                label: 'Verificar',
                onPressed: _isComplete ? _handleVerificar : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OtpBox extends StatelessWidget {
  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 60,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: AppTypography.headline.copyWith(fontSize: 28),
        cursorColor: AppColors.accent,
        decoration: const InputDecoration(
          isDense: true,
          counterText: '',
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border, width: 1.5),
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        child: SvgPicture.asset(
          'assets/icons/arrow_left_sm.svg',
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}
