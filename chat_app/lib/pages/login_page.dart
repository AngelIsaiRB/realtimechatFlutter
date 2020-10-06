import 'package:chat_app/helpers/alerta.dart';
import 'package:chat_app/widgets/btn_azul.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/widgets/custom_imput.dart';
import 'package:chat_app/widgets/label_widget.dart';
import 'package:chat_app/widgets/logo_widget.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height*0.95,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                  Logo(titulo: "Login",),
                  _Form(),
                  Labels(ruta: "register",texaviso: "¿No tienes cuenta?",textdown: "Crear una ahora!", ),
                  Text("terminos y condiciones", style: TextStyle(fontWeight: FontWeight.w200),)
            ],
        ),
          ),
           ),
      ),
    );
}
}




class _Form extends StatefulWidget {
 

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController=TextEditingController();
  final passwCrdcontroller=TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    final authService= Provider.of<AuthService>(context);
    return Container(
      margin: EdgeInsets.only(top:40),
      padding: EdgeInsets.symmetric(horizontal: 50),
       child: Column(
         children: [
           CustomInput(
             icon: Icons.mail_outline,
             placeholder: "correo",
             keyboartipe: TextInputType.emailAddress,
              texcontroller: emailController,
           ),
           CustomInput(
             icon: Icons.lock_outline,
             placeholder: "contraseña",             
            texcontroller: passwCrdcontroller,
            isPasword: true,
           ),
           BtnAzul(
             placeholder: "Ingresar",
             onpress: authService.autenticando ? null : ()async {   
               FocusScope.of(context).unfocus();
               final loginOk = await authService.login(emailController.text.trim(), passwCrdcontroller.text.trim());               
               if(loginOk){
                 //otrapantalla
               }
               else{
                 //mostrar alerta
                 mostrarAlerta(context, "credenciales incorrectas", "reintentalo");
               }
             },
           ),
         ],
       ),
    );
  }
}

