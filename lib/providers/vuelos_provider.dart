import 'dart:convert';


import 'package:aereopuerto/models/Vuelo.dart';
import 'package:aereopuerto/utils/preferencias_usuario.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VuelosProvider extends ChangeNotifier{
List<Vuelo> Vuelos =[];


int page =0;
final String _baseUrl ='192.168.2.103:80';
Future<String> _postVuelo(String endpoint,Map<String,dynamic> body) async {
 final prefs = PreferenciasUsuario();  
final url =Uri.http(_baseUrl,endpoint,{});

    try {
    final response = await http.post(url, body: body, headers: {
      'auth-token': prefs.token
      
      
      });

    if (response.statusCode == 200||response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Error al crear los datos: ${response.statusCode}');
    }
 } catch (e) {
    throw Exception('Error al realizar la solicitud: $e');
 }
  } 
Future<String> _deleteVuelo(String endpoint, ) async {
 final prefs = PreferenciasUsuario();  
final url =Uri.http(_baseUrl,endpoint,{});

    try {
    final response = await http.delete(url, headers: {
      'auth-token': prefs.token
      
      
      });

    if (response.statusCode == 200||response.statusCode == 204) {
      return 'Eliminado Con Exito';
    } else {
     return 'Error al Conectar con el Server:-${response.statusCode}';
    }
 } catch (e) {
    return'Error al realizar la solicitud: $e';
 }
  }
Future<String> _getJsonData(String endpoint, {int page = 1}) async {
 final prefs = PreferenciasUsuario();  
final url =Uri.http(_baseUrl,endpoint,{});

    try {
    final response = await http.get(url, headers: {
      'auth-token': prefs.token
      
      
      });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al obtener los datos: ${response.statusCode}');
    }
 } catch (e) {
    throw Exception('Error al realizar la solicitud: $e');
 }
  }  
Future<String> _patchVuelo(String endpoint,Map<String,dynamic> body) async {
 final prefs = PreferenciasUsuario();  
final url =Uri.http(_baseUrl,endpoint,{});

    try {
    final response = await http.patch(url,body:body , headers: {
      'auth-token': prefs.token
      
      
      });

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al obtener los datos: ${response.statusCode}');
    }
 } catch (e) {
    throw Exception('Error al realizar la solicitud: $e');
 }
  }  
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
getVuelos()async{
  final jsonData = await _getJsonData('/core/api/v1/Vuelo/');
  final VuelosResponse = ListarVuelos.fromJson(jsonData);
  Vuelos=VuelosResponse.results;
  notifyListeners();
  return ;
}
deleteVuelos(String id)async{
  final response = await _deleteVuelo('/core/api/v1/Vuelo/$id/');
  if (response == 'Eliminado Con Exito') {
     Vuelos.removeWhere((Vuelo) => Vuelo.cdigov == int.parse(id));
  notifyListeners();
  return ;
}











}
patchVuelo(String codigov, String origen, String destino, DateTime fecha) async {

  final body = {
    "códigov": codigov,
    "origen": origen,
    "destino": destino,
    "fechav": fecha.toIso8601String().split('T')[0]
};
 final responseBody = await _patchVuelo('/core/api/v1/Vuelo/$codigov/', body);

  // Suponiendo que el servidor devuelve el vuelo actualizado en formato JSON
  final updatedVueloJson = json.decode(responseBody);
  final updatedVuelo = Vuelo.fromJson(updatedVueloJson);

  Vuelos = Vuelos.map((Vuelo) {
    if (Vuelo.cdigov == updatedVuelo.cdigov) {
      return updatedVuelo;
    } else {
      return Vuelo;
    }
  }).toList();
  notifyListeners();
  return ;
}
postVuelo(String codigov, String origen, String destino, DateTime fecha ) async {
   final body = {
    "códigov": "7772",
    "origen": origen,
    "destino": destino,
    "fechav": fecha.toIso8601String().split('T')[0]
};
 final responseBody = await _postVuelo('/core/api/v1/Vuelo/', body);

 // Suponiendo que el servidor devuelve el Vuelo actualizado en formato JSON
 final updatedVueloJson = json.decode(responseBody);
 final updatedVuelo = Vuelo.fromJson(updatedVueloJson);

 // Actualizar la lista de Vuelos con el Vuelo actualizado
 Vuelos.add(updatedVuelo);

 notifyListeners();
}

}