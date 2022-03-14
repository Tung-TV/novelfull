import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novelfull/controller/controllerFavorite.dart';
import 'package:novelfull/controller/controllerLogin.dart';
import 'package:novelfull/models/chapter_model.dart';
import 'package:novelfull/screens/detail_chapter.dart';
import 'package:novelfull/screens/detail_novel.dart';
import '../controller/controllerChapter.dart';
import '../models/favorite_model.dart';

class BottomNavDetailNovel extends StatefulWidget {
  var idnovel;
  var name;
  var urlImage;
  var tacgia;
  var theloai;
  var vanan;
  BottomNavDetailNovel(this.idnovel, this.name, this.urlImage, this.tacgia,
      this.theloai, this.vanan);

  @override
  _BottomNavDetailNovelState createState() => _BottomNavDetailNovelState();
}

class _BottomNavDetailNovelState extends State<BottomNavDetailNovel> {
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final chapterControler = Get.put(ChapterController(widget.idnovel));
    final controller = Get.put(LoginController());
    RxList<ChapterModel> chapter = RxList<ChapterModel>([]);
    // bind dữ liệu của chap đầu tiên của truyện
    chapter.bindStream(chapterControler.getChapterBynum("1"));
    return Scaffold(
        backgroundColor: Colors.white,
        body: DetailNovel(widget.idnovel, widget.name, widget.urlImage,
            widget.tacgia, widget.theloai, widget.vanan),
        bottomNavigationBar: Material(child: Obx(
          () {
            //dạng bottom-nav khi chưa đăng nhập
            if (controller.googleAccount.value == null)
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        setState(() {
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    title: Text(
                                        "Vui lòng đăng nhập để thực hiện chức năng này"),
                                  ));
                        });
                      },
                      icon: Icon(Icons.favorite_border, color: Colors.grey)),
                  (chapter.length==0)?Container(child: Text("Không có chap nào"),):InkWell(
                    onTap: () {
                      Get.to(() => DetailChapter(
                            1,
                            widget.idnovel,
                          
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color.fromARGB(255, 15, 95, 160)),
                      height: 53,
                      width: 200,
                      child: Center(
                        child: Text(
                          'Bắt Đầu Đọc',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            // dạng bottom-nav khi đã đăng nhập
            else {
              final favoriteController = Get.put(FavoriteController());
              RxList<FavoriteModel> favorites = RxList<FavoriteModel>([]);
              favorites
                  .bindStream(favoriteController.getFavorite(widget.idnovel));
              return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("user-favorite")
                      .doc(controller.googleAccount.value!.email)
                      .collection("favorite")
                      .where('novelid', isEqualTo: widget.idnovel)
                      .get(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //thêm vào danh sách truyện yêu thích của user
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  if (favorites.length == 0)
                                    favoriteController.addFavorite(
                                        widget.idnovel,
                                        widget.urlImage,
                                        widget.name,
                                        widget.tacgia,
                                        widget.theloai,
                                        widget.vanan);
                                  else if (favorites[0].favorite == "1") {
                                    favoriteController.deleteFavorite(
                                        favorites[0].favoriteid.toString());
                                  }
                                });
                              },
                              icon: Icon(
                                  (favorites.length == 0)
                                      ? Icons.favorite_border
                                      : Icons.favorite,
                                  color: (favorites.length == 0)
                                      ? Colors.grey
                                      : Colors.red)),
                            // kiểm tra số chương của truyện, nếu không có chương nào sẽ hiện thông báo,
                            // ngược lại sẽ chuyển đến chương đâu tiên của truyện
                            (chapter.length==0)?Container(child: Text("Không có chap nào!"),): InkWell(
                            onTap: () {
                              Get.to(() => DetailChapter(
                                    1,
                                    widget.idnovel,
                
                                  ));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color.fromARGB(255, 15, 95, 160)),
                              height: 53,
                              width: 200,
                              child: Center(
                                child: Text(
                                  'Bắt Đầu Đọc',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.none) {
                      return Text("No data");
                    }
                    return CircularProgressIndicator();
                  });
            }
          },
        )));
  }
}
