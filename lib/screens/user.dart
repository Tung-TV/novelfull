import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:novelfull/controller/controllerNovel.dart';
import 'package:novelfull/models/novel_model.dart';
import 'package:novelfull/screens/add_new_novel.dart';
import 'package:novelfull/screens/edit_new_novel.dart';
import '../controller/controllerLogin.dart';

class User extends StatefulWidget {
  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  final controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tôi",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(child: Obx(
        () {
          if (controller.googleAccount.value == null)
            return buildLoginButon();
          else
            return profileview();
        },
      )),
    );
  }

  Column profileview() {
    final novelController = Get.put(NovelController());
    return Column(children: [
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundImage:
                Image.network(controller.googleAccount.value?.photoUrl ?? '')
                    .image,
            radius: 50,
          ),
          Column(
            children: [
              Text(
                controller.googleAccount.value?.displayName ?? '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                controller.googleAccount.value?.email ?? '',
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          ActionChip(
              label: Text("Đăng Xuất"),
              onPressed: () {
                controller.logout();
              })
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 173, 200, 245),
            borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.only(left: 30, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Sáng tác",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () {
                setState(() {
                  Get.to(
                      () => AddNewNovel(controller.googleAccount.value != ''));
                });
              },
              child: Row(
                children: [
                  Text("Thêm Mới",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Icon(
                    Icons.add_circle_outline,
                    color: Colors.red,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Expanded(
        child: FutureBuilder(
          future: FirebaseFirestore.instance.collection("user-novels").get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Obx(
                () => ListView.builder(
                  itemCount: novelController.usernovels.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => AlertDialog(
                                            title: Text("Xác nhận"),
                                            content: Text("Muốn xóa truyện ${novelController.novels[index].name} chứ?"),
                                            actions: [
                                              FlatButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      novelController
                                                          .deleteData(
                                                              novelController
                                                                  .usernovels[
                                                                      index]
                                                                  .novelid!);
                                                      Get.back();
                                                    });
                                                  },
                                                  child: Text("Yes")),
                                              FlatButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text("No")),
                                            ],
                                          ));
                                },
                                child: Container(
                                  height: 120,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(novelController
                                            .usernovels[index].urlImage!)),
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                
                                child: Column(
                                  children: [
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          novelController
                                              .usernovels[index].name!,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            novelController
                                                .usernovels[index].tacgia!,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight:
                                                    FontWeight.normal))),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                            novelController
                                                .usernovels[index].theloai!,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight:
                                                    FontWeight.normal))),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Get.to(() => EditNewNovel(
                                          novelController
                                              .usernovels[index].novelid,
                                          novelController
                                              .usernovels[index].name,
                                          novelController
                                              .usernovels[index].urlImage,
                                          novelController
                                              .usernovels[index].tacgia,
                                          novelController
                                              .usernovels[index].theloai,
                                          novelController
                                              .usernovels[index].vanan,
                                        ));
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 243, 115, 76),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Chi Tiết")),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Text("No data");
            }
            return CircularProgressIndicator();
          },
        ),
      )
    ]);
  }

  FloatingActionButton buildLoginButon() {
    return FloatingActionButton.extended(
      onPressed: () {
        controller.login();
      },
      icon: Image.asset(
        "image/google.png",
        height: 32,
        width: 32,
      ),
      label: Text("Đăng nhập với Google"),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
  }
}
