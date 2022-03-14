import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:novelfull/widgets/my_text_field.dart';

import '../controller/controllerChapter.dart';
import '../controller/controllerLogin.dart';

class EditChapter extends StatefulWidget {
  var novelid;
  var chapterid;
  var tieude;
  var noidung;
  EditChapter(this.novelid, this.chapterid, this.tieude, this.noidung);

  @override
  _EditChapterState createState() => _EditChapterState();
}

class _EditChapterState extends State<EditChapter> {
  bool _isVisible = true;
  final controller = Get.put(LoginController());
  final TextEditingController _tenchuongController = TextEditingController();
  final TextEditingController _noidungController = TextEditingController();

  @override
  void initState() {
    _tenchuongController.text = widget.tieude;
    _noidungController.text = widget.noidung;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text("Tên chương",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          ),
          SizedBox(
            height: 3,
          ),
          // text field tên chương
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              maxLines: 1,
              controller: _tenchuongController,
              autofocus: false,
              cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 14),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Align(
                alignment: Alignment.topLeft,
                child: Text("Nội dung",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
          ),
          SizedBox(
            height: 5,
          ),
          //text field nội dung
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 9999999,
              controller: _noidungController,
              autofocus: false,
              cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey,
              style: TextStyle(fontSize: 14),
              decoration: InputDecoration(
                  hintText: "Nhập nội dung",
                  hintStyle: TextStyle(fontSize: 14),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: context.theme.backgroundColor, width: 0)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: context.theme.backgroundColor, width: 0))),
            ),
          )),
          SizedBox(
            height: 10,
          ),
          // lưu chương
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                _thongbaochuong();
              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Lưu",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  //kiểm tra các trường và update chương
  _thongbaochuong() {
    final chapterControler = Get.put(ChapterController(widget.novelid));
    if (_tenchuongController.text.isNotEmpty &&
        _noidungController.text.isNotEmpty) {
      chapterControler.updateChapter(
          widget.chapterid, _tenchuongController.text, _noidungController.text);
     
    } else if (_tenchuongController.text.isEmpty ||
        _noidungController.text.isEmpty) {
      Get.snackbar("Lỗi", "Vui lòng điền đầy đủ thông tin",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.black,
          icon: Icon(Icons.warning_amber_rounded));
    }
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
      title: Text(
        "Thêm Chap",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
