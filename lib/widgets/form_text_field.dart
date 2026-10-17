import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';

/// Compact bordered text field used in request forms (address, floor,
/// apartment). Optionally shows a leading SVG icon and a small label above.
class FormTextField extends StatelessWidget {
  const FormTextField({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.leadingIconAsset,
    this.trailingIconAsset,
    this.padding = const EdgeInsets.all(AppSpacing.sm),
    this.keyboardType,
    this.fillColor = AppColors.surface,
    this.readOnly = false,
    this.onTap,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final String? leadingIconAsset;

  /// Shown at the end of the field (e.g. the chevron on a select-style
  /// field). Does not respond to taps on its own; use [onTap] on the field.
  final String? trailingIconAsset;
  final EdgeInsetsGeometry padding;
  final TextInputType? keyboardType;
  final Color fillColor;

  /// When true, the field opens a picker via [onTap] instead of the
  /// keyboard (date, time and select-style fields).
  final bool readOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.sm),
      borderSide: const BorderSide(color: AppColors.border, width: 1.5),
    );

    final field = TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      cursorColor: AppColors.accent,
      style: AppTypography.fieldValue,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: fillColor,
        contentPadding: padding,
        hintText: hintText,
        hintStyle: AppTypography.fieldValue.copyWith(color: AppColors.textMuted),
        prefixIcon: leadingIconAsset == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(
                  left: AppSpacing.sm,
                  right: 10,
                ),
                child: SvgPicture.asset(
                  leadingIconAsset!,
                  width: 18,
                  height: 18,
                ),
              ),
        prefixIconConstraints: const BoxConstraints(),
        suffixIcon: trailingIconAsset == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: SvgPicture.asset(
                  trailingIconAsset!,
                  width: 14,
                  height: 14,
                ),
              ),
        suffixIconConstraints: const BoxConstraints(),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: const BorderSide(color: AppColors.accent, width: 2),
        ),
      ),
    );

    if (label == null) return field;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label!, style: AppTypography.fieldLabel),
        const SizedBox(height: AppSpacing.xxs),
        field,
      ],
    );
  }
}
