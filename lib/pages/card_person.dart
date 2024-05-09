import 'package:encontre_sua_crianca/model/person.dart';
import 'package:encontre_sua_crianca/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardPerson extends StatelessWidget {
  const CardPerson({super.key, required this.person});

  final Person person;

  @override
  Widget build(BuildContext context) {
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
          Text('Nome: ${person.name}'),
          if (person.age != null) ...{
            Text('Idade: ${person.age}'),
          },
          if (person.parentName != null && person.parentName!.isNotEmpty) ...{
            Text('Nome do Parente: ${person.parentName}'),
          },
          if (person.city != null && person.city!.isNotEmpty) ...{
            Text('Cidade: ${person.city}'),
          },
          if (person.contactPhone != null && person.contactPhone!.isNotEmpty) ...{
            Text('Contato do Responsável: ${person.contactPhone}'),
          },
          if (person.location != null && person.location!.isNotEmpty) ...{
            Text('Local de Abrigo: ${person.location}'),
          },
          if (person.observations != null && person.observations!.isNotEmpty) ...{
            Text('Observações: ${person.observations}'),
          },
          if (person.createdAt != null) ...{
            Text('Adicionado em: ${Format.formatDate(person.createdAt!)}'),
          },
          const SizedBox(height: 8),
          Row(
            children: [
              if (person.photoUrl != null && person.photoUrl!.isNotEmpty) ...{
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Foto da Pessoa'),
                        content: Image.network(
                          person.photoUrl!,
                          scale: 1.0,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Erro ao carregar a imagem');
                          },
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Abrir Foto',
                    style: TextStyle(
                      color: Color(0xFFff5757),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              },
              if (person.adress != null && person.adress!.isNotEmpty) ...{
                const SizedBox(width: 16),
                TextButton(
                  onPressed: () async {
                    try {
                      String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${person.adress}';
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
        ],
      ),
    );
  }
}
