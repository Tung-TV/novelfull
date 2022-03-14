import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:novelfull/controller/controllerHome.dart';
import 'package:novelfull/screens/bottom_nav_detail_novel.dart';
import 'package:novelfull/screens/detail_novel.dart';
import 'package:novelfull/screens/truyenmoi.dart';

import '../controller/controllerNovel.dart';

class DeXuat extends StatefulWidget {
  const DeXuat({Key? key}) : super(key: key);

  @override
  _DeXuatState createState() => _DeXuatState();
}

class _DeXuatState extends State<DeXuat> {
  final allNovelController = Get.put(AllNovelController());
  var _dotPosition = 0;
  List image = [
    "bluekiss.jpg",
    "requytroicho.jpg",
    "TDDT.jpg",
    "hacamchisac.jpg",
    "LDHT.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection("user-novels").get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              shrinkWrap: true,
              children: [
            //slider image đầu trang
            CarouselSlider(
              items: [              
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage("image/"+image[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                  
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image:AssetImage("image/"+image[1]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                  
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage("image/"+image[2]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage("image/"+image[3]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: AssetImage("image/"+image[4]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
  
          ],
              
              options: CarouselOptions(
                height: 180.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
          ),
            //show 6 truyện theo thứ tự từ cũ -> mới
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
                                  allNovelController.novels[0].name.toString(),
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
                                  allNovelController.novels[1].name.toString(),
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
                                  allNovelController.novels[2].name.toString(),
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
                                  allNovelController.novels[3].name.toString(),
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
                                  allNovelController.novels[4].name.toString(),
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
                                  allNovelController.novels[5].name.toString(),
                                  maxLines: 3,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            // show 6 truyện từ mới -> cũ
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
                                        allNovelController.novels.length - 1]
                                    .novelid,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 1]
                                    .name,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 1]
                                    .urlImage,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 1]
                                    .tacgia,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 1]
                                    .theloai,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 1]
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
                                          .novels[
                                              allNovelController.novels.length -
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
                                          allNovelController.novels.length - 1]
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
                                        allNovelController.novels.length - 2]
                                    .novelid,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 2]
                                    .name,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 2]
                                    .urlImage,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 2]
                                    .tacgia,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 2]
                                    .theloai,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 2]
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
                                          .novels[
                                              allNovelController.novels.length -
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
                                          allNovelController.novels.length - 2]
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
                                        allNovelController.novels.length - 3]
                                    .novelid,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 3]
                                    .name,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 3]
                                    .urlImage,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 3]
                                    .tacgia,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 3]
                                    .theloai,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 3]
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
                                          .novels[
                                              allNovelController.novels.length -
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
                                          allNovelController.novels.length - 3]
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
                                        allNovelController.novels.length - 4]
                                    .novelid,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 4]
                                    .name,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 4]
                                    .urlImage,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 4]
                                    .tacgia,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 4]
                                    .theloai,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 4]
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
                                          .novels[
                                              allNovelController.novels.length -
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
                                          allNovelController.novels.length - 4]
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
                                        allNovelController.novels.length - 5]
                                    .novelid,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 5]
                                    .name,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 5]
                                    .urlImage,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 5]
                                    .tacgia,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 5]
                                    .theloai,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 5]
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
                                          .novels[
                                              allNovelController.novels.length -
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
                                          allNovelController.novels.length - 5]
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
                                        allNovelController.novels.length - 6]
                                    .novelid,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 6]
                                    .name,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 6]
                                    .urlImage,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 6]
                                    .tacgia,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 6]
                                    .theloai,
                                allNovelController
                                    .novels[
                                        allNovelController.novels.length - 6]
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
                                          .novels[
                                              allNovelController.novels.length -
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
                                          allNovelController.novels.length - 1]
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
            // show danh sách truyện đam mỹ mới
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Truyện Đam Mỹ',
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Get.to(() => BottomNavDetailNovel(
                            allNovelController
                                .dammynovels[
                                    allNovelController.dammynovels.length - 1]
                                .novelid,
                            allNovelController
                                .dammynovels[
                                    allNovelController.dammynovels.length - 1]
                                .name,
                            allNovelController
                                .dammynovels[
                                    allNovelController.dammynovels.length - 1]
                                .urlImage,
                            allNovelController
                                .dammynovels[
                                    allNovelController.dammynovels.length - 1]
                                .tacgia,
                            allNovelController
                                .dammynovels[
                                    allNovelController.dammynovels.length - 1]
                                .theloai,
                            allNovelController
                                .dammynovels[
                                    allNovelController.dammynovels.length - 1]
                                .vanan));
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: 10, right: 30, left: 20, bottom: 10),
                          height: 160,
                          width: 120,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(allNovelController
                                      .dammynovels[allNovelController
                                              .dammynovels.length -
                                          1]
                                      .urlImage
                                      .toString()),
                                  fit: BoxFit.cover)),
                        ),
                        SafeArea(
                          child: Column(
                            children: [
                              Container(
                                width: 300,
                                child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      allNovelController
                                          .dammynovels[allNovelController
                                                  .dammynovels.length -
                                              1]
                                          .name
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    )),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 300,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                      allNovelController
                                          .dammynovels[allNovelController
                                                  .dammynovels.length -
                                              1]
                                          .tacgia
                                          .toString(),
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.left),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => BottomNavDetailNovel(
                                    allNovelController
                                        .dammynovels[allNovelController
                                                .dammynovels.length -
                                            2]
                                        .novelid,
                                    allNovelController
                                        .dammynovels[allNovelController
                                                .dammynovels.length -
                                            2]
                                        .name,
                                    allNovelController
                                        .dammynovels[allNovelController
                                                .dammynovels.length -
                                            2]
                                        .urlImage,
                                    allNovelController
                                        .dammynovels[
                                            allNovelController.dammynovels.length -
                                                2]
                                        .tacgia,
                                    allNovelController
                                        .dammynovels[
                                            allNovelController.dammynovels.length -
                                                2]
                                        .theloai,
                                    allNovelController
                                        .dammynovels[allNovelController.dammynovels.length - 2]
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
                                              .dammynovels[allNovelController
                                                      .dammynovels.length -
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
                                            .dammynovels[allNovelController
                                                    .dammynovels.length -
                                                2]
                                            .name
                                            .toString(),
                                        maxLines: 3)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => BottomNavDetailNovel(
                                    allNovelController
                                        .dammynovels[allNovelController
                                                .dammynovels.length -
                                            3]
                                        .novelid,
                                    allNovelController
                                        .dammynovels[allNovelController
                                                .dammynovels.length -
                                            3]
                                        .name,
                                    allNovelController
                                        .dammynovels[allNovelController
                                                .dammynovels.length -
                                            3]
                                        .urlImage,
                                    allNovelController
                                        .dammynovels[
                                            allNovelController.dammynovels.length -
                                                3]
                                        .tacgia,
                                    allNovelController
                                        .dammynovels[
                                            allNovelController.dammynovels.length -
                                                3]
                                        .theloai,
                                    allNovelController
                                        .dammynovels[allNovelController.dammynovels.length - 3]
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
                                              .dammynovels[allNovelController
                                                      .dammynovels.length -
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
                                            .dammynovels[allNovelController
                                                    .dammynovels.length -
                                                3]
                                            .name
                                            .toString(),
                                        maxLines: 3)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => BottomNavDetailNovel(
                                    allNovelController
                                        .dammynovels[allNovelController
                                                .dammynovels.length -
                                            4]
                                        .novelid,
                                    allNovelController
                                        .dammynovels[allNovelController
                                                .dammynovels.length -
                                            4]
                                        .name,
                                    allNovelController
                                        .dammynovels[allNovelController
                                                .dammynovels.length -
                                            4]
                                        .urlImage,
                                    allNovelController
                                        .dammynovels[
                                            allNovelController.dammynovels.length -
                                                4]
                                        .tacgia,
                                    allNovelController
                                        .dammynovels[
                                            allNovelController.dammynovels.length -
                                                4]
                                        .theloai,
                                    allNovelController
                                        .dammynovels[allNovelController.dammynovels.length - 4]
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
                                              .dammynovels[allNovelController
                                                      .dammynovels.length -
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
                                            .dammynovels[allNovelController
                                                    .dammynovels.length -
                                                4]
                                            .name
                                            .toString(),
                                        maxLines: 3)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(() => BottomNavDetailNovel(
                                    allNovelController
                                        .dammynovels[allNovelController
                                                .dammynovels.length -
                                            5]
                                        .novelid,
                                    allNovelController
                                        .dammynovels[allNovelController
                                                .dammynovels.length -
                                            5]
                                        .name,
                                    allNovelController
                                        .dammynovels[allNovelController
                                                .dammynovels.length -
                                            5]
                                        .urlImage,
                                    allNovelController
                                        .dammynovels[
                                            allNovelController.dammynovels.length -
                                                5]
                                        .tacgia,
                                    allNovelController
                                        .dammynovels[
                                            allNovelController.dammynovels.length -
                                                5]
                                        .theloai,
                                    allNovelController
                                        .dammynovels[allNovelController.dammynovels.length - 5]
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
                                              .dammynovels[allNovelController
                                                      .dammynovels.length -
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
                                            .dammynovels[allNovelController
                                                    .dammynovels.length -
                                                5]
                                            .name
                                            .toString(),
                                        maxLines: 3)),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
             // show danh sách truyện tu tiên mới
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Truyện Tu Tiên',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Get.to(()=>BottomNavDetailNovel(
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -1].novelid,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -1].name,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -1].urlImage,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -1].tacgia,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -1].theloai,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -1].vanan,));
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
                                          .tutiennovels[allNovelController
                                                  .tutiennovels.length -
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
                                        .tutiennovels[allNovelController
                                                .tutiennovels.length -
                                            1]
                                        .name
                                        .toString(),
                                    maxLines: 3)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Get.to(()=>BottomNavDetailNovel(
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -2].novelid,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -2].name,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -2].urlImage,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -2].tacgia,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -2].theloai,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -2].vanan,));
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
                                          .tutiennovels[allNovelController
                                                  .tutiennovels.length -
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
                                        .tutiennovels[allNovelController
                                                .tutiennovels.length -
                                            2]
                                        .name
                                        .toString(),
                                    maxLines: 3)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Get.to(()=>BottomNavDetailNovel(
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -3].novelid,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -3].name,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -3].urlImage,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -3].tacgia,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -3].theloai,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -3].vanan,));
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
                                          .tutiennovels[allNovelController
                                                  .tutiennovels.length -
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
                                        .tutiennovels[allNovelController
                                                .tutiennovels.length -
                                            3]
                                        .name
                                        .toString(),
                                    maxLines: 3)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Get.to(()=>BottomNavDetailNovel(
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -4].novelid,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -4].name,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -4].urlImage,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -4].tacgia,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -4].theloai,
                              allNovelController.tutiennovels[allNovelController.tutiennovels.length -4].vanan,));
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
                                          .tutiennovels[allNovelController
                                                  .tutiennovels.length -
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
                                        .tutiennovels[allNovelController
                                                .tutiennovels.length -
                                            4]
                                        .name
                                        .toString(),
                                    maxLines: 3)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ]);
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Text("No data");
          }
          return CircularProgressIndicator();
        });
  }
}
