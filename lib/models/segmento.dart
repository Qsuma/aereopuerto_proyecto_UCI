import 'package:meta/meta.dart';
import 'dart:convert';

class Segmento {
    int idsegmento;
    DateTime fecha;
    String hora;
    Clase clase;
    String inicio;
    String fin;
    int idaeropuerto;
    int idavin;
    int cdigov;

    Segmento({
        required this.idsegmento,
        required this.fecha,
        required this.hora,
        required this.clase,
        required this.inicio,
        required this.fin,
        required this.idaeropuerto,
        required this.idavin,
        required this.cdigov,
    });

    factory Segmento.fromRawJson(String str) => Segmento.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Segmento.fromJson(Map<String, dynamic> json) => Segmento(
        idsegmento: json["idsegmento"],
        fecha: DateTime.parse(json["fecha"]),
        hora: json["hora"],
        clase: claseValues.map[json["clase"]]!,
        inicio: json["inicio"],
        fin: json["fin"],
        idaeropuerto: json["idaeropuerto"],
        idavin: json["idavión"],
        cdigov: json["códigov"],
    );

    Map<String, dynamic> toJson() => {
        "idsegmento": idsegmento,
        "fecha": "${fecha.year.toString().padLeft(4, '0')}-${fecha.month.toString().padLeft(2, '0')}-${fecha.day.toString().padLeft(2, '0')}",
        "hora": hora,
        "clase": claseValues.reverse[clase],
        "inicio": inicio,
        "fin": fin,
        "idaeropuerto": idaeropuerto,
        "idavión": idavin,
        "códigov": cdigov,
    };
}

enum Clase {
    ECONMICA,
    EJECUTIVA
}

final claseValues = EnumValues({
    "económica": Clase.ECONMICA,
    "ejecutiva": Clase.EJECUTIVA
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
