import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';

class AuthService with ChangeNotifier{

  Usuario usuario;
  bool _autenticando=false;
  //storage 
final _storage =  new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor){
    this._autenticando=valor;
    notifyListeners();
    }
// getters del token de forma estatica

  static Future <String> getToken() async{
    final _storage =  new FlutterSecureStorage();
    final token= await _storage.read(key: "token");
    return token;
  }

  static Future <void> delete() async{
    final _storage =  new FlutterSecureStorage();
    final token= await _storage.delete(key: "token");
    
  }


 Future<bool> login (String email, String password)async{
   this.autenticando=true;
   final data= {
     "email":email,
     "password":password
   };

   final resp = await  http.post("${Environment.apiUrl}/login",
   body: jsonEncode(data),
   headers: {
     "Content-Type": "application/json"
   }   
   );
   print (resp.body);
   this.autenticando=false;
   if(resp.statusCode==200){
    final loginresponse= loginResponseFromJson(resp.body);
    this.usuario=loginresponse.usuario;    
    await this._guardarToken(loginresponse.token);
    return true;
   }
   else
   {
     
     return false;
   }

   
 }

   Future _guardarToken(String token)async {

    return  await _storage.write(key: "token", value: token);      
  }

  Future logOut()async {

    return await _storage.delete(key: "token");
  }

}