import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:jsg_test/data/constants/color_constants.dart';
import 'package:jsg_test/data/models/post.dart';

class JSGuruPostTile extends StatelessWidget {
  final Post post;
  final Function(Post) onPostTapped;

  const JSGuruPostTile(
      {super.key, required this.post, required this.onPostTapped});

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      collapsed: const SizedBox(),
      header: headerSection(context),
      expanded: commentsSection(context),
      theme: const ExpandableThemeData(
        iconColor: ColorConstants.appBarBackground,
        headerAlignment: ExpandablePanelHeaderAlignment.bottom,
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
  }

  Widget headerSection(BuildContext context) {
    return InkWell(
      onTap: () => onPostTapped(post),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          border: Border.all(
            color: ColorConstants.appBarBackground.withOpacity(0.5),
            width: 1.0,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(post.title, style: Theme.of(context).textTheme.titleMedium),
            Row(
              children: [
                Text('by ', style: Theme.of(context).textTheme.bodySmall),
                Text(post.user.name,
                    style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
            const SizedBox(height: 5.0),
            Divider(
              height: 0.5,
              thickness: 0.5,
              color: Theme.of(context).dividerColor,
            ),
            const SizedBox(height: 5.0),
            Text(post.body, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget commentsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comments (${post.comments.length})',
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
                margin: const EdgeInsets.symmetric(vertical: 1.5),
              );
            },
            itemCount: post.comments.length,
            itemBuilder: (context, commentIndex) {
              return Text(
                post.comments[commentIndex].body,
                style: Theme.of(context).textTheme.bodySmall,
              );
            },
          ),
        ],
      ),
    );
  }
}
