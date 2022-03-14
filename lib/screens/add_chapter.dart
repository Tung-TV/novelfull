import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:novelfull/controller/controllerChapter.dart';
import 'package:novelfull/widgets/my_text_field.dart';

import '../controller/controllerLogin.dart';

class AddChapter extends StatefulWidget {
  var novelid;
  AddChapter(this.novelid);

  @override
  _AddChapterState createState() => _AddChapterState();
}

class _AddChapterState extends State<AddChapter> {
  final controller = Get.put(LoginController());
  final TextEditingController _tenchuongController = TextEditingController();
  final TextEditingController _noidungController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          //input tenchuong
          MyInputField(
              title: "Tên chương",
              hint: "Nhập tên chương",
              controller: _tenchuongController,
              maxline: 1,
              textArea: false),
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
           // input noidung
          Expanded(
              child: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                borderRadius: BorderRadius.circular(12)),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 9999999,
              controller: _noidungController,
              autofocus: false,
              cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey,
              style: TextStyle(fontSize: 14),
              decoration:InputDecoration(
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
          //luu
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
// xacnhan
  _thongbaochuong() {
    final chapterControler = Get.put(ChapterController(widget.novelid));
    if (_tenchuongController.text.isNotEmpty &&
        _noidungController.text.isNotEmpty) {
      chapterControler.addChapter("Chương "+ "${chapterControler.chapter.length+1}: "+ _tenchuongController.text, _noidungController.text);
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
