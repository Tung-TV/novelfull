import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novelfull/screens/chapter.dart';
import 'package:novelfull/screens/chitiet.dart';
import 'package:novelfull/screens/home.dart';
import 'package:novelfull/screens/searchtheloai.dart';

class DetailNovel extends StatefulWidget {
  var idnovel;
  var name;
  var urlImage;
  var tacgia;
  var theloai;
  var vanan;
  DetailNovel(this.idnovel, this.name, this.urlImage, this.tacgia, this.theloai,
      this.vanan);

  @override
  _DetailNovelState createState() => _DetailNovelState();
}

class _DetailNovelState extends State<DetailNovel>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //hiển thị hình ảnh truyện
                Container(
                  height: 180,
                  width: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.urlImage),
                    ),
                  ),
                ),
                // hiển thị thông tin tên, tác giả, thể loại
                Container(
                  width: 230,
                  margin: const EdgeInsets.only(right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        maxLines: 4,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("Tác giả: " + widget.tacgia,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal)),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text("Thể Loại: ",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.normal)),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                Get.to(SearchTheLoai(widget.theloai));
                              });
                            },
                            child: Text(widget.theloai,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // tabbar cho phép chọn giữa thông tin truyện và danh sách chương
            Container(
                child: Align(
              alignment: Alignment.center,
              child: TabBar(
                  labelPadding: const EdgeInsets.only(left: 20, right: 20),
                  controller: _tabController,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      color: Colors.white),
                  tabs: [
                    Tab(
                      child: Container(
                        width: 150,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Chi tiết"),
                        ),
                      ),
                    ),
                    Tab(
                      child: Container(
                        width: 150,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text("Chapter"),
                        ),
                      ),
                    ),
                  ]),
            )),
            Container(
              padding: const EdgeInsets.only(left: 20),
              height: 550,
              width: double.maxFinite,
              child: TabBarView(controller: _tabController, children: [
                ChiTiet(widget.idnovel, widget.name, widget.vanan),
                Chapters(widget.idnovel),
              ]),
            )
          ],
        ),
      ),
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
      title:Text(widget.name,style: TextStyle(color: Colors.black),),
      actions: [],
    );
  }
}
