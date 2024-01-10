import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jsg_test/data/constants/asset_constants.dart';
import 'package:jsg_test/data/constants/color_constants.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final GlobalKey<ScaffoldState> homeKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeKey,
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
                title: Text(
                  'Home',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.right,
                ),
                trailing: const Icon(Icons.home),
              ),
              ListTile(
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
      appBar: AppBar(
        centerTitle: true,
        title: SvgPicture.asset(
          AssetConstants.logo,
          height: AppBar().preferredSize.height * 0.75,
        ),
        actions: [
          IconButton(
            onPressed: () => homeKey.currentState?.openEndDrawer(),
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
