import 'package:flutter/material.dart';
import 'package:jsg_test/data/constants/color_constants.dart';
import 'package:jsg_test/data/widgets/jsguru_app_bar.dart';
import 'package:jsg_test/modules/photos/provider/photos_provider.dart';
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
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Provider.of<PhotosProvider>(context, listen: false)
        .getPhotos(isInitial: true);
    scrollController.addListener(() {
      if (scrollController.position.pixels.isNegative &&
          photosProvider.loadPreviousHeight < 50.0) {
        photosProvider.onLoadPreviousHeightChanged(
            scrollController.position.pixels.abs());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    photosProvider = Provider.of<PhotosProvider>(context);
    return Scaffold(
      appBar: JSGuruAppBar(
        automaticallyImplyLeading: true,
        actions: [
          DropdownButton(
            value: photosProvider.limit,
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white),
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            iconEnabledColor: Colors.white70,
            dropdownColor: ColorConstants.appBarBackground.withOpacity(0.75),
            alignment: Alignment.center,
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
            items: List.generate(
              limits.length,
              (index) {
                return DropdownMenuItem(
                  value: limits[index],
                  child: Text(
                    limits[index].toString(),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
            onChanged: (value) {
              if (value != null) {
                photosProvider.onLimitChanged(value);
              }
            },
          ),
        ],
      ),
      body: photosProvider.loading
          ? const Center(
              child: CircularProgressIndicator(
                color: ColorConstants.appBarBackground,
              ),
            )
          : Column(
              children: [
                Container(
                  height: photosProvider.loadPreviousHeight,
                  color: Colors.black,
                  width: double.infinity,
                  // child: const Center(
                  //   child: CircularProgressIndicator(
                  //     color: ColorConstants.appBarBackground,
                  //   ),
                  // ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: List.generate(
                        photosProvider.photos.length,
                        (index) {
                          return Container(
                            margin: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 150.0,
                                  height: 150.0,
                                  child: Image.network(
                                    photosProvider.photos[index].thumbnailUrl,
                                    width: 150.0,
                                    height: 150.0,
                                    loadingBuilder: (context, widget, event) {
                                      if (event?.expectedTotalBytes !=
                                          event?.cumulativeBytesLoaded) {
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color:
                                                ColorConstants.appBarBackground,
                                          ),
                                        );
                                      } else {
                                        return widget;
                                      }
                                    },
                                  ),
                                ),
                                const SizedBox(width: 15.0),
                                Expanded(
                                  child: Text(
                                    photosProvider.photos[index].title,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
      // RefreshLoadmore(
      //         onRefresh: photosProvider.page == 1
      //             ? null
      //             : () => photosProvider.onPageChanged(photosProvider.page - 1),
      //         onLoadmore: () =>
      //             photosProvider.onPageChanged(photosProvider.page + 1),
      //         noMoreWidget: Text(
      //           'No more data, you are at the end',
      //           style: TextStyle(
      //             fontSize: 18,
      //             color: Theme.of(context).disabledColor,
      //           ),
      //         ),
      //         isLastPage: photosProvider.page * photosProvider.limit >=
      //             photosProvider.totalPosts,
      //         child: Padding(
      //           padding: const EdgeInsets.all(15.0),
      //           child: Column(
      //             children: List.generate(
      //               photosProvider.photos.length,
      //               (index) {
      //                 return Container(
      //                   margin: const EdgeInsets.only(bottom: 10.0),
      //                   child: Row(
      //                     children: [
      //                       SizedBox(
      //                         width: 150.0,
      //                         height: 150.0,
      //                         child: Image.network(
      //                           photosProvider.photos[index].thumbnailUrl,
      //                           width: 150.0,
      //                           height: 150.0,
      //                           loadingBuilder: (context, widget, event) {
      //                             if (event?.expectedTotalBytes !=
      //                                 event?.cumulativeBytesLoaded) {
      //                               return const Center(
      //                                 child: CircularProgressIndicator(
      //                                   color: ColorConstants.appBarBackground,
      //                                 ),
      //                               );
      //                             } else {
      //                               return widget;
      //                             }
      //                           },
      //                         ),
      //                       ),
      //                       const SizedBox(width: 15.0),
      //                       Expanded(
      //                         child: Text(
      //                           photosProvider.photos[index].title,
      //                           style: Theme.of(context).textTheme.titleLarge,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 );
      //               },
      //             ),
      //           ),
      //         ),
      //       ),
    );
  }
}
