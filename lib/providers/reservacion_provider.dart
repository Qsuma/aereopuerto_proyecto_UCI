import 'dart:convert';


import 'package:aereopuerto/models/reservacion.dart';
import 'package:aereopuerto/utils/preferencias_usuario.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReservacionProvider extends ChangeNotifier{
List<Reservacion> reservacion =[];

int  codigo =81;
int page =0;
final String _baseUrl ='192.168.2.103:80';
Future<String> _postReservacion(String endpoint,Map<String,dynamic> body) async {
 final prefs = PreferenciasUsuario();  
final url =Uri.http(_baseUrl,endpoint,{});

    try {
    final response = await http.post(url, body: body);

    if (response.statusCode == 200||response.statusCode == 201) {
      return response.body;
    } else {
      throw Exception('Error al crear los datos: ${response.statusCode}');
    }
 } catch (e) {
    throw Exception('Error al realizar la solicitud: $e');
 }
  } 
Future<String> _deleteReservacion(String endpoint, ) async {
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
Future<String> _patchReservacion(String endpoint,Map<String,dynamic> body) async {
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
getReservacions()async{
  final jsonData = await _getJsonData('/core/api/v1/Reservacin/');
  final ReservacionsResponse = ListarReservacion.fromJson(jsonData);
  reservacion=ReservacionsResponse.results;
  notifyListeners();
  return ;
}
postReservacion( String usuario,String codigov,DateTime fecha)async{
  codigo++;
  
  final body={
    
    "código": codigo.toString(),
    "fecha_caducidad":fecha.add(const Duration(days: 20)).toIso8601String().split('T')[0],
    "fechar": fecha.toIso8601String().split('T')[0],
    "nombre_usuario": 
    'carolmn',
    "códigov": codigov

  };
  final jsonData = await _postReservacion('/core/api/v1/Reservacin/',body);
  // final ReservacionsResponse = ListarReservacion.fromJson(jsonData);
  // reservacion=ReservacionsResponse.results;
  // notifyListeners();
  return ;
}
deleteReservacions(String id)async{
  final response = await _deleteReservacion('/core/api/v1/Reservacin/$id/');
  if (response == 'Eliminado Con Exito') {
     reservacion.removeWhere((reservacion) => reservacion.cdigov == int.parse(id));
  notifyListeners();
  return ;
}
}}