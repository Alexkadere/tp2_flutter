import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onDestinationSelected;
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Accueil'),
        NavigationDestination(
          icon: Icon(Icons.calendar_month),
          label: 'Réservations',
        ),
        NavigationDestination(icon: Icon(Icons.settings), label: 'Paramètres'),
      ],
    );
  }
}
