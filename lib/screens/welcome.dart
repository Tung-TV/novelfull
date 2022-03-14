import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:novelfull/widgets/app_button.dart';
class WelcomeScreens extends StatefulWidget {
  const WelcomeScreens({Key? key}) : super(key: key);

  @override
  _WelcomeScreensState createState() => _WelcomeScreensState();
}

class _WelcomeScreensState extends State<WelcomeScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Row(
       mainAxisAlignment: MainAxisAlignment.center,
       crossAxisAlignment: CrossAxisAlignment.center,
       children: [
        Text("TƯƠNG TƯ CÁC", style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 97, 177)),),
        SizedBox(height: 10,),
        Text("Hãy để chúng tôi giúp bạn vào thế giới hư ảo", style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.normal),),
        SizedBox(height: 20,),
        AppButton(size: 30, color: Colors.white, backgroundColor: Colors.blue, borderColor: Colors.blue),
       ],
     ),
     
      

    );
  }
}
