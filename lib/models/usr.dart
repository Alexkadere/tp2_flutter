
class Usr {
  final int idutilisateur;
  final int? idrole;
  final String? nom;
  final String? prenom;
  final String? email;

  const Usr({
    required this.idutilisateur,
    required this.idrole,
    required this.nom,
    required this.prenom,
    required this.email,
  });

  factory Usr.fromJson(Map<String, dynamic> json) {
    int parseId(dynamic value) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      return 0;
    }

    return Usr(
      idutilisateur: parseId(json['idutilisateur']),
      idrole: json['idrole'] == null
          ? null
          : parseId(json['idrole']),
      nom: json['nom']?.toString(),
      prenom: json['prenom']?.toString(),
      email: json['email']?.toString(),
    );
  }
}
