import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/chapter_model.dart';
import '../widgets/dialog.dart';
import '../widgets/snapbar.dart';
import 'controllerLogin.dart';

class ChapterController extends GetxController {
  var novelid;
  ChapterController(this.novelid);
  final controller = Get.put(LoginController());
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<ChapterModel> chapter = RxList<ChapterModel>([]);

  @override
  void onInit() {
    super.onInit();
    collectionReference = firebaseFirestore
        .collection("user-novels")
        .doc(novelid)
        .collection("chapter");
    chapter.bindStream(getAllChapter());
  }

  Stream<List<ChapterModel>> getAllChapter() => collectionReference
      .orderBy('tieude', descending: false)
      .snapshots()
      .map((query) =>
          query.docs.map((item) => ChapterModel.fromMap(item)).toList());

  getChapterBynum(String num) => collectionReference
      .where('tieude', isGreaterThanOrEqualTo: ("Chương " + "${num}"))
      .where("tieude", isLessThanOrEqualTo: ("Chương " + "${num}") + "\uf7ff")
      .snapshots()
      .map((query) =>
          query.docs.map((item) => ChapterModel.fromMap(item)).toList());

  void addChapter(String tieude, String noidung) {
    CustomFullScreenDialog.showDialog();
    collectionReference.add({
      'tieude': tieude,
      'noidung': noidung,
    }).whenComplete(() {
      CustomFullScreenDialog.cancelDialog();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Thông Báo",
          message: "Thêm thành công",
          backgroundColor: Colors.green);

      Get.back();
    }).catchError((error) {
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Lỗi",
          message: "Thêm không thành công",
          backgroundColor: Colors.red);
    });
    Get.back();
  }

  void updateChapter(String idchapter, String tieude, String noidung) {
    CustomFullScreenDialog.showDialog();
    collectionReference.doc(idchapter).update({
      'tieude': tieude,
      'noidung': noidung,
    }).whenComplete(() {
      Get.back();
    }).catchError((error) {
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Lỗi",
          message: "Sửa không thành công",
          backgroundColor: Colors.red);
    });
    Get.back();
  }

  void deleteChapter(String docId) {
    CustomFullScreenDialog.showDialog();
    collectionReference.doc(docId).delete().whenComplete(() {
      CustomFullScreenDialog.cancelDialog();
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
