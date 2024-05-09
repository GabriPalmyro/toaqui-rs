import 'package:flutter/material.dart';

class NavigationSideBar extends StatefulWidget {
  const NavigationSideBar({super.key, required this.selectedIndex, required this.onSelectedIndex});

  final int selectedIndex;
  final Function(int) onSelectedIndex;

  @override
  State<NavigationSideBar> createState() => _NavigationSideBarState();
}

class _NavigationSideBarState extends State<NavigationSideBar> {
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  double groupAlignment = -1.0;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: widget.selectedIndex,
      groupAlignment: groupAlignment,
      onDestinationSelected: widget.onSelectedIndex,
      labelType: labelType,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.add_circle_rounded),
          selectedIcon: Icon(Icons.add_circle_rounded),
          label: Text(
            'Cadastrar Nova Pessoa\nResgatada',
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.only(bottom: 12, left: 18, right: 18),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.find_in_page),
          selectedIcon: Icon(Icons.find_in_page),
          label: Text(
            'Encontrar Pessoa\nDesaparecida',
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.only(bottom: 12, left: 18, right: 18),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.pets_rounded),
          selectedIcon: Icon(Icons.pets_rounded),
          label: Text(
            'Cadastrar Novo Animal\nResgatado',
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.only(bottom: 12, left: 18, right: 18),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.find_in_page),
          selectedIcon: Icon(Icons.find_in_page),
          label: Text(
            'Encontrar Animal\nDesaparecido',
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.only(bottom: 12, left: 18, right: 18),
        ),
         NavigationRailDestination(
          icon: Icon(Icons.location_on),
          selectedIcon: Icon(Icons.location_on_outlined),
          label: Text(
            'Cadastrar/Encontrar\nAbrigos',
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.only(bottom: 12, left: 18, right: 18),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.star_border),
          selectedIcon: Icon(Icons.star),
          label: Text('LGPD'),
          padding: EdgeInsets.only(bottom: 12, left: 18, right: 18),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.help),
          selectedIcon: Icon(Icons.help),
          label: Text('Ajuda'),
          padding: EdgeInsets.only(bottom: 12, left: 18, right: 18),
        ),
      ],
    );
  }
}
