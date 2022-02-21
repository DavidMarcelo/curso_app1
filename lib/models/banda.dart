class Banda {
  String id;
  String name;
  int votes;

  Banda({
    this.id,
    this.name,
    this.votes,
  });

  //Crear una instancia de la clase
  //fromMap recibe una mapa que tiene como llaves un string y un tipo dinamico y lo que realiza,
  factory Banda.fromMap(Map<String, dynamic> obj) => Banda(
        id: obj['id'],
        name: obj['name'],
        votes: obj['votes'],
      );
}
