import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jsg_test/data/constants/color_constants.dart';

class JSGuruDrawer extends StatelessWidget {
  const JSGuruDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            drawerItem(
              context,
              () => context.pop(),
              'Home',
              Icons.home,
            ),
            drawerItem(
              context,
              () {
                context.pop();
                context.goNamed('photos');
              },
              'Photos',
              Icons.photo,
            ),
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
