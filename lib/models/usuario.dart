import 'package:meta/meta.dart';
import 'dart:convert';

class Usuario {
    String nombreUsuario;
    String contrasea;
    String nombre;
    String apellidos;
    String sexo;

    Usuario({
        required this.nombreUsuario,
        required this.contrasea,
        required this.nombre,
        required this.apellidos,
        required this.sexo,
    });

    factory Usuario.fromRawJson(String str) => Usuario.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombreUsuario: json["nombre_usuario"],
        contrasea: json["contraseña"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        sexo: json["sexo"],
    );

    Map<String, dynamic> toJson() => {
        "nombre_usuario": nombreUsuario,
        "contraseña": contrasea,
        "nombre": nombre,
        "apellidos": apellidos,
        "sexo": sexo,
    };
}
