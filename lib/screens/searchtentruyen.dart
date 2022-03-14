import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novelfull/controller/controllerHome.dart';

import '../models/novel_model.dart';
import 'bottom_nav_detail_novel.dart';

class SearchNovel extends StatefulWidget {
  const SearchNovel({Key? key}) : super(key: key);

  @override
  State<SearchNovel> createState() => _SearchNovelState();
}

class _SearchNovelState extends State<SearchNovel> {
  var tentruyen = "";
  
  @override
  Widget build(BuildContext context) {
    final allNovelController = Get.put(AllNovelController());
    RxList<NovelModel> novel = RxList<NovelModel>([]);
    novel.bindStream(allNovelController.getNovelByName(tentruyen));
    return Scaffold(
      appBar: _appBar(context),
      //hiển thị danh sách truyện có chứa ký tự trên thanh tìm kiếm
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection("user-novels")
              .where('name', isGreaterThanOrEqualTo: tentruyen)
              .where('name', isLessThan: tentruyen + 'z')
              .get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: novel.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(novel[index].urlImage.toString()),
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
                                    novel[index].name.toString(),
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
                                          novel[index].tacgia.toString(),
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
                                  child: Text(novel[index].vanan.toString(),
                                      maxLines: 3,
                                      style: TextStyle(fontSize: 11),
                                      overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => BottomNavDetailNovel(novel[index].novelid.toString(),novel[index].name,novel[index].urlImage,novel[index].tacgia,novel[index].theloai,novel[index].vanan));
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
      title: TextField(
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.search), hintText: 'Tìm theo tên truyện...'),
        onChanged: (val) {
          setState(() {
            tentruyen = val;
          });
        },
      ),
    );
  }
}
