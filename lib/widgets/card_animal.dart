import 'package:encontre_sua_crianca/model/animal.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardAnimal extends StatelessWidget {
  const CardAnimal({super.key, required this.animal});

  final Animal animal;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width < 800 ? double.infinity : width * 0.2,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (animal.photo != null) ...{
            Image.network(
              animal.photo!,
              width: double.infinity,
              height: width < 800 ? 300 : 400,
              fit: BoxFit.contain,
            ),
          },
          const SizedBox(height: 8),
          if (animal.name != null && animal.name!.isNotEmpty) ...{
            Text('Nome: ${animal.name}'),
          },
          if (animal.phone != null && animal.phone!.isNotEmpty) ...[
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  final phoneUrl = 'tel:${animal.phone}';
                  await launchUrl(Uri.parse(phoneUrl));
                },
                child: Text(
                  'Contato: ${animal.phone}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
          if (animal.location != null && animal.location!.isNotEmpty) ...[
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () async {
                  final googleUrl = 'https://www.google.com/maps/search/?api=1&query=${animal.location}';
                  await launchUrl(Uri.parse(googleUrl));
                },
                child: Text(
                  'Local: ${animal.location}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
          if (animal.physicalInfos != null && animal.physicalInfos!.isNotEmpty) ...{
            Text('Características Físicas: ${animal.physicalInfos}'),
          },
          if (animal.additionalInfos != null && animal.additionalInfos!.isNotEmpty) ...{
            Text('Informações Adicionais: ${animal.additionalInfos}'),
          },
          if (animal.isMissing) ...{
            const Text('Animal desaparecido', style: TextStyle(fontWeight: FontWeight.w600)),
          },
        ],
      ),
    );
  }
}
