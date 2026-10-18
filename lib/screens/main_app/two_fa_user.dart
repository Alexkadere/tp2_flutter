import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:resachev_client/services/api/gestionUsr/usr_api.dart';
import 'package:resachev_client/services/gestion_token.dart';

class TwoFaUser extends StatefulWidget {
  final String email;

  const TwoFaUser({super.key, required this.email});

  @override
  State<TwoFaUser> createState() => _TwoFaUserState();
}

class _TwoFaUserState extends State<TwoFaUser> {
  final codeController = TextEditingController();

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  
  Future<void> _verifierCode() async {
    final code = codeController.text.trim();

    if (code.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez saisir un code à 6 chiffres'),
        ),
      );
      return;
    }

    final result = await UsrApi().verifyTwoFa(widget.email, code);

    if (!mounted) return;

    if (result['ok'] == true) {
  final token = result['token']?.toString();

  if (token != null && token.isNotEmpty) {
    await GestionToken.saveToken(token);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Authentification réussie ! Token sauvegardé.'),
      ),
    );
  }
} else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result['message']?.toString() ?? 'Code invalide',
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Code d'authentification"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Code envoyé à : ${widget.email}'),
              const SizedBox(height: 20),
              SizedBox(
                width: 240,
                child: TextField(
                  controller: codeController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 6,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Code à 6 chiffres',
                    border: OutlineInputBorder(),
                    counterText: '',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _verifierCode,
                child: const Text('Valider'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}