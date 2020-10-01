import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

 final _texcontroller = new TextEditingController();
 final _focusNode =  new FocusNode();
 bool _estaEscribiendo=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text("Te", style: TextStyle(fontSize: 12,)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(height: 3,),
            Text("nombre de usuario", style: TextStyle(color: Colors.black87, fontSize: 12),),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount:100,
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                return Text("data");
               },
              ),
            ),
            Divider(height: 1,),
            Container(
              color: Colors.white,              
              child: _inputChat(),
            )
          ],
        ),
      )
     
    );
}

Widget _inputChat(){
  return SafeArea(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Flexible(
            child: TextField(
            controller: _texcontroller,
            onSubmitted: _handleSubmit,
            onChanged: (String text){
              setState(() {
                if(text.trim().length>0){
                  _estaEscribiendo=true;                  
                }
                else{
                  _estaEscribiendo=false;
                }
              });
            },
            decoration: InputDecoration.collapsed(
              hintText: "enviar mensaje"
              ),
              focusNode: _focusNode,
            ),            
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Platform.isIOS ?
            CupertinoButton(
             child: Text("enviar"),
             onPressed: (){},
            )
            : Container( 
              margin: EdgeInsets.symmetric(horizontal: 4.0) ,
              child: IconTheme(
                data: IconThemeData(color: Colors.blue[400]),
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(Icons.send,),
                  onPressed:_estaEscribiendo ?()=>_handleSubmit(_texcontroller.text.trim()) : null ,
                ),
              ),
              ),
          )
        ],
      ),
    ),
  );
}


_handleSubmit(String texto){
  print (texto);
  _focusNode.requestFocus();
  _texcontroller.clear();
  setState(() {
    _estaEscribiendo=false;
  });
}
}