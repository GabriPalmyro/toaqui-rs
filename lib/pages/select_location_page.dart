import 'package:encontre_sua_crianca/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:map_location_picker/map_location_picker.dart';

class SelectLocationPage extends StatelessWidget {
  const SelectLocationPage({super.key, this.onNext});
  final Function(GeocodingResult?)? onNext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapLocationPicker(
        bottomCardTooltip: 'Selecionar Localização',
        dialogTitle: 'Selecione a localização do abrigo',
        searchHintText: 'Pesquisar por nome do local',
        currentLatLng: const LatLng(-30.033056, -51.230000),
        apiKey: AppString.mapsApiKey,
        onNext: onNext,
      ),
    );
  }
}
