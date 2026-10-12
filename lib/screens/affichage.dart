import 'package:flutter/material.dart';
import 'package:resachev_client/widgets/Appbar.dart';

import 'main_app/accueil_app.dart';

import 'package:resachev_client/widgets/bottom_bar.dart';

class PagelogP extends StatefulWidget {
  const PagelogP({super.key});

  @override
  State<PagelogP> createState() => _PagelogPState();
}

class _PagelogPState extends State<PagelogP> {
  int currentPageIndex = 0;
  Widget? currentBody;

  @override
  void initState() {
    super.initState();
    currentBody = Acceuil();
  }

  void afficherNouvellePage(Widget nouvellePage) {
    setState(() {
      currentBody = nouvellePage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_P(title: 'Gestion des rendez-vous'),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentPageIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),

      body: SafeArea(
        child:
            currentBody ??
            const Center(child: Text('Aucune page sélectionnée')),
      ),
    );
  }
}
