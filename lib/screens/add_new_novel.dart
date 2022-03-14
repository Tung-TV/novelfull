import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novelfull/controller/controllerNovel.dart';
import 'package:novelfull/widgets/loading_dialog.dart';
import 'package:novelfull/widgets/my_text_field.dart';
import '../controller/controllerLogin.dart';

class AddNewNovel extends StatefulWidget {
  var user;
  AddNewNovel(this.user);

  @override
  _AddNewNovelState createState() => _AddNewNovelState();
}

class _AddNewNovelState extends State<AddNewNovel> {
  final controller = Get.put(LoginController());
  final novelControler = Get.put(NovelController());
  final TextEditingController _tentruyenController = TextEditingController();
  final TextEditingController _tacgiaController = TextEditingController();
  final TextEditingController _vananController = TextEditingController();
  final TextEditingController _theloaiController = TextEditingController();
  final TextEditingController _waitController = TextEditingController();
  String _chontheloai = "Đam Mỹ";
  List<String> theloai = [
    "Đam Mỹ",
    "Ngôn Tình",
    "Hài Hước",
    "Đô Thị",
    "Vườn Trường",
    "Kinh Dị",
    "Huyền Ảo",
    "Tu Tiên"
  ];
  Uint8List? imagevalue;
  bool image = false;

  String urlImg = "";
  String filename = "";
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Column(
            children: [
              //chọn ảnh && show ảnh đã chọn
              image
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          pickAndUploadFile();
                        });
                      },
                      child: Container(
                          height: 300,
                          child: imagevalue == null
                              ? Text('No Image')
                              : Image.memory(imagevalue!)),
                    )
                  : IconButton(
                      onPressed: () {
                        pickAndUploadFile();
                        image = !image;
                      },
                      icon: Icon(
                        Icons.add_a_photo_outlined,
                        size: 50,
                      )),
              // input tên truyện
              MyInputField(
                title: "Tên truyện",
                hint: "Nhập tên truyện",
                controller: _tentruyenController,
                maxline: 1,
                textArea: false,
              ),
              SizedBox(
                height: 10,
              ),
              //input tên tác giả
              MyInputField(
                title: "Tác giả",
                hint: "Nhập tác giả",
                controller: _tacgiaController,
                textArea: false,
                maxline: 1,
              ),
              SizedBox(
                height: 10,
              ),
              //dropdown thể loại
              MyInputField(
                maxline: 1,
                textArea: false,
                title: "Thể Loại",
                controller: _theloaiController,
                hint: "$_chontheloai",
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: TextStyle(fontSize: 14),
                  underline: Container(height: 0),
                  onChanged: (String? newValue) {
                    setState(() {
                      _chontheloai = newValue!;
                    });
                  },
                  items: theloai.map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value!,
                          style: TextStyle(color: Colors.grey),
                        ));
                  }).toList(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              //input mô tả/ tóm tắt
              MyInputField(
                title: "Mô tả/Văn án",
                hint: "Nhập mô tả",
                controller: _vananController,
                textArea: true,
                maxline: 20,
              ),
              SizedBox(
                height: 15,
              ),
              // nút lưu
              GestureDetector(
                onTap: () {
                  setState(() {
                       _thongbao();     
                  });
               
                },
                child: Container(
                  margin: const EdgeInsets.only(left: 50, right: 50),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Xác Nhận",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
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
      title: Text(
        "Thêm Truyện",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
//kiểm tra tất cả các trường nhập vào và lưu
  _thongbao() {
    if (_vananController.text.isNotEmpty &&
        _tacgiaController.text.isNotEmpty &&
        _tentruyenController.text.isNotEmpty &&
        urlImg != "") {
      novelControler.addNovel(urlImg, _tentruyenController.text,
          _tacgiaController.text, _chontheloai, _vananController.text,controller.googleAccount.value!.email);
    } else if (urlImg == "") {
      LoadingDialog(
        message: "Ảnh chưa được upload",
      );
    } else if (_tentruyenController.text.isEmpty ||
        _tacgiaController.text.isEmpty ||
        _vananController.text.isEmpty) {
      Get.snackbar("Vui lòng điền thông tin", "Vui lòng điền đầy đủ thông tin",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: Colors.black,
          icon: Icon(Icons.warning_amber_rounded));
    }
  }
//lấy ảnh từ thư mục rồi up lên firestore đồng thời lấy url của ảnh về
  Future<String?> pickAndUploadFile() async {
    final ref =
        FirebaseStorage.instance.refFromURL('gs://novelfull-ef949.appspot.com');
    String? res;
    final filePickerRes = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['png', 'jpg', 'svg', 'jpeg']);
    if (filePickerRes != null) {
      if (filePickerRes.count == 1) {
        final file = filePickerRes.files.single;

        setState(() {
          imagevalue = file.bytes;
        });
        if (file.size > 3000000) {
          throw Exception('File must be less than 3000KB');
        }
        final UploadTask upTask =
            ref.child('uploads/${file.name}').putData(file.bytes!);
        final snapshot = await upTask.snapshot;
        res = await (await snapshot.ref.getDownloadURL()).toString();
        urlImg = await res.toString();
      } else {
        throw Exception('only one file allowed');
      }
    }
    return res;
  }
}
