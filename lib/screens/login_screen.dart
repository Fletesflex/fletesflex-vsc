import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';

/// Login screen, implemented from the Figma "Login" design
/// (file neRKyJz313WM7CEdoZdgGl, node 2:10), reusing the tokens in
/// `lib/theme/`.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    // TODO: wire up phone-number submission.
    FocusScope.of(context).unfocus();
    Navigator.of(context).pushNamed(AppRoutes.home);
  }

  void _handleContinueWithGoogle() {
    // TODO: wire up Google sign-in.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _Hero(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg)
                    .copyWith(bottom: AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _Headlines(),
                    const SizedBox(height: AppSpacing.lg),
                    _PhoneInput(controller: _phoneController),
                    const SizedBox(height: AppSpacing.lg),
                    _ContinueButton(onPressed: _handleContinue),
                    const SizedBox(height: AppSpacing.lg),
                    const _OrDivider(),
                    const SizedBox(height: AppSpacing.lg),
                    _GoogleButton(onPressed: _handleContinueWithGoogle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Decorative hero: two soft color blobs behind the "FletesFlex" logo mark.
class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ClipRect(
        child: Stack(
          children: [
            Positioned(
              left: -40,
              top: -40,
              child: _Blob(size: 260, color: AppColors.heroBlobYellow),
            ),
            Positioned(
              left: 240,
              top: 120,
              child: _Blob(size: 180, color: AppColors.heroBlobGray),
            ),
            const Center(child: _Logo()),
          ],
        ),
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.textPrimary,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            boxShadow: AppShadows.soft,
          ),
          child: SvgPicture.asset(
            'assets/icons/truck.svg',
            width: 36,
            height: 36,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text('FletesFlex', style: AppTypography.logo),
      ],
    );
  }
}

class _Headlines extends StatelessWidget {
  const _Headlines();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mudate sin estrés', style: AppTypography.headline),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Ingresá tu teléfono para recibir cotizaciones al instante en '
          'Argentina.',
          style: AppTypography.subtitle,
        ),
      ],
    );
  }
}

class _PhoneInput extends StatelessWidget {
  const _PhoneInput({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Número de teléfono', style: AppTypography.label),
        const SizedBox(height: AppSpacing.xs),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border, width: 1.5),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🇦🇷', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: AppSpacing.xs),
                  Text('+54 9', style: AppTypography.inputEmphasis),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.accent, width: 2),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  cursorColor: AppColors.accent,
                  style: AppTypography.inputValue,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintText: '11 5834 9281',
                    hintStyle: AppTypography.inputValue
                        .copyWith(color: AppColors.textMuted),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ContinueButton extends StatelessWidget {
  const _ContinueButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.buttonVertical,
          ),
        ),
        child: const Text('Continuar'),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: _DividerLine()),
        const SizedBox(width: AppSpacing.sm),
        Text('o continuar con', style: AppTypography.caption),
        const SizedBox(width: AppSpacing.sm),
        const Expanded(child: _DividerLine()),
      ],
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.5,
      child: SvgPicture.asset(
        'assets/icons/line.svg',
        fit: BoxFit.fill,
      ),
    );
  }
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.buttonVertical,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/circle_x.svg',
              width: 20,
              height: 20,
            ),
            const SizedBox(width: AppSpacing.xs),
            const Text('Continuar con Google'),
          ],
        ),
      ),
    );
  }
}
