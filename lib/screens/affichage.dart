import 'package:flutter/material.dart';
import 'package:resachev_client/widgets/Appbar.dart';
import 'main_app/connexion_app.dart';
import 'main_app/accueil_app.dart';

import 'package:resachev_client/widgets/bottom_bar.dart';

import 'main_app/parametres_app.dart';

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
      appBar: AppBar_P(
        title: 'ResaChev client',
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ConnexionApp(),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: currentPageIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentPageIndex = index;

            if (index == 0) {
              currentBody = const Acceuil();
            } else if (index == 1) {
              currentBody = const Center(
                child: Text('Liste des réservations'),
              );
            } else if (index == 2) {
              currentBody = const ParametresApp();
            }
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
