import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// An object the user wants transported on a "Flete" request.
class FleteItem {
  const FleteItem({
    required this.photoAsset,
    required this.name,
    required this.detail,
  });

  final String photoAsset;
  final String name;
  final String detail;
}

/// Step 2 of the "Flete" request form (cargo inventory), implemented from
/// the Figma "flete-paso-2-inventario" design (file neRKyJz313WM7CEdoZdgGl,
/// node 40:4), reusing the tokens in `lib/theme/`.
class FletePaso2Screen extends StatefulWidget {
  const FletePaso2Screen({super.key});

  @override
  State<FletePaso2Screen> createState() => _FletePaso2ScreenState();
}

class _FletePaso2ScreenState extends State<FletePaso2Screen> {
  // TODO: replace the sample cargo with items the user adds.
  final List<FleteItem> _items = [
    const FleteItem(
      photoAsset: 'assets/images/photo_fridge.png',
      name: 'Heladera No Frost',
      detail: 'Grande (70 × 60 × 170 cm)',
    ),
    const FleteItem(
      photoAsset: 'assets/images/photo_sofa.png',
      name: 'Sillón 3 cuerpos',
      detail: 'Mediano (200 × 90 × 85 cm)',
    ),
  ];

  void _handleAddItem() {
    // TODO: open the "add object" flow.
  }

  void _handleNext() {
    // TODO: validate the cargo list before continuing.
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Nuevo flete',
      topBarStyle: TopBarStyle.centered,
      children: [
        const StepIndicator(
          current: 1,
          total: 3,
          style: StepIndicatorStyle.bars,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text('Paso 2: Tu carga', style: AppTypography.textAction),
        const SizedBox(height: AppSpacing.sectionGap),
        Text('¿Qué necesitás trasladar?', style: AppTypography.headline),
        const SizedBox(height: AppSpacing.sectionGap),
        for (var i = 0; i < _items.length; i++) ...[
          if (i > 0) const SizedBox(height: AppSpacing.sm),
          _InventoryCard(
            item: _items[i],
            onRemove: () => setState(() => _items.removeAt(i)),
          ),
        ],
        const SizedBox(height: AppSpacing.sectionGap),
        PillButton(
          outlined: true,
          leading: SvgPicture.asset(
            'assets/icons/plus.svg',
            width: 16,
            height: 16,
          ),
          label: 'Agregar objeto',
          onPressed: _handleAddItem,
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        Text(
          'Con esta info calculamos el vehículo que necesitás y el precio '
          'del flete.',
          style: AppTypography.cardDescription,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        PillButton(label: 'Siguiente', onPressed: _handleNext),
      ],
    );
  }
}

/// White rounded card showing a cargo photo, name/size, and a delete
/// button (one row in the "¿Qué necesitás trasladar?" list).
class _InventoryCard extends StatelessWidget {
  const _InventoryCard({required this.item, required this.onRemove});

  final FleteItem item;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderWidth: 0,
      borderColor: Colors.transparent,
      radius: AppRadius.xl,
      elevatedShadow: true,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: Image.asset(
              item.photoAsset,
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.name, style: AppTypography.userName),
                const SizedBox(height: AppSpacing.xxs),
                Text(item.detail, style: AppTypography.itemSubtitle),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          InkResponse(
            onTap: onRemove,
            radius: 18,
            child: Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.iconSurface,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/icons/trash.svg',
                width: 16,
                height: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
