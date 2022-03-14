import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:novelfull/models/novel_model.dart';

class AllNovelController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;
  RxList<NovelModel> listnovel = RxList<NovelModel>([]);
  RxList<NovelModel> novels = RxList<NovelModel>([]);
  RxList<NovelModel> dammynovels = RxList<NovelModel>([]);
  RxList<NovelModel> tutiennovels = RxList<NovelModel>([]);
  @override
  void onInit() {
    super.onInit();
    collectionReference = firebaseFirestore.collection("user-novels");
    novels.bindStream(getAllNovels());
    dammynovels.bindStream(getAllDamMyNovels());
    tutiennovels.bindStream(getAllTuTienNovels());
  }

  getDetailNovels(String idnovel) =>
      collectionReference.doc(idnovel).snapshots().map((item) => null);

  getTheloaiNovels(String theloai) => collectionReference
      .where('theloai', isEqualTo: theloai)
      .snapshots()
      .map((query) =>
          query.docs.map((item) => NovelModel.fromMap(item)).toList());

  getNovelByName(String name) => collectionReference
      .where('name', isGreaterThanOrEqualTo: name)
      .where("name", isLessThanOrEqualTo: name + "\uf7ff")
      .snapshots()
      .map((query) =>
          query.docs.map((item) => NovelModel.fromMap(item)).toList());

  Stream<List<NovelModel>> getAllNovels() =>
      collectionReference.snapshots().map((query) =>
          query.docs.map((item) => NovelModel.fromMap(item)).toList());

  Stream<List<NovelModel>> getAllDamMyNovels() => collectionReference
      .where('theloai', isEqualTo: 'Đam Mỹ')
      .snapshots()
      .map((query) =>
          query.docs.map((item) => NovelModel.fromMap(item)).toList());

  Stream<List<NovelModel>> getAllTuTienNovels() => collectionReference
      .where('theloai', isEqualTo: 'Tu Tiên')
      .snapshots()
      .map((query) =>
          query.docs.map((item) => NovelModel.fromMap(item)).toList());
}
