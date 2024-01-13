import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jsg_test/data/constants/text_constants.dart';
import 'package:jsg_test/data/models/post.dart';
import 'package:jsg_test/data/widgets/jsguru_app_bar.dart';
import 'package:jsg_test/data/widgets/jsguru_drawer.dart';
import 'package:jsg_test/data/widgets/jsguru_input_field.dart';
import 'package:jsg_test/data/widgets/jsguru_loader.dart';
import 'package:jsg_test/modules/home/provider/home_provider.dart';
import 'package:jsg_test/modules/home/widgets/jsguru_post_tile.dart';
import 'package:jsg_test/utils/router/router.dart';
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

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).getPosts();
    textEditingController.addListener(() {
      homeProvider.onSearchInputChanged(textEditingController.text);
    });
  }

  onPostTapped(Post post) {
    context.goNamed(JSGuruRouter.postDetails, extra: post);
    textEditingController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      key: homeKey,
      endDrawer: const JSGuruDrawer(),
      appBar: JSGuruAppBar(
        actions: [
          IconButton(
            onPressed: () => homeKey.currentState?.openEndDrawer(),
            icon: const Icon(Icons.menu, color: Colors.white),
          )
        ],
      ),
      body: homeProvider.loading
          ? const JSGuruLoader()
          : Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  child: JSGuruInputField(
                    hintText: TextConstants.searchPosts,
                    textEditingController: textEditingController,
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(15.0),
                    itemBuilder: (context, index) {
                      return JSGuruPostTile(
                        post: homeProvider.filteredPosts[index],
                        onPostTapped: onPostTapped,
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
    );
  }
}
