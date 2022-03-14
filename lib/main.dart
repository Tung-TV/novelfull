import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novelfull/screens/bottom_nav.dart';
import 'package:novelfull/screens/home.dart';
import 'package:novelfull/screens/user.dart';
import 'package:novelfull/screens/welcome.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
    apiKey: "AIzaSyBMbENW4EVIpW6mL_JC81gGb0ERc69-TLw",
    authDomain: "novelfull-ef949.firebaseapp.com",
  projectId: "novelfull-ef949",
    storageBucket: "novelfull-ef949.appspot.com",
  messagingSenderId: "342215247140",
  appId: "1:342215247140:web:e2992a0b6d020f06df1fb1",
  measurementId: "G-QY1PLNGR8W"
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Tương Tư Các',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: BotttomNav());
  }
}
