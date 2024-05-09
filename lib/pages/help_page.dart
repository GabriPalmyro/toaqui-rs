import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
      child: Column(
        children: [
          const Text(
            'Como Ajudar?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          const Text(
            'Você pode ajudar compartilhando os posts de pessoas desaparecidas nas redes sociais',
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          const Text(
            'Se você tem informações sobre alguma pessoa desaparecida, entre em contato com a polícia!',
            style: TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Entre em contato pelo instagram @toaqui_rs',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Ou clique aqui:',
                style: TextStyle(
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  launchUrl(
                    Uri.parse('https://www.instagram.com/toaqui_rs'),
                  );
                },
                child: Image.network(
                  'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/Instagram_icon.png/800px-Instagram_icon.png',
                  width: MediaQuery.of(context).size.width < 800 ? MediaQuery.of(context).size.width * 0.4 : MediaQuery.of(context).size.width * 0.1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
