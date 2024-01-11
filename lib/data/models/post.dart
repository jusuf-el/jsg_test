import 'package:jsg_test/data/models/comment.dart';
import 'package:jsg_test/data/models/user.dart';

class Post {
  int? userId;
  int? id;
  String title = '';
  String body = '';
  User user = User();
  List<Comment> comments = <Comment>[];

  Post({this.userId, this.id, this.title = '', this.body = '', user, comments})
      : user = user ?? User(),
        comments = comments ?? [];

  Post.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'] ?? '';
    body = json['body'] ?? '';
    user = json['user'] ?? User();
    comments = json['comments'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['user'] = user;
    data['comments'] = comments;
    return data;
  }
}
