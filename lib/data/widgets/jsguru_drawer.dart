import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jsg_test/data/constants/color_constants.dart';
import 'package:jsg_test/data/constants/text_constants.dart';
import 'package:jsg_test/utils/router/router.dart';

class JSGuruDrawer extends StatelessWidget {
  const JSGuruDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Text(
              TextConstants.navigationMenu,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 25.0),
            Divider(
              height: 0.5,
              thickness: 0.5,
              color: ColorConstants.appBarBackground.withOpacity(0.75),
            ),
            const SizedBox(height: 25.0),
            drawerItem(
                context, () => context.pop(), TextConstants.home, Icons.home),
            drawerItem(context, () {
              context.pop();
              context.goNamed(JSGuruRouter.photos);
            }, TextConstants.photos, Icons.photo),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(
      BuildContext context, Function() onTap, String label, IconData icon) {
    return ListTile(
      onTap: onTap,
      title: Text(
        label,
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.right,
      ),
      trailing: Icon(icon),
    );
  }
}
