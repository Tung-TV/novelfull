import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:novelfull/controller/controllerLogin.dart';
import 'package:novelfull/models/novel_model.dart';
import 'package:novelfull/widgets/snapbar.dart';

import '../widgets/dialog.dart';

class NovelController extends GetxController {
  final controller = Get.put(LoginController());
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<NovelModel> novels = RxList<NovelModel>([]);
  RxList<NovelModel> usernovels = RxList<NovelModel>([]);

  @override
  void onInit() {
    super.onInit();
    collectionReference = firebaseFirestore.collection("user-novels");
    novels.bindStream(getAllNovels());
    usernovels.bindStream(getAllUserNovels());
  }

  Stream<List<NovelModel>> getAllNovels() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => NovelModel.fromMap(item)).toList());

  Stream<List<NovelModel>> getAllUserNovels() => collectionReference
      .where('uploader', isEqualTo: controller.googleAccount.value!.email)
      .snapshots()
      .map((query) =>
          query.docs.map((item) => NovelModel.fromMap(item)).toList());

 
  void addNovel( String urlImage, String name, String tacgia, String theloai,
      String vanan, String uploader) {
    CustomFullScreenDialog.showDialog();
    collectionReference.add({
      'name': name,
      'urlImage': urlImage,
      'tacgia': tacgia,
      'theloai': theloai,
      'vanan': vanan,
      'uploader': uploader,
    }).whenComplete(() {
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

  void updateNovel(String id, String urlImage, String name, String tacgia,
      String theloai, String vanan, String uploader) {
    CustomFullScreenDialog.showDialog();
    collectionReference.doc(id).update({
      'name': name,
      'urlImage': urlImage,
      'tacgia': tacgia,
      'theloai': theloai,
      'vanan': vanan,
      'uploader': uploader
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

  void deleteData(String docId) {
    CustomFullScreenDialog.showDialog();
    collectionReference.doc(docId).delete().whenComplete(() {
      CustomFullScreenDialog.cancelDialog();
      Get.back();
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
