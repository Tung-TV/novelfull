import 'package:cloud_firestore/cloud_firestore.dart';

class NovelModel {
  String? novelid;
  String? urlImage;
  String? name;
  String? tacgia;
  String? theloai;
  String? vanan;
  String? uploader;
  NovelModel({
    this.urlImage,
    this.name,
    this.tacgia,
    this.theloai,
    this.vanan,
    this.uploader,
  });
  NovelModel.fromMap(DocumentSnapshot data) {
    novelid = data.id;
    urlImage = data["urlImage"];
    name = data["name"];
    tacgia = data["tacgia"];
    theloai = data["theloai"];
    vanan = data["vanan"];
    uploader = data["uploader"];
  }
}
