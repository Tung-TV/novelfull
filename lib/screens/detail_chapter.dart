import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:novelfull/models/chapter_model.dart';
import 'package:novelfull/screens/chapter.dart';

import '../controller/controllerChapter.dart';

class DetailChapter extends StatefulWidget {
  var stt;
  var idnovel;

  DetailChapter(this.stt, this.idnovel);

  @override
  _DetailChapterState createState() => _DetailChapterState();
}

class _DetailChapterState extends State<DetailChapter> {
  bool _isVisible = true;
   ScrollController controller = ScrollController();
  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        _isVisible =
            controller.position.userScrollDirection == ScrollDirection.forward;
      });
    });
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    
    final chapterControler = Get.put(ChapterController(widget.idnovel));
    RxList<ChapterModel> chapter = RxList<ChapterModel>([]);
    chapter.bindStream(chapterControler.getChapterBynum(widget.stt.toString()));
    return Scaffold(
      appBar: _appBar(context),
      body: 
          FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("user-novels")
                  .doc(widget.idnovel)
                  .collection("chapter")
                  .get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  //hiển thị nội dung chương
                       return ListView(
                         children:[
                                Container(
                                         margin: const EdgeInsets.only(left: 20, right: 20),
                                         child: Text(
                                           chapter[0].noidung.toString(),
                                           style: TextStyle(
                                             fontSize: 16,
                                           ),
                                         ),
                                       ),
                     
                         ]
                       );
          
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return Text("No data");
                }
                return CircularProgressIndicator();
               }),
        
      bottomNavigationBar: Offstage(
        offstage: !_isVisible,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //Nút quay lại chương trước, nếu là chương đầu sẽ show ra thông báo
            IconButton(
                onPressed: () {
                  setState(() {
                    if (widget.stt > 1) {
                      widget.stt = widget.stt - 1;
                    } else if (widget.stt == 1) {
                      showDialog(context: context, builder: (_)=>AlertDialog(title: Text("Đây là chương đầu"),));
                    } else {
                      print("Null");
                    }
                  });
                },
                icon: Icon(Icons.arrow_back)),
            // Nút show ra danh sách chương của truyện
            IconButton(
                onPressed: () {
                  setState(() {
                    Get.to(() => Chapters(widget.idnovel));
                  });
                },
                icon: Icon(Icons.menu)),
            //Nút mở chương kế tiếp, nếu là chương cuối sẽ show ra thông báo
            IconButton(
                onPressed: () {
                  setState(() {
                    if (widget.stt < chapterControler.chapter.length) {
                      widget.stt = widget.stt + 1;
                    } else if (widget.stt == chapterControler.chapter.length)
                      showDialog(context: context, builder: (_)=>AlertDialog(title: Text("Chưa có chương mới"),));
                    else
                      print("Trống");
                  });
                },
                icon: Icon(Icons.arrow_forward)),
          ],
        ),
      ),
    );
  }

  _appBar(BuildContext context) {
    final chapterControler = Get.put(ChapterController(widget.idnovel));
    RxList<ChapterModel> chapter = RxList<ChapterModel>([]);
    chapter.bindStream(chapterControler.getChapterBynum(widget.stt.toString()));
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios, size: 20, color: Colors.grey),
      ),
      title: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("user-novels")
              .doc(widget.idnovel)
              .collection("chapter")
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Text(
                chapter[0].tieude.toString(),
                style: TextStyle(color: Colors.black),
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Text("No data");
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
