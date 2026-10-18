import 'package:flutter/material.dart';
import 'package:resachev_client/services/api/gestionUsr/usr_api.dart';
import 'two_fa_user.dart';

class ConnexionApp extends StatefulWidget {
  const ConnexionApp({super.key});

  @override
  State<ConnexionApp> createState() => _ConnexionAppState();
}

class _ConnexionAppState extends State<ConnexionApp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool masquerMotDePasse = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  
void _login() async {
  String email = emailController.text.trim();
  String password = passwordController.text;

  if (email.isNotEmpty && password.isNotEmpty) {
    final result = await UsrApi().loginUser(email, password);

    if (!mounted) return;

    final message = result?['message']?.toString() ?? '';

    final isSuccess = result != null &&
        (result['ok'] == true ||
            message.toLowerCase().contains(
              'un code de vérification a été envoyé par email',
            ));

    if (isSuccess) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => TwoFaUser(email: email),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            result?['message']?.toString() ?? 'Échec de connexion',
          ),
        ),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Veuillez remplir tous les champs'),
      ),
    );
  }
}

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connexion'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                obscureText: masquerMotDePasse,
                decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  prefixIcon: const Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      masquerMotDePasse
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        masquerMotDePasse = !masquerMotDePasse;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Se connecter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}