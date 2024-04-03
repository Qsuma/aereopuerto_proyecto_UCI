import 'package:meta/meta.dart';
import 'dart:convert';
class ListarReservacion {
  ListarReservacion({
    required this.results,
  });

  List<Reservacion> results;

  factory ListarReservacion.fromJson(String str) =>
      ListarReservacion.fromMap(json.decode(str));

  factory ListarReservacion.fromMap(List<dynamic> json) => ListarReservacion(
        results: List<Reservacion>.from(json.map((x) => Reservacion.fromJson(x))),
      );
}
class Reservacion {
    int cdigo;
    DateTime fechaCaducidad;
    DateTime fechar;
    String nombreUsuario;
    int cdigov;

    Reservacion({
        required this.cdigo,
        required this.fechaCaducidad,
        required this.fechar,
        required this.nombreUsuario,
        required this.cdigov,
    });

    factory Reservacion.fromRawJson(String str) => Reservacion.fromJson(json.decode(str));



    factory Reservacion.fromJson(Map<String, dynamic> json) => Reservacion(
        cdigo: json["código"],
        fechaCaducidad: DateTime.parse(json["fecha_caducidad"]),
        fechar: DateTime.parse(json["fechar"]),
        nombreUsuario: json["nombre_usuario"],
        cdigov: json["códigov"],
    );

    Map<String, dynamic> toJson() => {
        "código": cdigo,
        "fecha_caducidad": "${fechaCaducidad.year.toString().padLeft(4, '0')}-${fechaCaducidad.month.toString().padLeft(2, '0')}-${fechaCaducidad.day.toString().padLeft(2, '0')}",
        "fechar": "${fechar.year.toString().padLeft(4, '0')}-${fechar.month.toString().padLeft(2, '0')}-${fechar.day.toString().padLeft(2, '0')}",
        "nombre_usuario": nombreUsuario,
        "códigov": cdigov,
    };
}
