import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:novelfull/screens/searchtentruyen.dart';
import 'package:novelfull/screens/searchtheloai.dart';

import '../controller/controllerHome.dart';
import 'bottom_nav_detail_novel.dart';

class PhanLoai extends StatefulWidget {
  const PhanLoai({Key? key}) : super(key: key);

  @override
  _PhanLoaiState createState() => _PhanLoaiState();
}

class _PhanLoaiState extends State<PhanLoai> {
  final allNovelController = Get.put(AllNovelController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(context),
        body: FutureBuilder(
            future: FirebaseFirestore.instance.collection("user-novels").get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(children: [
                  // hiển thị list thể loại
                  ExpansionTile(title: Text("Thể Loại"), children: <Widget>[
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Get.to(() => SearchTheLoai("Đô Thị"));
                                });
                              },
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Đô Thị")),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Get.to(() => SearchTheLoai("Huyền Ảo"));
                                });
                              },
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Huyền Ảo")),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => SearchTheLoai("Kinh Dị"));
                              },
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Kinh Dị")),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => SearchTheLoai("Hài Hước"));
                              },
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Hài Hước")),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => SearchTheLoai("Vườn Trường"));
                              },
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Học Đường")),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => SearchTheLoai("Tu Tiên"));
                              },
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Tu Tiên")),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => SearchTheLoai("Đam Mỹ"));
                              },
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Đam Mỹ")),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => SearchTheLoai("Ngôn Tình"));
                              },
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 80,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: Colors.lightBlue,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Align(
                                        alignment: Alignment.center,
                                        child: Text("Ngôn Tình")),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ]),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Chủ Đề HOT!!!!',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // hiển thị banner thể loại
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => SearchTheLoai("Đam Mỹ"));
                            },
                            child: Container(
                              width: 150,
                              height: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("image/dammy.png"))),
                            ),
                          ),
                          GestureDetector(
                             onTap: () {
                              Get.to(() => SearchTheLoai("Ngôn Tình"));
                            },
                            child: Container(
                              width: 150,
                              height: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("image/ngontinh.jpg"))),
                            ),
                          ),
                          GestureDetector(
                             onTap: () {
                              Get.to(() => SearchTheLoai("Tu Tiên"));
                            },
                            child: Container(
                              width: 150,
                              height: 80,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("image/tutien.jpg"))),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Truyện HOT',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => BottomNavDetailNovel(
                                    allNovelController.novels[0].novelid,
                                    allNovelController.novels[0].name,
                                    allNovelController.novels[0].urlImage,
                                    allNovelController.novels[0].tacgia,
                                    allNovelController.novels[0].theloai,
                                    allNovelController.novels[0].vanan));
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(allNovelController
                                              .novels[0].urlImage
                                              .toString()),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 100,
                                    height: 70,
                                    child: Text(
                                      allNovelController.novels[0].name
                                          .toString(),
                                      maxLines: 3,
                                    )),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => BottomNavDetailNovel(
                                    allNovelController.novels[1].novelid,
                                    allNovelController.novels[1].name,
                                    allNovelController.novels[1].urlImage,
                                    allNovelController.novels[1].tacgia,
                                    allNovelController.novels[1].theloai,
                                    allNovelController.novels[1].vanan));
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(allNovelController
                                              .novels[1].urlImage
                                              .toString()),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 100,
                                    height: 70,
                                    child: Text(
                                      allNovelController.novels[1].name
                                          .toString(),
                                      maxLines: 3,
                                    )),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => BottomNavDetailNovel(
                                    allNovelController.novels[2].novelid,
                                    allNovelController.novels[2].name,
                                    allNovelController.novels[2].urlImage,
                                    allNovelController.novels[2].tacgia,
                                    allNovelController.novels[2].theloai,
                                    allNovelController.novels[2].vanan));
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(allNovelController
                                              .novels[2].urlImage
                                              .toString()),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 100,
                                    height: 70,
                                    child: Text(
                                      allNovelController.novels[2].name
                                          .toString(),
                                      maxLines: 3,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => BottomNavDetailNovel(
                                    allNovelController.novels[3].novelid,
                                    allNovelController.novels[3].name,
                                    allNovelController.novels[3].urlImage,
                                    allNovelController.novels[3].tacgia,
                                    allNovelController.novels[3].theloai,
                                    allNovelController.novels[3].vanan));
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(allNovelController
                                              .novels[3].urlImage
                                              .toString()),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 100,
                                    height: 70,
                                    child: Text(
                                      allNovelController.novels[3].name
                                          .toString(),
                                      maxLines: 3,
                                    )),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => BottomNavDetailNovel(
                                    allNovelController.novels[4].novelid,
                                    allNovelController.novels[4].name,
                                    allNovelController.novels[4].urlImage,
                                    allNovelController.novels[4].tacgia,
                                    allNovelController.novels[4].theloai,
                                    allNovelController.novels[4].vanan));
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(allNovelController
                                              .novels[4].urlImage
                                              .toString()),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 100,
                                    height: 70,
                                    child: Text(
                                      allNovelController.novels[4].name
                                          .toString(),
                                      maxLines: 3,
                                    )),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => BottomNavDetailNovel(
                                    allNovelController.novels[5].novelid,
                                    allNovelController.novels[5].name,
                                    allNovelController.novels[5].urlImage,
                                    allNovelController.novels[5].tacgia,
                                    allNovelController.novels[5].theloai,
                                    allNovelController.novels[5].vanan));
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(allNovelController
                                              .novels[5].urlImage
                                              .toString()),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 100,
                                    height: 70,
                                    child: Text(
                                      allNovelController.novels[5].name
                                          .toString(),
                                      maxLines: 3,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Truyện Đề Cử',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => BottomNavDetailNovel(
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                1]
                                        .novelid,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                1]
                                        .name,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                1]
                                        .urlImage,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                1]
                                        .tacgia,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                1]
                                        .theloai,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                1]
                                        .vanan));
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(allNovelController
                                              .novels[allNovelController
                                                      .novels.length -
                                                  1]
                                              .urlImage
                                              .toString()),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 100,
                                    height: 70,
                                    child: Text(
                                      allNovelController
                                          .novels[
                                              allNovelController.novels.length -
                                                  1]
                                          .name
                                          .toString(),
                                      maxLines: 3,
                                    )),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => BottomNavDetailNovel(
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                2]
                                        .novelid,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                2]
                                        .name,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                2]
                                        .urlImage,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                2]
                                        .tacgia,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                2]
                                        .theloai,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                2]
                                        .vanan));
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(allNovelController
                                              .novels[allNovelController
                                                      .novels.length -
                                                  2]
                                              .urlImage
                                              .toString()),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 100,
                                    height: 70,
                                    child: Text(
                                      allNovelController
                                          .novels[
                                              allNovelController.novels.length -
                                                  2]
                                          .name
                                          .toString(),
                                      maxLines: 3,
                                    )),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => BottomNavDetailNovel(
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                3]
                                        .novelid,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                3]
                                        .name,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                3]
                                        .urlImage,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                3]
                                        .tacgia,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                3]
                                        .theloai,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                3]
                                        .vanan));
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(allNovelController
                                              .novels[allNovelController
                                                      .novels.length -
                                                  3]
                                              .urlImage
                                              .toString()),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 100,
                                    height: 70,
                                    child: Text(
                                      allNovelController
                                          .novels[
                                              allNovelController.novels.length -
                                                  3]
                                          .name
                                          .toString(),
                                      maxLines: 3,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => BottomNavDetailNovel(
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                4]
                                        .novelid,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                4]
                                        .name,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                4]
                                        .urlImage,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                4]
                                        .tacgia,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                4]
                                        .theloai,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                4]
                                        .vanan));
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(allNovelController
                                              .novels[allNovelController
                                                      .novels.length -
                                                  4]
                                              .urlImage
                                              .toString()),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 100,
                                    height: 70,
                                    child: Text(
                                      allNovelController
                                          .novels[
                                              allNovelController.novels.length -
                                                  4]
                                          .name
                                          .toString(),
                                      maxLines: 3,
                                    )),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => BottomNavDetailNovel(
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                5]
                                        .novelid,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                5]
                                        .name,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                5]
                                        .urlImage,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                5]
                                        .tacgia,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                5]
                                        .theloai,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                5]
                                        .vanan));
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(allNovelController
                                              .novels[allNovelController
                                                      .novels.length -
                                                  5]
                                              .urlImage
                                              .toString()),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 100,
                                    height: 70,
                                    child: Text(
                                      allNovelController
                                          .novels[
                                              allNovelController.novels.length -
                                                  5]
                                          .name
                                          .toString(),
                                      maxLines: 3,
                                    )),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => BottomNavDetailNovel(
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                6]
                                        .novelid,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                6]
                                        .name,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                6]
                                        .urlImage,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                6]
                                        .tacgia,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                6]
                                        .theloai,
                                    allNovelController
                                        .novels[
                                            allNovelController.novels.length -
                                                6]
                                        .vanan));
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 150,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(allNovelController
                                              .novels[allNovelController
                                                      .novels.length -
                                                  1]
                                              .urlImage
                                              .toString()),
                                          fit: BoxFit.cover)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                    width: 100,
                                    height: 70,
                                    child: Text(
                                      allNovelController
                                          .novels[
                                              allNovelController.novels.length -
                                                  1]
                                          .name
                                          .toString(),
                                      maxLines: 3,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ]);
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Text("No data");
              }
              return CircularProgressIndicator();
            }));
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        'Phân Loại',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            Get.to(() => SearchNovel());
          },
          child: Icon(Icons.search, size: 20, color: Colors.grey),
        ),
      ],
    );
  }
}
