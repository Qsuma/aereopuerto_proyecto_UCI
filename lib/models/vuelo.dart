
import 'dart:convert';


class ListarVueloss {
  ListarVueloss({
    required this.results,
  });

  List<Vuelo> results;

  factory ListarVueloss.fromJson(String str) =>
      ListarVueloss.fromMap(json.decode(str));

  factory ListarVueloss.fromMap(List<dynamic> json) => ListarVueloss(
        results: List<Vuelo>.from(json.map((x) => Vuelo.fromJson(x))),
      );
}




class Vuelo {
    int cdigov;
    String origen;
    String destino;
    DateTime fechav;

    Vuelo({
        required this.cdigov,
        required this.origen,
        required this.destino,
        required this.fechav,
    });

    factory Vuelo.fromRawJson(String str) => Vuelo.fromJson(json.decode(str));

    factory Vuelo.fromJson(Map<String, dynamic> json) => Vuelo(
        cdigov: json["cÃ³digov"],
        origen: json["origen"],
        destino: json["destino"],
        fechav: DateTime.parse(json["fechav"]),
    );

}
