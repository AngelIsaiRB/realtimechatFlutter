import 'package:chat_app/widgets/btn_azul.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widgets/custom_imput.dart';
import 'package:chat_app/widgets/label_widget.dart';
import 'package:chat_app/widgets/logo_widget.dart';

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
                  Logo(),
                  _Form(),
                  Labels(),
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
             onpress: (){
               print("email: ${emailController.text}");
               print("contrseña: ${passwCrdcontroller.text}");
             },
           ),
         ],
       ),
    );
  }
}

