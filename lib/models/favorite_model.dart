import 'package:cloud_firestore/cloud_firestore.dart';

class FavoriteModel {
  String? favoriteid;
  String? novelid;
  String? favorite;
  String? urlImage;
  String? name;
  String? tacgia;
  String? theloai;
  String? vanan;
  bool selected = false;
  FavoriteModel(
      {this.novelid,
      this.favorite,
      this.urlImage,
      this.name,
      this.tacgia,
      this.theloai,
      this.vanan});
  FavoriteModel.fromMap(DocumentSnapshot data) {
    favoriteid = data.id;
    novelid = data["novelid"];
    favorite = data["favorite"];
    urlImage = data["urlImage"];
    name = data["name"];
    tacgia = data["tacgia"];
    theloai = data["theloai"];
    vanan = data["vanan"];
  }
}
