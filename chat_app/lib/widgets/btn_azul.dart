import 'package:flutter/material.dart';


class BtnAzul extends StatelessWidget {
  final String placeholder;
  final Function onpress;

  const BtnAzul({Key key,  
  @required this.placeholder, 
  @required this.onpress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      hoverElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(this.placeholder, style: TextStyle(color: Colors.white, fontSize: 17),),
        ),
      ),
      onPressed: this.onpress,
    );
  }
}