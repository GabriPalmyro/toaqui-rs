import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key, required this.selectedIndex, required this.onSelectedIndex});

  final int selectedIndex;
  final Function(int) onSelectedIndex;

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  double groupAlignment = -1.0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: NavigationRail(
        selectedIndex: widget.selectedIndex,
        groupAlignment: groupAlignment,
        onDestinationSelected: widget.onSelectedIndex,
        labelType: labelType,
        destinations: const <NavigationRailDestination>[
          NavigationRailDestination(
            icon: Icon(Icons.add_circle_rounded),
            selectedIcon: Icon(Icons.add_circle_outline_rounded),
            label: Text(
              'Cadastrar Nova Pessoa\nResgatada',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.only(top: 24, bottom: 12, left: 18, right: 18),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.find_in_page),
            selectedIcon: Icon(Icons.find_in_page_outlined),
            label: Text(
              'Encontrar Pessoa\nDesaparecida',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.only(bottom: 12, left: 18, right: 18),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.pets),
            selectedIcon: Icon(Icons.pets),
            label: Text(
              'Cadastrar Novo Animal\nResgatado',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.only(bottom: 12, left: 18, right: 18),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.find_in_page),
            selectedIcon: Icon(Icons.find_in_page),
            label: Text(
              'Encontrar Animal\nDesaparecido',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.only(bottom: 12, left: 18, right: 18),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.location_on),
            selectedIcon: Icon(Icons.location_on_outlined),
            label: Text(
              'Cadastrar/Encontrar\nAbrigos',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.only(bottom: 12, left: 18, right: 18),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.star),
            selectedIcon: Icon(Icons.star),
            label: Text(
              'LGPD',
              style: TextStyle(fontSize: 16),
            ),
            padding: EdgeInsets.only(bottom: 12, left: 18, right: 18),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.help),
            selectedIcon: Icon(Icons.help_outline),
            label: Text(
              'Ajuda',
              style: TextStyle(fontSize: 16),
            ),
            padding: EdgeInsets.only(bottom: 12, left: 18, right: 18),
          ),
        ],
      ),
    );
  }
}
