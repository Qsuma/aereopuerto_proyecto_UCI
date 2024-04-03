import 'dart:convert';


import 'package:aereopuerto/models/boleto.dart';
import 'package:aereopuerto/utils/preferencias_usuario.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BoletoProvider extends ChangeNotifier{
List<Boleto> boletos =[];


int page =0;
final String _baseUrl ='192.168.2.103:80';
Future<String> _postBoleto(String endpoint,Map<String,dynamic> body) async {
 final prefs = PreferenciasUsuario();  
final url =Uri.http(_baseUrl,endpoint,{});

    try {
    final response = await http.post(url, body: body, headers: {
      'auth-token': prefs.token
      
      
      });

    if (response.statusCode == 200||response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Error al crear los datos: ${response.statusCode}');
    }
 } catch (e) {
    throw Exception('Error al realizar la solicitud: $e');
 }
  } 
Future<String> _deleteBoleto(String endpoint, ) async {
 final prefs = PreferenciasUsuario();  
final url =Uri.http(_baseUrl,endpoint,{});

    try {
    final response = await http.delete(url, headers: {
      'auth-token': prefs.token
      
      
      });

    if (response.statusCode == 200) {
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
Future<String> _patchBoleto(String endpoint,Map<String,dynamic> body) async {
 final prefs = PreferenciasUsuario();  
final url =Uri.http(_baseUrl,endpoint,{});

    try {
    final response = await http.patch(url,body:body);

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
getBoletos()async{
  final jsonData = await _getJsonData('/core/api/v1/Boleto/');
  final BoletosResponse = ListarBoleto.fromJson(jsonData);
  boletos=BoletosResponse.results;
  notifyListeners();
  return ;
}
deleteBoletos(String id)async{
  final response = await _deleteBoleto('/core/api/v1/Boleto/$id');
  if (response == 'Eliminado Con Exito') {
     boletos.removeWhere((boleto) => boleto.cdigo == int.parse(id));
  notifyListeners();
  return ;
}











}
patchBoleto(String idboleto, String asiento, String codigo) async {

  final body = {
    "idboleto": idboleto,
    "asiento":asiento,
    "codigo": codigo
};
 final responseBody = await _patchBoleto('/core/api/v1/Boleto/$idboleto', body);

  // Suponiendo que el servidor devuelve el vuelo actualizado en formato JSON
  final updatedBoletoJson = json.decode(responseBody);
  final updatedBoleto = Boleto.fromJson(updatedBoletoJson);

  boletos = boletos.map((boleto) {
    if (boleto.idboleto == updatedBoleto.idboleto) {
      return updatedBoleto;
    } else {
      return boleto;
    }
  }).toList();
  notifyListeners();
  return ;
}
postBoleto(String asiento, String codigo ) async {
   final body = {
   // "idboleto":"67",
    "asiento": asiento,
    "código": codigo
};
 final responseBody = await _postBoleto('/core/api/v1/Boleto/', body);

 // Suponiendo que el servidor devuelve el Boleto actualizado en formato JSON
 final updatedBoletoJson = json.decode(responseBody);
 final updatedBoleto = Boleto.fromJson(updatedBoletoJson);

 // Actualizar la lista de boletos con el boleto actualizado
 boletos.add(updatedBoleto);

 notifyListeners();
}

}