import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/comment_model.dart';
import '../widgets/dialog.dart';
import '../widgets/snapbar.dart';
import 'controllerLogin.dart';

class CommentController extends GetxController {
  var novelid;
  CommentController(this.novelid);
  final controller = Get.put(LoginController());
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<CommentModel> comment = RxList<CommentModel>([]);

  @override
  void onInit() {
    super.onInit();
    collectionReference = firebaseFirestore
        .collection("user-comment")
        .doc(novelid)
        .collection("comment");
    comment.bindStream(getAllComment());
  }

  Stream<List<CommentModel>> getAllComment() =>
      collectionReference.orderBy('date', descending: true).snapshots().map((query) =>
          query.docs.map((item) => CommentModel.fromMap(item)).toList());

  getCommentByUser(String emailuser) => collectionReference
      .where('emailuser', isEqualTo: emailuser)
      .snapshots()
      .map((query) =>
          query.docs.map((item) => CommentModel.fromMap(item)).toList());

  void addComment(
      String urlAvatar, String user, String emailuser, String comment) {
    CustomFullScreenDialog.showDialog();
    collectionReference.add({
      'urlAvatar': urlAvatar,
      'user': user,
      'emailuser': emailuser,
      'comment': comment,
      'date': DateTime.now().toString(),
    }).whenComplete(() {
      CustomFullScreenDialog.cancelDialog();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Thông Báo",
          message: "Thêm thành công",
          backgroundColor: Colors.green);
    }).catchError((error) {
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Lỗi",
          message: "Thêm không thành công",
          backgroundColor: Colors.red);
    });
    
  }

  void updateComment(String commentid, String urlAvatar, String user,
      String emailuser, String comment) {
    CustomFullScreenDialog.showDialog();
    collectionReference
        .doc(commentid)
        .update({
          'urlAvatar': urlAvatar,
          'user': user,
          'emailuser': emailuser,
          'comment': comment,
        })
        .whenComplete(() {})
        .catchError((error) {
          CustomSnackBar.showSnackBar(
              context: Get.context,
              title: "Lỗi",
              message: "Sửa không thành công",
              backgroundColor: Colors.red);
        });
  }

  void deleteComment(String docId) {
    collectionReference.doc(docId).delete().whenComplete(() {
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Thông báo",
          message: "Xóa thành công",
          backgroundColor: Colors.green);
    }).catchError((error) {
      CustomFullScreenDialog.cancelDialog();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Error",
          message: "Something went wrong",
          backgroundColor: Colors.red);
    });
  }
}
