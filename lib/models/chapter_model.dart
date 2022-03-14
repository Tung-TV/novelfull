import 'package:cloud_firestore/cloud_firestore.dart';

class ChapterModel {
  String? chapterid;
  String? tieude;
  String? noidung;
  ChapterModel({ this.tieude, this.noidung});
  ChapterModel.fromMap(DocumentSnapshot data) {
    chapterid = data.id;
    tieude = data["tieude"];
    noidung = data["noidung"];
  }
}
