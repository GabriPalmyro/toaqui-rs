import 'package:flutter/material.dart';

class OnConstructionPage extends StatelessWidget {
  const OnConstructionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Icon(Icons.construction, size: 100, color: Color(0xFFff5757),),
          SizedBox(height: 24,),
          Text(
            'Essa pagina está em construção',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
