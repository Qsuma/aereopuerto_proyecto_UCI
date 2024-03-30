import 'package:meta/meta.dart';
import 'dart:convert';

class Avion {
    int idavin;
    String tipo;
    String fabricante;
    int capacidad;
    int alcance;
    int velocidadCrucero;
    String compaia;

    Avion({
        required this.idavin,
        required this.tipo,
        required this.fabricante,
        required this.capacidad,
        required this.alcance,
        required this.velocidadCrucero,
        required this.compaia,
    });

    factory Avion.fromRawJson(String str) => Avion.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Avion.fromJson(Map<String, dynamic> json) => Avion(
        idavin: json["idavión"],
        tipo: json["tipo"],
        fabricante: json["fabricante"],
        capacidad: json["capacidad"],
        alcance: json["alcance"],
        velocidadCrucero: json["velocidad_crucero"],
        compaia: json["compañia"],
    );

    Map<String, dynamic> toJson() => {
        "idavión": idavin,
        "tipo": tipo,
        "fabricante": fabricante,
        "capacidad": capacidad,
        "alcance": alcance,
        "velocidad_crucero": velocidadCrucero,
        "compañia": compaia,
    };
}
