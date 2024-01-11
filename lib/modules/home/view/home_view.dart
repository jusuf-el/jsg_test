import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jsg_test/data/constants/asset_constants.dart';
import 'package:jsg_test/data/constants/color_constants.dart';
import 'package:jsg_test/data/widgets/jsguru_app_bar.dart';
import 'package:jsg_test/modules/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> homeKey = GlobalKey();
  late HomeProvider homeProvider;
  final TextEditingController textEditingController = TextEditingController();

  openEndDrawer() {}

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).getPosts();
    textEditingController.addListener(() {
      homeProvider.onSearchInputChanged(textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      key: homeKey,
      body: homeProvider.loading
          ? const Center(
              child: CircularProgressIndicator(
                color: ColorConstants.appBarBackground,
              ),
            )
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Search posts by author name',
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(15.0),
                    itemBuilder: (context, index) {
                      return ExpandablePanel(
                        collapsed: const SizedBox(),
                        header: InkWell(
                          onTap: () {
                            context.goNamed(
                              'post_details',
                              extra: homeProvider.filteredPosts[index],
                            );
                            textEditingController.text = '';
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                color: ColorConstants.appBarBackground
                                    .withOpacity(0.5),
                                width: 1.0,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  homeProvider.filteredPosts[index].title,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'by ',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      homeProvider
                                          .filteredPosts[index].user.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5.0),
                                Divider(
                                  height: 0.5,
                                  thickness: 0.5,
                                  color: Theme.of(context).dividerColor,
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  homeProvider.filteredPosts[index].body,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ),
                        expanded: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Comments (${homeProvider.filteredPosts[index].comments.length})',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              ListView.separated(
                                padding: const EdgeInsets.only(top: 5.0),
                                shrinkWrap: true,
                                separatorBuilder: (context, commentIndex) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Theme.of(context).dividerColor,
                                          width: 0.5,
                                        ),
                                      ),
                                    ),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 1.5),
                                  );
                                },
                                itemCount: homeProvider
                                    .filteredPosts[index].comments.length,
                                itemBuilder: (context, commentIndex) {
                                  return Text(
                                    homeProvider.filteredPosts[index]
                                        .comments[commentIndex].body,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        theme: const ExpandableThemeData(
                          iconColor: ColorConstants.appBarBackground,
                          headerAlignment:
                              ExpandablePanelHeaderAlignment.bottom,
                          iconPadding: EdgeInsets.zero,
                          iconSize: 30.0,
                          tapHeaderToExpand: false,
                          hasIcon: true,
                          useInkWell: true,
                          tapBodyToCollapse: false,
                          tapBodyToExpand: false,
                          animationDuration: Duration(milliseconds: 250),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 15.0);
                    },
                    itemCount: homeProvider.filteredPosts.length,
                  ),
                ),
              ],
            ),
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Text(
                'Navigation Menu',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 25.0),
              Divider(
                height: 0.5,
                thickness: 0.5,
                color: ColorConstants.appBarBackground.withOpacity(0.75),
              ),
              const SizedBox(height: 25.0),
              ListTile(
                onTap: () => context.goNamed('home'),
                title: Text(
                  'Home',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.right,
                ),
                trailing: const Icon(Icons.home),
              ),
              ListTile(
                onTap: () => context.goNamed('photos'),
                title: Text(
                  'Photos',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.right,
                ),
                trailing: const Icon(Icons.photo),
              ),
            ],
          ),
        ),
      ),
      appBar: JSGuruAppBar(
        actions: [
          IconButton(
            onPressed: () => homeKey.currentState?.openEndDrawer(),
            icon: const Icon(Icons.menu, color: Colors.white),
          )
        ],
      ),
    );
  }
}
