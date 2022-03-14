import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novelfull/screens/bottom_nav_detail_novel.dart';
import 'package:novelfull/screens/detail_novel.dart';

import '../controller/controllerHome.dart';

class TruyenMoi extends StatefulWidget {
  const TruyenMoi({Key? key}) : super(key: key);

  @override
  _TruyenMoiState createState() => _TruyenMoiState();
}

class _TruyenMoiState extends State<TruyenMoi> {
  final allNovelController = Get.put(AllNovelController());

  @override
  Widget build(BuildContext context) {
    //hiển thị toàn bộ truyện
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("user-novels").get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
            itemCount: allNovelController.novels.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 10, left: 10),
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(allNovelController.novels[index].urlImage.toString()),
                    SizedBox(width: 10,),
                    Container(
                    width: 206,
                    height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(allNovelController.novels[index].name.toString(),maxLines: 2,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),overflow: TextOverflow.ellipsis,)),
                            SizedBox(height: 5,),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text("Tác giả: "+allNovelController.novels[index].tacgia.toString(),maxLines: 1,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 14),overflow: TextOverflow.ellipsis)),
                            SizedBox(height: 5,),
                           Align(
                            alignment: Alignment.topLeft,
                            child: Text(allNovelController.novels[index].vanan.toString(),maxLines: 3,style:TextStyle(fontSize: 11),overflow: TextOverflow.ellipsis)),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => BottomNavDetailNovel(allNovelController.novels[index].novelid,
                        allNovelController.novels[index].name,
                        allNovelController.novels[index].urlImage,
                        allNovelController.novels[index].tacgia,
                        allNovelController.novels[index].theloai,
                        allNovelController.novels[index].vanan
                        ));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 20),
                        width: 100,
                        height: 50,
                        child: Align(
                            alignment: Alignment.center, child: Text("Đọc >")),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.orangeAccent,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        
          }
          else if (snapshot.connectionState == ConnectionState.none) {
            return Text("No data");
          }
          return CircularProgressIndicator();
    });
  }
}
