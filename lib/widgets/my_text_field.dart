import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final int maxline;
  final bool textArea;
  final TextEditingController? controller;
  final Widget? widget;
  const MyInputField({Key? key, required this.title, required this.hint
  , this.controller,this.widget, required this.maxline, required this.textArea})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(top:16,left:15, right:15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
         Container(
           padding: EdgeInsets.only(left:14) ,
           height: textArea?104:52,
            margin: const EdgeInsets.only(top:8.0),
           decoration: BoxDecoration(
             border: Border.all(
               color: Colors.grey,
               width: 1.0
             ),
            borderRadius: BorderRadius.circular(12)
           ) ,
           child: Row(
             children: [
               Expanded(
                 child: TextFormField(
                  keyboardType: TextInputType.multiline,
                   maxLines: maxline ,
                   readOnly: widget==null?false:true,
                    autofocus: false,
                    cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey,
                    controller: controller,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(fontSize: 14),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:  context.theme.backgroundColor,
                          width: 0
                        ) ),
                          enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color:  context.theme.backgroundColor,
                          width: 0
                        )
                         )
                    ),
                 )
                  ),
                  widget==null?Container():Container(child: widget,)
             ],
           ),
           
         )
        ],
      ),
    );
  }
}
