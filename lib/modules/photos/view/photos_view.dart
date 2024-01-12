import 'package:flutter/material.dart';
import 'package:jsg_test/data/constants/color_constants.dart';
import 'package:jsg_test/data/widgets/jsguru_app_bar.dart';
import 'package:jsg_test/data/widgets/jsguru_dropdown_button.dart';
import 'package:jsg_test/modules/photos/provider/photos_provider.dart';
import 'package:jsg_test/modules/photos/widgets/photo_tile.dart';
import 'package:provider/provider.dart';
import 'package:refresh_loadmore/refresh_loadmore.dart';

class PhotosView extends StatefulWidget {
  const PhotosView({super.key});

  @override
  State<PhotosView> createState() => _PhotosViewState();
}

class _PhotosViewState extends State<PhotosView> {
  static const List<int> limits = [10, 20, 50, 100];
  late PhotosProvider photosProvider;

  @override
  void initState() {
    super.initState();
    Provider.of<PhotosProvider>(context, listen: false)
        .getPhotos(isInitial: true);
  }

  @override
  Widget build(BuildContext context) {
    photosProvider = Provider.of<PhotosProvider>(context);
    return Scaffold(
      appBar: JSGuruAppBar(
        automaticallyImplyLeading: true,
        actions: [
          JSGuruDropdownButton(
            dropdownValue: photosProvider.limit,
            items: limits,
            onChanged: (value) => photosProvider.onLimitChanged(value),
          ),
        ],
      ),
      body: photosProvider.loading
          ? const Center(
              child: CircularProgressIndicator(
                color: ColorConstants.appBarBackground,
              ),
            )
          : RefreshLoadmore(
              onRefresh: photosProvider.page == 1
                  ? null
                  : () => photosProvider.onPageChanged(photosProvider.page - 1),
              onLoadmore: () =>
                  photosProvider.onPageChanged(photosProvider.page + 1),
              noMoreWidget: Text(
                'No more data, you are at the end',
                style: TextStyle(
                    fontSize: 18, color: Theme.of(context).disabledColor),
              ),
              isLastPage: photosProvider.page * photosProvider.limit >=
                  photosProvider.totalPosts,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: List.generate(
                    photosProvider.photos.length,
                    (index) {
                      return PhotoTile(
                        isLast: index == photosProvider.photos.length - 1,
                        photo: photosProvider.photos[index],
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
