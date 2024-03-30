import 'package:meta/meta.dart';
import 'dart:convert';
class ListarBoleto {
  ListarBoleto({
    required this.results,
  });

  List<Vuelo> results;

  factory ListarBoleto.fromJson(String str) =>
      ListarBoleto.fromMap(json.decode(str));

  factory ListarBoleto.fromMap(List<dynamic> json) => ListarBoleto(
        results: List<Vuelo>.from(json.map((x) => Vuelo.fromJson(x))),
      );
}
class Vuelo {
    int idboleto;
    int asiento;
    int cdigo;

    Vuelo({
        required this.idboleto,
        required this.asiento,
        required this.cdigo,
    });

    factory Vuelo.fromRawJson(String str) => Vuelo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Vuelo.fromJson(Map<String, dynamic> json) => Vuelo(
        idboleto: json["idboleto"],
        asiento: json["asiento"],
        cdigo: json["codigo"],
    );

    Map<String, dynamic> toJson() => {
        "idboleto": idboleto,
        "asiento": asiento,
        "código": cdigo,
    };
}
