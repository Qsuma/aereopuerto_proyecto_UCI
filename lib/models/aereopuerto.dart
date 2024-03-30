import 'package:meta/meta.dart';
import 'dart:convert';

class Aeropuerto {
    int idaeropuerto;
    String nombre;
    String ciudad;

    Aeropuerto({
        required this.idaeropuerto,
        required this.nombre,
        required this.ciudad,
    });

    factory Aeropuerto.fromRawJson(String str) => Aeropuerto.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Aeropuerto.fromJson(Map<String, dynamic> json) => Aeropuerto(
        idaeropuerto: json["idaeropuerto"],
        nombre: json["nombre"],
        ciudad: json["ciudad"],
    );

    Map<String, dynamic> toJson() => {
        "idaeropuerto": idaeropuerto,
        "nombre": nombre,
        "ciudad": ciudad,
    };
}
