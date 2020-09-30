import 'package:flutter/material.dart';
class Labels extends StatelessWidget {
  final String ruta;
  final String textdown;
  final String texaviso;

  const Labels({
    Key key, 
    @required this.ruta,
    @required this.textdown,
    @required this.texaviso,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(this.texaviso, style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),),
          SizedBox(height: 10,),
          GestureDetector(
            child: Text(this.textdown, style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold),),
            onTap: (){
              Navigator.pushReplacementNamed(context, this.ruta);
            },
            )
        ],
      ),
    );
  }
}