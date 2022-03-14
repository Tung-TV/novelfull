import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/controllerFavorite.dart';
import '../controller/controllerLogin.dart';
import '../widgets/app_button.dart';
import 'bottom_nav_detail_novel.dart';
import 'home.dart';

class TuSach extends StatefulWidget {
  const TuSach({Key? key}) : super(key: key);

  @override
  _TuSachState createState() => _TuSachState();
}

class _TuSachState extends State<TuSach> with TickerProviderStateMixin {
  final controller = Get.put(LoginController());
  bool edit = false;
  bool tap = false;
  bool selectall = false;
  @override
  Widget build(BuildContext context) {
    //kiểm tra đăng nhập nếu chưa đăng nhập thì không hiện danh sách yêu thích
    return (controller.googleAccount.value == null)
        ? Center(
            child: Text("Đăng nhập"),
          )
        : Scaffold(
            appBar: _appBar(context),
            //show bottom-nav khi chọn sửa để xóa 1 hoặc nhiều truyện yêu thích
            bottomNavigationBar: edit
                ? BottomAppBar(
                    child: Obx(() {
                      final favoriteController = Get.put(FavoriteController());
                      return FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection("user-favorite")
                              .doc(controller.googleAccount.value!.email)
                              .collection("favorite")
                              .get(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            return Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectall = !selectall;
                                      favoriteController.favorite.forEach(
                                        (element) {
                                          element.selected = !element.selected;
                                        },
                                      );
                                    });
                                  },
                                  child: Row(children: [
                                    Icon(Icons.check_circle_outline),
                                    selectall
                                        ? Text("Hủy tất cả")
                                        : Text("Chọn tất cả"),
                                  ]),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      favoriteController.favorite.forEach(
                                        (element) {
                                          if (element.selected == true) {
                                            favoriteController.deleteFavorite(
                                                element.favoriteid.toString());
                                          }
                                        },
                                      );
                                    });
                                  },
                                  child: Row(children: [
                                    Icon(Icons.delete),
                                    Text("Xóa"),
                                  ]),
                                ),
                              ],
                            ));
                          });
                    }),
                  )
                : null,
            body: Container(
              child: Obx(() {
                final favoriteController = Get.put(FavoriteController());
                //show truyện yêu thích
                return FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("user-favorite")
                        .doc(controller.googleAccount.value!.email)
                        .collection("favorite")
                        .get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          itemCount: favoriteController.favorite.length,
                          itemBuilder: (BuildContext context, index) {
                            return Container(
                              child: (edit == false)
                                  ? Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                                height: 120,
                                                width: 80,
                                                child: Image.network(
                                                    favoriteController
                                                        .favorite[index]
                                                        .urlImage
                                                        .toString())),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(favoriteController
                                                    .favorite[index].name
                                                    .toString()),
                                                Text(favoriteController
                                                    .favorite[index].tacgia
                                                    .toString()),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(
                                                    () => BottomNavDetailNovel(
                                                          favoriteController
                                                              .favorite[index]
                                                              .novelid,
                                                          favoriteController
                                                              .favorite[index]
                                                              .name,
                                                          favoriteController
                                                              .favorite[index]
                                                              .urlImage,
                                                          favoriteController
                                                              .favorite[index]
                                                              .tacgia,
                                                          favoriteController
                                                              .favorite[index]
                                                              .theloai,
                                                          favoriteController
                                                              .favorite[index]
                                                              .vanan,
                                                        ));
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    left: 20),
                                                width: 100,
                                                height: 50,
                                                child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text("Đọc >")),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: Colors.orangeAccent,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            SizedBox(
                                              height: 10,
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    favoriteController
                                                            .favorite[index]
                                                            .selected =
                                                        !favoriteController
                                                            .favorite[index]
                                                            .selected;
                                                    log(favoriteController
                                                        .favorite[index]
                                                        .selected
                                                        .toString());
                                                  });
                                                },
                                                child: Icon(
                                                  (favoriteController
                                                              .favorite[index]
                                                              .selected ==
                                                          false)
                                                      ? Icons.circle_outlined
                                                      : Icons.check_circle,
                                                  color: (favoriteController
                                                              .favorite[index]
                                                              .selected ==
                                                          false)
                                                      ? Colors.grey
                                                      : Colors.red,
                                                )),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                height: 150,
                                                width: 100,
                                                child: Image.network(
                                                  favoriteController
                                                      .favorite[index].urlImage
                                                      .toString(),
                                                )),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  favoriteController
                                                      .favorite[index].name
                                                      .toString(),
                                                ),
                                                Text(
                                                  favoriteController
                                                      .favorite[index].tacgia
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                            );
                          },
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.none) {
                        return Text("No data");
                      }
                      return CircularProgressIndicator();
                    });
              }),
            ));
  }

  _appBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      actions: [
        GestureDetector(
          onTap: () {
            setState(() {
              edit = !edit;
            });
          },
          child: Container(
            margin: const EdgeInsets.all(15),
            child: edit
                ? Text(
                    "Hủy",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )
                : Text(
                    "Sửa",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
          ),
        )
      ],
      title: Text(
        "Tủ Sách",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
