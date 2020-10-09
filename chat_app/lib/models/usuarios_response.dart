// To parse this JSON data, do
//
//     final ususariosResponse = ususariosResponseFromJson(jsonString);

import 'dart:convert';

import 'package:chat_app/models/usuario.dart';

UsusariosResponse ususariosResponseFromJson(String str) => UsusariosResponse.fromJson(json.decode(str));

String ususariosResponseToJson(UsusariosResponse data) => json.encode(data.toJson());

class UsusariosResponse {
    UsusariosResponse({
        this.ok,
        this.usuarios,
      
    });

    bool ok;
    List<Usuario> usuarios;
  

    factory UsusariosResponse.fromJson(Map<String, dynamic> json) => UsusariosResponse(
        ok: json["ok"],
        usuarios: List<Usuario>.from(json["usuarios"].map((x) => Usuario.fromJson(x))),
        
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "usuarios": List<dynamic>.from(usuarios.map((x) => x.toJson())),
       
    };
}


 
