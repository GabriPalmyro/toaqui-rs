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
            label: Text('Cadastrar Nova Pessoa\nResgatada'),
            padding: EdgeInsets.only(top: 24, bottom: 12, left: 18, right: 18),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.find_in_page),
            selectedIcon: Icon(Icons.find_in_page_outlined),
            label: Text('Encontrar Pessoa\nDesaparecida'),
            padding: EdgeInsets.only(bottom: 12, left: 18, right: 18),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.star),
            selectedIcon: Icon(Icons.star),
            label: Text('LGPD'),
            padding: EdgeInsets.only(bottom: 12, left: 18, right: 18),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.help),
            selectedIcon: Icon(Icons.help_outline),
            label: Text('Ajuda'),
            padding: EdgeInsets.only(bottom: 12, left: 18, right: 18),
          ),
        ],
      ),
    );
  }
}
