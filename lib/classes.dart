class Personne {
  // Attributs
  String nom;
  int age;
  double _soldeBancaire;

  // Constructeur
  Personne(this.age, this.nom, this._soldeBancaire);

  // Méthodes
  void saluer() {
    print("Bonjour, je m'appelle $nom et j'ai $age ans.");
  }

  void marcher() {
    print("Je suis en train de marcher ...");
  }

  void deposer(double montant) {
    _soldeBancaire += montant;
  }

  void retirer(double montant) {
    if (montant <= _soldeBancaire) {
      _soldeBancaire -= montant;
    } else {
      print("Fonds insuffisants !");
    }
  }

  double getSoldeBancaire() => _soldeBancaire;
}
