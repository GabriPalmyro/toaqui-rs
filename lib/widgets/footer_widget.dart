import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const Text('ToAquiRS - Todos os direitos reservados', style: TextStyle(fontWeight: FontWeight.bold)),
        const Text('Desenvolvido por:'),
        TextButton(
          onPressed: () {
            launchUrl(
              Uri.parse('https://instagram.com/palmyro_ga'),
            );
          },
          child: const Text('@palmyro_ga'),
        ),
        TextButton(
          onPressed: () {
            launchUrl(
              Uri.parse('https://instagram.com/tarikhadi'),
            );
          },
          child: const Text('@tarikhadi'),
        ),
      ],
    );
  }
}
