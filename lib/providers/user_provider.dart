import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';




class UserProvider extends ChangeNotifier {
  final dio = Dio();


 

  UserProvider();
  Future<Map<String, dynamic>> registerUser(
      String nombre, String apellido, String correo, String password) async {
    final authData = {
      'name': nombre,
      'lastname': apellido,
      'email': correo,
      'password': password
    };

    final response = await dio.post(
        //TODO:URL PARA LOGUIN 
    '',
        data: authData);
   
    Map<String, dynamic> decodedResp = json.decode(response.data);
    

    if (decodedResp.containsKey('valid')) {
   //  token = decodedResp['valid'].toString();
      return {'ok': true};
    } else {
      return {'ok': false, 'mensaje': decodedResp['message']};
    }
    
  }
  
 
 
  Future<Map<String, dynamic>> loginUser(String correo, String password) async {
    Map<String, String> authData = {'email': correo, 'password': password};
   

    json.encode(authData);

    final response = await dio.post(
         //TODO:URL PARA LOGUIN
          '',
        data: authData);
    final Map<String, dynamic> decodedResp = json.decode(response.data);
   if(decodedResp.containsKey('token')){
  //  _global.Token = decodedResp['token'];
    return { 'ok':true};
    }
   return{'ok': false, 'mensaje': decodedResp['message']};
   
   
   
   
   
    
}

     }

