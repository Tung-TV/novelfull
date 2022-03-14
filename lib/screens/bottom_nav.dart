import 'package:flutter/material.dart';
import 'package:novelfull/screens/home.dart';
import 'package:novelfull/screens/phanloai.dart';
import 'package:novelfull/screens/tusach.dart';
import 'package:novelfull/screens/user.dart';

class BotttomNav extends StatefulWidget {
  const BotttomNav({ Key? key }) : super(key: key);

  @override
  _BotttomNavState createState() => _BotttomNavState();
}

class _BotttomNavState extends State<BotttomNav> {
  
  List pages=[
    HomeScreens(),
    PhanLoai(),
    TuSach(),
    User(),
  ];
  int currentIndex = 0;
  void onTap(int index){
    setState(() {
      currentIndex = index;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset : false,
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Color.fromARGB(255, 43, 42, 42).withOpacity(0.3),
        showUnselectedLabels: false,
          showSelectedLabels: false,
          elevation: 0,
          items:[
          BottomNavigationBarItem(label:"Home",icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Phân Loại",icon: Icon(Icons.bookmark)),
          BottomNavigationBarItem(label: "Tủ Sách", icon: Icon(Icons.menu_book)),
          BottomNavigationBarItem(label: "Tôi",icon: Icon(Icons.person)),
        ]
      ),
    );
  }
}