import 'package:meta/meta.dart';
import 'dart:convert';

class Empleado {
    String nombreUsuario;
    String turno;
    DateTime fechaContratacin;

    Empleado({
        required this.nombreUsuario,
        required this.turno,
        required this.fechaContratacin,
    });

    factory Empleado.fromRawJson(String str) => Empleado.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Empleado.fromJson(Map<String, dynamic> json) => Empleado(
        nombreUsuario: json["nombre_usuario"],
        turno: json["turno"],
        fechaContratacin: DateTime.parse(json["fecha_contratación"]),
    );

    Map<String, dynamic> toJson() => {
        "nombre_usuario": nombreUsuario,
        "turno": turno,
        "fecha_contratación": "${fechaContratacin.year.toString().padLeft(4, '0')}-${fechaContratacin.month.toString().padLeft(2, '0')}-${fechaContratacin.day.toString().padLeft(2, '0')}",
    };
}
