import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novelfull/screens/detail_chapter.dart';

import '../controller/controllerChapter.dart';

class Chapters extends StatefulWidget {
  var idnovel;
  Chapters(this.idnovel);

  @override
  _ChaptersState createState() => _ChaptersState();
}

class _ChaptersState extends State<Chapters> {
  @override
  Widget build(BuildContext context) {
    final chapterController = Get.put(ChapterController(widget.idnovel));
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("user-novels")
            .doc(widget.idnovel)
            .collection("chapter")
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // hiện thị danh sách chương của truyện
            return Obx(() => ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                      // chuyển đến thông tin chương khi click vào
                        await Get.to(() => DetailChapter(index+1,widget.idnovel));
                      },
                      child: Center(
                        child: Container(
                          height: 40,
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(chapterController.chapter[index].tieude
                                .toString(),style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal),),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: chapterController.chapter.length,
                ));
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Text("No data");
          }
          return CircularProgressIndicator();
        });
  }
}
