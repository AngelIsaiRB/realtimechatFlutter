import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;


import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';

class AuthService with ChangeNotifier{

  Usuario usuario;
  bool _autenticando=false;

  bool get autenticando => this._autenticando;
  set autenticando(bool valor){
    this._autenticando=valor;
    notifyListeners();
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
   if(resp.statusCode==200){
    final loginresponse= loginResponseFromJson(resp.body);
    this.usuario=loginresponse.usuario;
    this.autenticando=false;
    //TODO:
    return true;
   }
   else
   {
     this.autenticando=false;
     return false;
   }

   
 }

}