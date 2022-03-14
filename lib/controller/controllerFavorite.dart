import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/favorite_model.dart';
import '../widgets/dialog.dart';
import '../widgets/snapbar.dart';
import 'controllerLogin.dart';

class FavoriteController extends GetxController {

  final controller = Get.put(LoginController());
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  RxList<FavoriteModel> favorite = RxList<FavoriteModel>([]);

  @override
  void onInit() {
    super.onInit();
    collectionReference = firebaseFirestore
        .collection("user-favorite")
        .doc(controller.googleAccount.value!.email)
        .collection("favorite");
    favorite.bindStream(getAllFavorite());
  }

  Stream<List<FavoriteModel>> getAllFavorite() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => FavoriteModel.fromMap(item)).toList());

  getFavorite(String novelid) => collectionReference
      .where('novelid', isEqualTo: novelid)
      .snapshots()
      .map((query) =>
          query.docs.map((item) => FavoriteModel.fromMap(item)).toList());

  void addFavorite(String novelid, String urlImage, String name, String tacgia, String theloai, String vanan) {
    CustomFullScreenDialog.showDialog();
    collectionReference
        .add({
          'novelid': novelid,
          'urlImage': urlImage,
          'name':name,
          'tacgia':tacgia,
          'theloai':theloai,
          'vanan': vanan,
          'favorite': "1",
        })
        .whenComplete(() { CustomFullScreenDialog.cancelDialog();})
        .catchError((error) {
          CustomSnackBar.showSnackBar(
              context: Get.context,
              title: "Lỗi",
              message: "Thêm không thành công",
              backgroundColor: Colors.red);
        });
  }

  void deleteFavorite(String docId) {
    CustomFullScreenDialog.showDialog();
    collectionReference
        .doc(docId)
        .delete()
        .whenComplete(() {CustomFullScreenDialog.cancelDialog();})
        .catchError((error) {
      CustomFullScreenDialog.cancelDialog();
      CustomSnackBar.showSnackBar(
          context: Get.context,
          title: "Error",
          message: "Something went wrong",
          backgroundColor: Colors.red);
    });
  }
}
