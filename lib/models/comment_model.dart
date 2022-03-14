import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? commentid;
  String? urlAvatar;
  String? user;
  String? emailuser;
  String? comment;
  String? date;
  CommentModel(
      {this.commentid,
      this.urlAvatar,
      this.user,
      this.emailuser,
      this.comment,
      this.date});
  CommentModel.fromMap(DocumentSnapshot data) {
    commentid = data.id;
    urlAvatar = data["urlAvatar"];
    user = data["user"];
    emailuser = data["emailuser"];
    comment = data["comment"];
    date = data["date"];
  }
}
