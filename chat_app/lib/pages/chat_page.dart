import 'dart:io';

import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {

 final _texcontroller = new TextEditingController();
 final _focusNode =  new FocusNode();


  ChatServie chatService;
  SocketService socketService;
  AuthService autService;


 bool _estaEscribiendo=false;
 List<ChatMessage> _messages=[];

  @override
  void initState() {
    super.initState();
    this.chatService= Provider.of<ChatServie>(context, listen: false);
    this.socketService= Provider.of<SocketService>(context, listen: false);
    this.autService= Provider.of<AuthService>(context, listen: false);
    this.socketService.socket.on("mensaje-personal", _escucharmensaje);
  }

  void _escucharmensaje(dynamic payload){
    ChatMessage message = new ChatMessage(
      texto: payload["mensaje"], 
      uid: payload["de"], 
      animationController: AnimationController(vsync: this,duration: Duration(milliseconds: 300))
      );

      setState(() {
        _messages.insert(0,message);
      });
      message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    
    final usuariopara = this.chatService.usuarioPara;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(usuariopara.nombre.substring(0,2), style: TextStyle(fontSize: 12,)),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(height: 3,),
            Text(usuariopara.nombre, style: TextStyle(color: Colors.black87, fontSize: 12),),
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

  this.socketService.emit("mensaje-personal",{
   "de": this.autService.usuario.uid,
   "para": this.chatService.usuarioPara.uid,
    "mensaje": texto
  });
}

@override
  void dispose() {
    //off del socket 
    for(ChatMessage message in _messages){
      message.animationController.dispose();
    }
     this.socketService.socket.off("mensaje-personal");
    super.dispose();
  }
}
