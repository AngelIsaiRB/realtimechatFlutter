import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/models/usuario.dart';
class UsuariosPage extends StatefulWidget {
  


  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  
  final usuarioSErvice = new UsuariosService();
  List<Usuario> usuarios=[];
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  void initState() {
   this._cargarUsuarios();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final autservice= Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    final usuario = autservice.usuario;
    return Scaffold(
      appBar: AppBar(
        title: Text(usuario.nombre, style: TextStyle(color: Colors.black87),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black,),          
          onPressed: (){
            socketService.disconnect();
            AuthService.deleteToken();
            Navigator.pushReplacementNamed(context,"login");
          },  
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: (socketService.serverStatus==ServerStatus.Online) ? Icon(Icons.check_circle, color: Colors.blue,)
                   : Icon(Icons.offline_bolt, color: Colors.red,),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.blue[400],),
          waterDropColor: Colors.blue[400],
        ),
        onRefresh: _cargarUsuarios,
        child: _listViewUsers(),
      )
      
    );
}

  ListView _listViewUsers() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_,i)=>_usuarioLitTitle(usuarios[i]),
      separatorBuilder: (_,i)=>Divider(), 
      itemCount: usuarios.length
      
      );
  }

  ListTile _usuarioLitTitle(Usuario usuario) {
    return ListTile(
        title: Text(usuario.nombre),
        subtitle: Text(usuario.email),
        leading: CircleAvatar(
          child: Text(usuario.nombre.substring(0,2)),   
          backgroundColor: Colors.blue[100],         
        ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online? Colors.green[300]: Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
        ),
        onTap: (){
          final chatsevice = Provider.of<ChatServie>(context, listen: false);
          chatsevice.usuarioPara=usuario;
          Navigator.pushNamed(context, "chat");
        },
      );
  }

   _cargarUsuarios() async{
    // await Future.delayed(Duration(milliseconds: 500));
    this.usuarios= await  usuarioSErvice.getUsuarios();
    setState(() {
      
    });
     _refreshController.refreshCompleted();
  }
}