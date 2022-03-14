import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novelfull/controller/controllerChapter.dart';
import 'package:novelfull/controller/controllerNovel.dart';
import 'package:novelfull/screens/add_chapter.dart';
import 'package:novelfull/screens/edit_chapter.dart';
import 'package:novelfull/widgets/my_text_field.dart';

import '../controller/controllerComment.dart';
import '../controller/controllerLogin.dart';
import '../models/comment_model.dart';

class EditNewNovel extends StatefulWidget {
  var idnovel;
  var name;
  var urlImage;
  var tacgia;
  var theloai;
  var vanan;
  EditNewNovel(this.idnovel, this.name, this.urlImage, this.tacgia,
      this.theloai, this.vanan);

  @override
  _EditNewNovelState createState() => _EditNewNovelState();
}

class _EditNewNovelState extends State<EditNewNovel> {
  final controller = Get.put(LoginController());
  final novelController = Get.put(NovelController());

  String urlImg = "";
  String filename = "";
  String tochap = "";
  Uint8List? imagevalue;
  bool image = false;
  bool doitentruyen = false;
  final TextEditingController _tentruyenController = TextEditingController();
  final TextEditingController _tacgiaController = TextEditingController();
  final TextEditingController _vananController = TextEditingController();
  final TextEditingController _theloaiController = TextEditingController();
  final TextEditingController _waitController = TextEditingController();
 final TextEditingController _commentText = TextEditingController();
  List chapter = [];
  var _firestoreInstance = FirebaseFirestore.instance;

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
  @override
  void initState() {
    _tentruyenController.text = widget.name;
    _tacgiaController.text = widget.tacgia;
    _vananController.text = widget.vanan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     final commentController = Get.put(CommentController(widget.idnovel));
    RxList<CommentModel> mycomment = RxList<CommentModel>([]);
    final chapterController = Get.put(ChapterController(widget.idnovel));
    urlImg = widget.urlImage;
    return Scaffold(
      appBar: _appBar(context),
      body: ListView(
        shrinkWrap: true,
        children: [
          // hiển thị và pick lại ảnh
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  pickAndUploadFile();
                  image = !image;
                },
                child: image
                    ? Container(
                        height: 150,
                        width: 180,
                        child: imagevalue == null
                            ? Text('No Image')
                            : Image.network(urlImg))
                    : Container(
                        height: 150,
                        width: 180,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.urlImage),
                          ),
                        ),
                      ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(left: 40),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      readOnly: doitentruyen ? true : false,
                      controller: _tentruyenController,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      decoration: InputDecoration(
                          icon: GestureDetector(
                            onTap: () {
                              doitentruyen = !doitentruyen;
                            },
                            child: Icon(Icons.edit),
                          ),
                          hintText: widget.name,
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 16)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    margin: const EdgeInsets.only(left: 40),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    child: TextFormField(
                      controller: _tacgiaController,
                      style: TextStyle(color: Colors.black, fontSize: 13),
                      readOnly: doitentruyen ? true : false,
                      decoration: InputDecoration(
                          icon: GestureDetector(
                            onTap: () {
                              doitentruyen = !doitentruyen;
                            },
                            child: Icon(Icons.edit),
                          ),
                          hintText: widget.tacgia,
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 13)),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ],
          ),
          //dropdown thể loại
          MyInputField(
            maxline: 1,
            textArea: false,
            title: "Thể Loại",
            controller: _theloaiController,
            hint: widget.theloai,
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
                  widget.theloai = newValue!;
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
          // textfield văn án
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            height: 100,
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(20)),
            child: TextFormField(
              controller: _vananController,
              maxLines: null,
              style: TextStyle(color: Colors.black, fontSize: 13),
              readOnly: doitentruyen ? true : false,
              decoration: InputDecoration(
                  icon: GestureDetector(
                    onTap: () {
                      doitentruyen = !doitentruyen;
                    },
                    child: Icon(Icons.edit),
                  ),
                  hintText: widget.vanan,
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13)),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //banner chap và button thêm chap mới
          Container(
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 173, 200, 245),
                borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Chap",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      Get.to(() => AddChapter(widget.idnovel));
                    });
                  },
                  child: Row(
                    children: [
                      Text("Thêm chap mới",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
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
         // hiển thị tất cả các chương
          Expanded(
              child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("user-novels")
                .doc(widget.idnovel)
                .collection("chapter")
                .get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {

                return Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                      itemCount: chapterController.chapter.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 300,
                              margin: const EdgeInsets.only(
                                top: 10,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromARGB(255, 180, 179, 179),
                                      width: 0.1)),
                              height: 40,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "" + chapterController.chapter[index].tieude!,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              title: Text("Xác nhận"),
                                              content: Text(
                                                  "Bạn chắc chắn muốn xóa chap này?"),
                                              actions: [
                                                FlatButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        chapterController
                                                            .deleteChapter(
                                                                chapterController
                                                                    .chapter[
                                                                        index]
                                                                    .chapterid!);
                                                        Get.back();
                                                      });
                                                    },
                                                    child: Text("Đúng rồi")),
                                                FlatButton(
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    child: Text(
                                                        "Không phải đâu!")),
                                              ],
                                            ));
                                  },
                                  child: Container(
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.red),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Xóa"),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => EditChapter(
                                        widget.idnovel,
                                        chapterController
                                            .chapter[index].chapterid,
                                        chapterController.chapter[index].tieude,
                                        chapterController
                                            .chapter[index].noidung));
                                  },
                                  child: Container(
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.green),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text("Chi tiết"),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      }),
                );
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Text("No data");
              }
              return CircularProgressIndicator();
            },
          )),
          SizedBox(height: 10,),
        // banner bình luận
          Container(
          decoration: BoxDecoration(color: Color.fromARGB(255, 131, 192, 241), borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.only(left: 20, right: 30, top: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bình luận nổi bật",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Tổng số 2434 câu trả lời >",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ],
          ),
        ),
        // kiểm tra đăng nhập
        (controller.googleAccount.value == null)
            ? Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5), color: Colors.blue),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Cần đăng nhập để thực hiện bình luận",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            : Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          controller.googleAccount.value!.photoUrl.toString()),
                    ),
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: TextFormField(
                          controller: _commentText,
                          decoration: const InputDecoration(
                              hintText: "Viết bình luận..."),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _thongbao();
                          });
                        },
                        icon: Icon(Icons.send))
                  ],
                ),
              ),
        SizedBox(
          height: 10,
        ),
        // hiển thị danh sách bình luận của truyện
        FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("user-comment")
                .doc(widget.idnovel)
                .collection("comment")
                .get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: commentController.comment.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(commentController
                                  .comment[index].urlAvatar
                                  .toString()),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 15, right: 15),
                              width: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromARGB(255, 235, 233, 233)),
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10, top: 5),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        commentController.comment[index].user
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        commentController.comment[index].comment
                                            .toString(),
                                        style: TextStyle(fontSize: 12),
                                        maxLines: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            //cho phép xóa những bình luận của mình
                            (controller.googleAccount.value != null &&
                                    commentController.comment[index].emailuser!
                                            .toString() ==
                                        controller.googleAccount.value!.email
                                            .toString())
                                ? PopupMenuButton(
                                    icon: Icon(Icons.more_vert),
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          value: 'delete',
                                          child: Text('Xóa'),
                                        )
                                      ];
                                    },
                                    onSelected: (String value) =>
                                        actionPopUpItemSelected(
                                            value,
                                            commentController
                                                .comment[index].commentid
                                                .toString()),
                                  )
                                : Container()
                          ],
                        ),
                      );
                    },
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.none) {
                return Text("Không có bình luận nào cả");
              }
              return CircularProgressIndicator();
            }),
           SizedBox(
          height: 10,)
          
        ],
      ),
    );
  }
void actionPopUpItemSelected(String value, String name) {
    final commentController = Get.put(CommentController(widget.idnovel));
    String message;
    if (value == 'delete') {
      commentController.deleteComment(name);
    } else {
      message = 'Không được';
    }
    final snackBar = SnackBar(content: Text("OK"));
  }

  _thongbao() {
    final commentcontroller = Get.put(CommentController(widget.idnovel));
    if (_commentText.text.isNotEmpty) {
      commentcontroller.addComment(
          controller.googleAccount.value!.photoUrl.toString(),
          controller.googleAccount.value!.displayName.toString(),
          controller.googleAccount.value!.email.toString(),
          _commentText.text);
      
        _commentText.text = "";
      
    } else {
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
        widget.name,
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            setState(() {
              novelController.updateNovel(
                  widget.idnovel,
                  urlImg,
                  _tentruyenController.text,
                  _tacgiaController.text,
                  widget.theloai,
                  _vananController.text,
                  controller.googleAccount.value!.email);
            });
          },
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Lưu",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                )),
          ),
        )
      ],
    );
  }

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
