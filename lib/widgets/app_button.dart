import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final Color color;
  String? text;
  IconData? icon;
  final Color backgroundColor;
  double size;
  bool? isIcon;
  final Color borderColor;
  AppButton({Key? key,
    this.isIcon=false,
    this.text="hi",
    this.icon,
    required this.size,
    required this.color,
    required this.backgroundColor,
    required this.borderColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width:1.0,
        ),

          borderRadius: BorderRadius.circular(15),
          color: Colors.blueAccent
      ),
      child: isIcon==false?Center(child: Text(text!,style: TextStyle(color: Colors.white), )):Center(child: Icon(icon, color: color,)),
    );
  }
}
