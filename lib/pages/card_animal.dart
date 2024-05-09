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
              height: width < 600 ? 200 : 300,
              fit: BoxFit.cover,
            ),
          },
          if (animal.name != null) ...{
            Text('Nome: ${animal.name }'),
          },
          if (animal.phone != null) ...{
            Text('Contato: ${animal.phone }'),
          },
          if (animal.physicalInfos != null) ...{
            Text('Características Físicas: ${animal.physicalInfos }'),
          },
          if (animal.additionalInfos != null) ...{
            Text('Informações Adicionais: ${animal.additionalInfos}'),
          },
          if (animal.location != null && animal.location!.isNotEmpty) ...{
            const SizedBox(width: 16),
            TextButton(
              onPressed: () async {
                try {
                  String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${animal.location}';
                  if (await launchUrl(Uri.parse(googleUrl))) {
                    await launchUrl(Uri.parse(googleUrl));
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Não foi possível abrir o endereço'),
                    ),
                  );
                }
              },
              child: const Text(
                'Abrir Endereço',
                style: TextStyle(
                  color: Color(0xFFff5757),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            )
          },
        ],
      ),
    );
  }
}
