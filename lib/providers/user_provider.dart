import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;




class UserProvider extends ChangeNotifier {


final String _baseUrl ='192.168.2.103:80';

 

  UserProvider();
  Future<Map<String, dynamic>> registerUser(
      String id, String nombre, String correo, String password) async {
    final authData = {
    "username":nombre,
    "email" : correo,
    "password": password
};
final url =Uri.http(_baseUrl,'/core/api/v1/User/',{});
    final response = await http.post(
   url,
        body: authData);
   
   
    

    if (response.statusCode ==201||response.statusCode ==200) {
   //  token = decodedResp['valid'].toString();
      return {'ok': true};
    } else {
      return {'ok': false, 'mensaje': response.reasonPhrase};
    }
    
  }
  
 
 
  Future<Map<String, dynamic>> loginUser(String correo, String password) async {
    Map<String, String> authData = {'username': correo, 'password': password};
   

    json.encode(authData);
    final url =Uri.http(  _baseUrl,"/core/login/");
    final response = await http.post(
          url,
        body: authData);
    final Map<String, dynamic> decodedResp = json.decode(response.body);
   if(decodedResp['message']=='Username and password correct'){
  //  _global.Token = decodedResp['token'];
    return { 'ok':true};
    }
   return{'ok': false, 'mensaje': decodedResp['message']};
   
   
   
   
   
    
}

     }

