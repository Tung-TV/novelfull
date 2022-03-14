import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novelfull/controller/controllerHome.dart';
import 'package:novelfull/screens/bottom_nav_detail_novel.dart';

import '../models/novel_model.dart';

class SearchTheLoai extends StatefulWidget {
  var theloai;
  SearchTheLoai(this.theloai);

  @override
  State<SearchTheLoai> createState() => _SearchTheLoaiState();
}

class _SearchTheLoaiState extends State<SearchTheLoai> {
  @override
  Widget build(BuildContext context) {
    final allNovelController = Get.put(AllNovelController());
    RxList<NovelModel> theloai = RxList<NovelModel>([]);
    theloai.bindStream(allNovelController.getTheloaiNovels(widget.theloai));
    return Scaffold(
      appBar: _appBar(context),
      //hiển thị danh sách truyện đúng với thể loại được chọn
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("user-novels")
              .where('theloai', isEqualTo: widget.theloai)
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: theloai.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(theloai[index].urlImage.toString()),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 206,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    theloai[index].name.toString(),
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              SizedBox(
                                height: 5,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                      "Tác giả: " +
                                          theloai[index].tacgia.toString(),
                                      maxLines: 1,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                      overflow: TextOverflow.ellipsis)),
                              SizedBox(
                                height: 5,
                              ),
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(theloai[index].vanan.toString(),
                                      maxLines: 3,
                                      style: TextStyle(fontSize: 11),
                                      overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => BottomNavDetailNovel(theloai[index].novelid.toString(),theloai[index].name,theloai[index].urlImage,theloai[index].tacgia,theloai[index].theloai,theloai[index].vanan));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 20),
                            width: 100,
                            height: 50,
                            child: Align(
                                alignment: Alignment.center,
                                child: Text("Đọc >")),
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
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Text("No data");
            }
            return CircularProgressIndicator();
          }),
    );
  }

  List<String> item = [
    "Đam Mỹ",
    "Ngôn Tình",
    "Hài Hước",
    "Đô Thị",
    "Vườn Trường",
    "Kinh Dị",
    "Huyền Ảo",
    "Tu Tiên"
  ];
  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(Icons.arrow_back_ios, size: 20, color: Colors.grey),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(widget.theloai,style: TextStyle(color: Colors.black),),
          SizedBox(width: 20,),
          DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: TextStyle(fontSize: 14,color: Colors.black),
                  underline: Container(height: 0),
                  onChanged: (String? newValue) {
                    setState(() {
                      widget.theloai = newValue!;
                    });
                  },
                  items: item.map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value!,
                          style: TextStyle(color: Colors.black),
                        ));
                  }).toList(),
                ),
        ],
      ),
    );
  }
}
