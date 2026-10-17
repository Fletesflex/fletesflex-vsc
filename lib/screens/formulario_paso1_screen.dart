import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../routes.dart';
import '../theme/theme.dart';
import '../widgets/widgets.dart';

/// Kind of property at an address; drives whether floor/apartment fields
/// are shown.
enum PropertyType { casa, departamento }

const _propertyTypeLabels = {
  PropertyType.casa: 'Casa',
  PropertyType.departamento: 'Departamento',
};

/// Step 1 of the "Mudanza" request form (origin and destination addresses),
/// implemented from the Figma "formulario-paso-1" design
/// (file o7nkeARTqRUSPsNBaYg2nb, node 2:95), reusing the tokens in
/// `lib/theme/`.
class FormularioPaso1Screen extends StatefulWidget {
  const FormularioPaso1Screen({super.key});

  @override
  State<FormularioPaso1Screen> createState() => _FormularioPaso1ScreenState();
}

class _FormularioPaso1ScreenState extends State<FormularioPaso1Screen> {
  // TODO: replace the sample origin with the user's saved/current address.
  final _origin = _AddressFields(
    address: 'Av. Santa Fe 2345, Palermo, CABA',
    floor: '4',
    apartment: 'B',
    type: PropertyType.departamento,
  );
  final _destination = _AddressFields();

  @override
  void dispose() {
    _origin.dispose();
    _destination.dispose();
    super.dispose();
  }

  void _handleAddStop() {
    // TODO: add an intermediate stop.
  }

  void _handleNext() {
    // TODO: validate the addresses before continuing.
    Navigator.of(context).pushNamed(AppRoutes.formularioPaso2);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: 'Paso 1: Direcciones',
      trailing: const StepIndicator(current: 0, total: 2),
      bottom: PrimaryButton(label: 'Siguiente', onPressed: _handleNext),
      children: [
        _AddressSection(
          marker: 'A',
          title: 'Origen de la Mudanza',
          hintText: 'Ingresá dirección de origen',
          pinAsset: 'assets/icons/map_pin.svg',
          fields: _origin,
          onTypeChanged: (type) => setState(() => _origin.type = type),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        const AppDivider(),
        const SizedBox(height: AppSpacing.sectionGap),
        _AddressSection(
          marker: 'B',
          title: 'Destino de la Mudanza',
          hintText: 'Ingresá dirección de destino',
          pinAsset: 'assets/icons/map_pin_accent.svg',
          fields: _destination,
          onTypeChanged: (type) => setState(() => _destination.type = type),
        ),
        const SizedBox(height: AppSpacing.sectionGap),
        _AddStopButton(onTap: _handleAddStop),
      ],
    );
  }
}

/// Controllers + selected property type for one address.
class _AddressFields {
  _AddressFields({
    String? address,
    String? floor,
    String? apartment,
    this.type,
  })  : address = TextEditingController(text: address),
        floor = TextEditingController(text: floor),
        apartment = TextEditingController(text: apartment);

  final TextEditingController address;
  final TextEditingController floor;
  final TextEditingController apartment;
  PropertyType? type;

  void dispose() {
    address.dispose();
    floor.dispose();
    apartment.dispose();
  }
}

class _AddressSection extends StatelessWidget {
  const _AddressSection({
    required this.marker,
    required this.title,
    required this.hintText,
    required this.pinAsset,
    required this.fields,
    required this.onTypeChanged,
  });

  final String marker;
  final String title;
  final String hintText;
  final String pinAsset;
  final _AddressFields fields;
  final ValueChanged<PropertyType> onTypeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            RouteMarker(marker),
            const SizedBox(width: AppSpacing.xs),
            Text(title, style: AppTypography.groupTitle),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        FormTextField(
          controller: fields.address,
          hintText: hintText,
          leadingIconAsset: pinAsset,
          keyboardType: TextInputType.streetAddress,
        ),
        const SizedBox(height: AppSpacing.sm),
        OptionChipGroup<PropertyType>(
          options: _propertyTypeLabels,
          selected: fields.type,
          onChanged: onTypeChanged,
        ),
        if (fields.type == PropertyType.departamento) ...[
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: FormTextField(
                  label: 'Piso',
                  controller: fields.floor,
                  padding: const EdgeInsets.all(10),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: FormTextField(
                  label: 'Depto / Of',
                  controller: fields.apartment,
                  padding: const EdgeInsets.all(10),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class _AddStopButton extends StatelessWidget {
  const _AddStopButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/plus_circle.svg',
              width: 18,
              height: 18,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text('Agregar parada intermedia', style: AppTypography.textAction),
          ],
        ),
      ),
    );
  }
}
