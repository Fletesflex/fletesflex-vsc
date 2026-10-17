import 'dart:async';

import 'package:flutter/material.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// "Confirming your payment" waiting screen, implemented from the Figma
/// "carga-pago" design (file o7nkeARTqRUSPsNBaYg2nb, node 30:383).
class CargaPagoScreen extends StatefulWidget {
  const CargaPagoScreen({super.key});

  @override
  State<CargaPagoScreen> createState() => _CargaPagoScreenState();
}

class _CargaPagoScreenState extends State<CargaPagoScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // TODO: replace with the real Mercado Pago checkout result.
    _timer = Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(
        AppRoutes.pagoConfirmado,
        arguments: ModalRoute.of(context)?.settings.arguments,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SpinnerBadge(iconAsset: 'assets/icons/handshake.svg'),
                  const SizedBox(height: 40),
                  Text(
                    'Estamos confirmando tu pago con Mercado Pago',
                    style: AppTypography.headline.copyWith(height: 1.3),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    'No cierres la app, esto puede tardar unos segundos',
                    style: AppTypography.body,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
