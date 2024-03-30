import 'package:meta/meta.dart';
import 'dart:convert';

class Boleto {
    int idboleto;
    int asiento;
    int cdigo;

    Boleto({
        required this.idboleto,
        required this.asiento,
        required this.cdigo,
    });

    factory Boleto.fromRawJson(String str) => Boleto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Boleto.fromJson(Map<String, dynamic> json) => Boleto(
        idboleto: json["idboleto"],
        asiento: json["asiento"],
        cdigo: json["código"],
    );

    Map<String, dynamic> toJson() => {
        "idboleto": idboleto,
        "asiento": asiento,
        "código": cdigo,
    };
}
