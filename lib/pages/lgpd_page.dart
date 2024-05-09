import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LGPDPage extends StatelessWidget {
  const LGPDPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: ListView(
        children: const [
          Text('Aviso Legal de Coleta de Dados de Crianças em Situação de Emergência',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text('Considerando a situação de calamidade pública, decorrente da enchente no Estado do Rio Grande do Sul, em maio de 2024, e em conformidade com a Lei Geral de Proteção de Dados (LGPD), informamos que a coleta dos dados pessoais das crianças resgatadas e que se encontram sem os seus respectivos pais (pai, ou mãe), responsável (eis) ou tutor (es) conforme descritos abaixo, é realizada com base nas seguintes hipóteses legais:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 12),
          Text('Art. 7º - Tratamento de Dados Pessoais:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text('VII - Para a proteção da vida ou da incolumidade física do titular ou de terceiro.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 12),
          Text('Art. 11 - Tratamento de Dados Pessoais Sensíveis:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text('II - Sem fornecimento de consentimento do titular, nas hipóteses em que for indispensável para:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 12),
          Text('e) Proteção da vida ou da incolumidade física do titular ou de terceiro.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 12),
          Text('Art. 14 - Tratamento de Dados Pessoais de Crianças e Adolescentes:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Text('§ 3º - Poderão ser coletados dados pessoais de crianças sem o consentimento quando a coleta for necessária para contatar os pais ou o responsável legal, utilizados uma única vez e sem armazenamento, ou para sua proteção, e em nenhum caso poderão ser repassados a terceiro sem o consentimento.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 12),
          Text('Dessa forma, a coleta dos dados pessoais das crianças encontradas em situação de emergência, incluindo nome completo, endereço, foto e telefone dos responsáveis, é realizada com o objetivo primordial de garantir a segurança e proteção desses menores, permitindo a localização e contato com seus pais ou responsáveis legais para assegurar seu bem-estar e incolumidade física, mental e emocional.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 12),
          Text('Salientamos que os dados coletados serão utilizados exclusivamente para os fins mencionados acima, não sendo repassados a terceiros sem o consentimento prévio dos pais, ou responsáveis legais.',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}