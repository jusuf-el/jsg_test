import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:jsg_test/data/constants/endpoints.dart';
import 'package:jsg_test/data/models/comment.dart';
import 'package:jsg_test/data/models/photo.dart';
import 'package:jsg_test/data/models/post.dart';
import 'package:jsg_test/data/models/user.dart';

class ApiService {
  Future<List<Post>> getPosts() async {
    List<User> users = await getUsers();
    List<Comment> comments = await getComments();

    List<Post> mappedPosts = [];
    try {
      final response =
          await http.get(Uri.parse(Endpoints.baseUrl + Endpoints.posts));
      if (response.statusCode == 200) {
        final List<dynamic> posts = json.decode(response.body);
        mappedPosts = posts.map((e) {
          Map<String, dynamic> data = e;
          data.addAll({
            'user': users.firstWhere((element) => element.id == e['userId']),
            'comments':
                comments.where((element) => element.postId == e['id']).toList(),
          });
          return Post.fromJson(data);
        }).toList();
      } else {
        // TODO - DISPLAYING ERROR MESSAGE
        if (kDebugMode) {
          print('GET POSTS ERROR WITH CODE: ${response.statusCode}');
        }
      }
    } catch (e) {
      // TODO - DISPLAYING ERROR MESSAGE
      if (kDebugMode) {
        print('GET POSTS ERROR: $e');
        rethrow;
      }
    }

    return mappedPosts;
  }

  Future<List<User>> getUsers() async {
    List<User> mappedUsers = [];
    try {
      final response =
          await http.get(Uri.parse(Endpoints.baseUrl + Endpoints.users));
      if (response.statusCode == 200) {
        final List<dynamic> users = json.decode(response.body);
        mappedUsers = users.map((e) => User.fromJson(e)).toList();
      } else {
        // TODO - DISPLAYING ERROR MESSAGE
        if (kDebugMode) {
          print('GET USERS ERROR WITH CODE: ${response.statusCode}');
        }
      }
    } catch (e) {
      // TODO - DISPLAYING ERROR MESSAGE
      if (kDebugMode) {
        print('GET USERS ERROR WITH CODE: $e');
      }
    }

    return mappedUsers;
  }

  Future<List<Comment>> getComments() async {
    List<Comment> mappedComments = [];
    try {
      final response =
          await http.get(Uri.parse(Endpoints.baseUrl + Endpoints.comments));
      if (response.statusCode == 200) {
        final List<dynamic> comments = json.decode(response.body);
        mappedComments = comments.map((e) => Comment.fromJson(e)).toList();
      } else {
        // TODO - DISPLAYING ERROR MESSAGE
        if (kDebugMode) {
          print('GET USERS ERROR WITH CODE: ${response.statusCode}');
        }
      }
    } catch (e) {
      // TODO - DISPLAYING ERROR MESSAGE
      if (kDebugMode) {
        print('GET USERS ERROR WITH CODE: $e');
      }
    }

    return mappedComments;
  }

  Future<List<Photo>> getPhotos(int? limit, int? page) async {
    List<Photo> mappedPhotos = [];

    List<Map<String, dynamic>> urlParameters = [
      {'key': '_limit', 'value': limit},
      {'key': '_page', 'value': page},
    ];

    try {
      final response = await http.get(Uri.parse(Endpoints.baseUrl +
          Endpoints.photos +
          Endpoints.setUrlParameters(urlParameters)));
      if (response.statusCode == 200) {
        final List<dynamic> photos = json.decode(response.body);
        mappedPhotos = photos.map((e) => Photo.fromJson(e)).toList();
      } else {
        // TODO - DISPLAYING ERROR MESSAGE
        if (kDebugMode) {
          print('GET PHOTOS ERROR WITH CODE: ${response.statusCode}');
        }
      }
    } catch (e) {
      // TODO - DISPLAYING ERROR MESSAGE
      if (kDebugMode) {
        print('GET PHOTOS ERROR: $e');
        rethrow;
      }
    }

    return mappedPhotos;
  }

  Future<int> getTotalPhotos() async {
    int totalPhotos = 0;

    try {
      final response =
          await http.get(Uri.parse(Endpoints.baseUrl + Endpoints.photos));
      if (response.statusCode == 200) {
        final List<dynamic> photos = json.decode(response.body);
        totalPhotos = photos.length;
      } else {
        // TODO - DISPLAYING ERROR MESSAGE
        if (kDebugMode) {
          print('GET TOTAL PHOTOS ERROR WITH CODE: ${response.statusCode}');
        }
      }
    } catch (e) {
      // TODO - DISPLAYING ERROR MESSAGE
      if (kDebugMode) {
        print('GET TOTAL PHOTOS ERROR: $e');
        rethrow;
      }
    }

    return totalPhotos;
  }
}
