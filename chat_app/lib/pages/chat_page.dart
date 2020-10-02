import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

 final _texcontroller = new TextEditingController();
 final _focusNode =  new FocusNode();
 bool _estaEscribiendo=false;
 List<ChatMessage> _messages=[
   
 ];
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
                itemCount:_messages.length,
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                return _messages[index];
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
             onPressed:_estaEscribiendo ?()=>_handleSubmit(_texcontroller.text.trim()) : null ,
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
  if (texto.length==0)return;
  print (texto);
  _focusNode.requestFocus();
  _texcontroller.clear();
  final newMessage = new ChatMessage(
    uid: "123",
    texto: texto,
    animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 200)),
     );
  _messages.insert(0, newMessage);
  newMessage.animationController.forward();
  setState(() {
    _estaEscribiendo=false;
  });
}

@override
  void dispose() {
    //off del socket 
    for(ChatMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }
}