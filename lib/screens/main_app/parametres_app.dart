import 'package:flutter/material.dart';
import 'package:resachev_client/utils/theme_controller.dart';

class ParametresApp extends StatelessWidget {
  const ParametresApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text("Gestion des paramètres de l'application"),
        ),

        SwitchListTile(
          title: Text(
            themeController.value == ThemeMode.dark
                ? 'Passer en mode clair'
                : 'Passer en mode sombre',
          ),
          value: themeController.value == ThemeMode.dark,
          onChanged: (bool value) {
            themeController.toggleTheme();
          },
        ),
      ],
    );
  }
}