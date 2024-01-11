import 'package:flutter/material.dart';
import 'package:jsg_test/data/models/post.dart';
import 'package:jsg_test/utils/services/api_service.dart';

class HomeProvider with ChangeNotifier {
  List<Post> filteredPosts = [];
  List<Post> totalPosts = [];
  bool loading = false;
  ApiService apiServices = ApiService();
  String searchInput = '';

  onSearchInputChanged(String input) {
    filteredPosts = totalPosts
        .where((e) => e.user.name.toLowerCase().contains(input.toLowerCase()))
        .toList();

    notifyListeners();
  }

  getPosts() async {
    loading = true;
    totalPosts = await apiServices.getPosts();
    filteredPosts = totalPosts;
    loading = false;

    notifyListeners();
  }
}
