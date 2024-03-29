import 'package:flutter/material.dart';
import 'package:jsg_test/data/models/photo.dart';
import 'package:jsg_test/utils/services/api_service.dart';

class PhotosProvider with ChangeNotifier {
  int limit = 10;
  int page = 1;
  int totalPosts = 0;
  bool loading = false;
  List<Photo> photos = <Photo>[];
  ApiService apiServices = ApiService();

  Future<void> onPageChanged(int newPage) async {
    if (newPage != page) {
      page = newPage;
      getPhotos();

      notifyListeners();
    }
  }

  Future<void> onLimitChanged(int newLimit) async {
    if (newLimit != limit) {
      limit = newLimit;
      getPhotos();

      notifyListeners();
    }
  }

  getPhotos({bool isInitial = false}) async {
    loading = true;
    if (isInitial) {
      limit = 10;
      page = 1;
      totalPosts = await apiServices.getTotalPhotos();
    }
    photos = await apiServices.getPhotos(limit, page);
    loading = false;

    notifyListeners();
  }
}
