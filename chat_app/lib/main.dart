
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
 
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/routes/routes.dart' as Rutas;
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      
      providers: [
        ChangeNotifierProvider(create: (_)=>AuthService(),),
        ChangeNotifierProvider(create: (_)=>SocketService(),),
        ChangeNotifierProvider(create: (_)=>ChatServie(),)        
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: "loading",
        routes: Rutas.appRoutes,
      ),
    );
  }
}