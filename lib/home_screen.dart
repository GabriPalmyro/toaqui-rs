import 'package:encontre_sua_crianca/pages/add_new_animal.dart';
import 'package:encontre_sua_crianca/pages/add_new_person.dart';
import 'package:encontre_sua_crianca/pages/add_new_shelter.dart';
import 'package:encontre_sua_crianca/pages/help_page.dart';
import 'package:encontre_sua_crianca/pages/lgpd_page.dart';
import 'package:encontre_sua_crianca/pages/search_animal.dart';
import 'package:encontre_sua_crianca/pages/search_person.dart';
import 'package:encontre_sua_crianca/widgets/drawer.dart';
import 'package:encontre_sua_crianca/widgets/navigation_rail.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = const [
    AddNewPersonPage(),
    SearchPersonPage(),
    AddNewAnimalPage(),
    SearchAnimalPage(),
    AddNewShelterPage(),
    LGPDPage(),
    HelpPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ToAquiRS - Encontre desaparecidos',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFff5757),
        actions: [
          InkWell(
            onTap: () {
              launchUrl(
                Uri.parse('https://www.instagram.com/toaqui_rs'),
              );
            },
            child: Image.asset(
              'assets/logo.jpeg',
              width: 120,
              height: 120,
            ),
          )
        ],
      ),
      drawer: width < 600
          ? CustomDrawer(
              selectedIndex: _selectedIndex,
              onSelectedIndex: (index) {
                setState(() {
                  _selectedIndex = index;
                  Navigator.pop(context);
                });
              })
          : null,
      body: Row(
        children: [
          if (width > 600) ...{
            NavigationSideBar(
                selectedIndex: _selectedIndex,
                onSelectedIndex: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }),
          },
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: _pages[_selectedIndex],
          )
        ],
      ),
    );
  }
}
