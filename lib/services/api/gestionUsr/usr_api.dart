
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:resachev_client/services/api/config.dart';

class UsrApi {

  // Connexion utilisateur
  Future<Map<String, dynamic>?> loginUser(
    String mail,
    String paswd,
  ) async {
    final url = Uri.parse('${AppConfig.apiBaseUrl}/mobile/login');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': mail,
          'motpasse': paswd,
        }),
      ).timeout(const Duration(seconds: 45));

      Map<String, dynamic>? data;

      if (response.body.isNotEmpty) {
        try {
          final decoded = jsonDecode(response.body);
          if (decoded is Map<String, dynamic>) {
            data = decoded;
          }
        } catch (_) {
          data = null;
        }
      }

      if (response.statusCode == 200) {
        return {
          'ok': true,
          'message': data?['message'] ?? 'Code de vérification envoyé.',
          'user': data?['data'],
        };
      }

      if (response.statusCode == 401) {
        return {
          'ok': false,
          'message': data?['message'] ??
              data?['error'] ??
              data?['detail'] ??
              'Identifiants invalides ou accès non autorisé.',
          'user': null,
        };
      }

      if (response.statusCode == 422) {
        return {
          'ok': false,
          'message': data?['message'] ?? 'Identifiants incorrects',
          'user': null,
        };
      }

      return {
        'ok': false,
        'message': data?['message'] ??
            'Erreur serveur (${response.statusCode})',
        'user': null,
      };

    } catch (e) {
      return {
        'ok': false,
        'message': 'Erreur inattendue pendant la connexion API.',
        'user': null,
      };
    }
  }

  // Vérification du code 2FA
  Future<Map<String, dynamic>> verifyTwoFa(
    String email,
    String code,
  ) async {
    final url = Uri.parse(
      '${AppConfig.apiBaseUrl}/mobile/verify-2fa',
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'code': code,
        }),
      ).timeout(const Duration(seconds: 45));

      Map<String, dynamic> data = {};

      if (response.body.isNotEmpty) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map<String, dynamic>) {
          data = decoded;
        }
      }

      if (response.statusCode == 200) {
        final token = data['token']?.toString();

        if (token != null && token.isNotEmpty) {
          return {
            'ok': true,
            'token': token,
            'utilisateur': data['utilisateur'],
          };
        }
      }

      return {
        'ok': false,
        'message': data['message']?.toString() ??
            'Erreur de vérification du code.',
      };

    } catch (e) {
      return {
        'ok': false,
        'message': 'Impossible de contacter le serveur.',
      };
    }
  }
}
