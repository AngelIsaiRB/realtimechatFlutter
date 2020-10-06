import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

mostrarAlerta(BuildContext context, String titulo, String subtitulo){

  if (Platform.isAndroid) {
  showDialog(context: context,
      builder: (_)=>AlertDialog(
        title: Text(titulo),
        content: Text(subtitulo),
        actions: [
          MaterialButton(
            child: Text("OK"),
            textColor: Colors.blue,
            onPressed: ()=>Navigator.pop(context),
          )
        ],
      )
  );
  }
 else{
   
  showCupertinoDialog(
    context: context,
    builder: (_)=>CupertinoAlertDialog(
      title: Text(titulo),
        content: Text(subtitulo),
        actions: [
          CupertinoButton(
            child: Text("OK"),           
            onPressed: ()=>Navigator.pop(context),
          )
        ],
    )

  );
 }
}