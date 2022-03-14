import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novelfull/controller/controllerComment.dart';
import 'package:novelfull/models/comment_model.dart';
import 'package:novelfull/widgets/my_text_field.dart';
import 'package:readmore/readmore.dart';

import '../controller/controllerLogin.dart';

class ChiTiet extends StatefulWidget {
  var idnovel;
  var name;
  var vanan;
  ChiTiet(this.idnovel, this.name, this.vanan);

  @override
  _ChiTietState createState() => _ChiTietState();
}

class _ChiTietState extends State<ChiTiet> {
  final controller = Get.put(LoginController());
  final TextEditingController _commentText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final commentController = Get.put(CommentController(widget.idnovel));
    RxList<CommentModel> mycomment = RxList<CommentModel>([]);
    return ListView(
      children: [
        //banner số sao, độ hot của truyện
        Container(
          height: 80,
          width: 900,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color.fromARGB(255, 235, 235, 235),
          ),
          margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
          child: Center(
            child: Container(
              height: 50,
              width: 700,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "4.9",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 18,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "Đánh giá",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Icon(Icons.edit, color: Colors.grey, size: 15),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(children: [
                          Text(
                            "2,72M",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                        Row(
                          children: [
                            Text(
                              "Độ hot",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(children: [
                          Text(
                            "38,0K",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                        Row(
                          children: [
                            Text(
                              "Số like",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        Row(children: [
                          Text(
                            "8,24K",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                        Row(
                          children: [
                            Text(
                              "Lượt theo dõi",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),       
        Container(
          height: 5,
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 219, 219, 219)),
        ),
        // mô tả của truyện
        Container(
          margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
          child: ReadMoreText(
            widget.vanan,
            style: TextStyle(color: Colors.black),
            trimLines: 2,
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Length,
            trimCollapsedText: "Chi tiết",
            trimExpandedText: " Thu gọn",
            moreStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
            lessStyle: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 5,
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 219, 219, 219)),
        ),
        //banner bình luận
        Container(
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
        // kiểm tra đăng nhập nếu chưa thì không cho phép bình luận
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
        // hiển thị các bình luận
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
                            //kiểm tra xem đúng bình luận của người đó không, nếu đúng thì hiện menu button cho phép xóa
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
      ],
    );
  }
// list item của menu button bình luận
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
// kiểm tra các trường và cho phép thêm bình luận
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
}
