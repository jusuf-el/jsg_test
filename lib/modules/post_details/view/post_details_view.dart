import 'package:flutter/material.dart';
import 'package:jsg_test/data/constants/color_constants.dart';
import 'package:jsg_test/data/constants/text_constants.dart';
import 'package:jsg_test/data/models/comment.dart';
import 'package:jsg_test/data/models/post.dart';
import 'package:jsg_test/data/widgets/jsguru_app_bar.dart';

class PostDetailsView extends StatelessWidget {
  final Post post;

  const PostDetailsView(this.post, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const JSGuruAppBar(automaticallyImplyLeading: true),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerSection(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 15.0),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.body,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      '${TextConstants.comments} ${TextConstants.valueInParenthesis(post.comments.length.toString())}',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5.0),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return commentTile(context, post.comments[index]);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 5.0);
                      },
                      itemCount: post.comments.length,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerSection(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          authorSection(context),
        ],
      ),
    );
  }

  Widget authorSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15.0),
        Divider(
            height: 1.0, thickness: 1.0, color: Theme.of(context).dividerColor),
        const SizedBox(height: 5.0),
        Text(
          TextConstants.authorDetails,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        authorDetailRow(context, TextConstants.name, post.user.name),
        authorDetailRow(context, TextConstants.email, post.user.email),
        authorDetailRow(context, TextConstants.phone, post.user.phone),
        authorDetailRow(context, TextConstants.company, post.user.company.name),
        const SizedBox(height: 5.0),
        Divider(
            height: 1.0, thickness: 1.0, color: Theme.of(context).dividerColor),
      ],
    );
  }

  Widget authorDetailRow(BuildContext context, String label, String value) {
    return RichText(
      text: TextSpan(
        text: label,
        style: Theme.of(context).textTheme.titleSmall,
        children: [
          TextSpan(text: value, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }

  Widget commentTile(BuildContext context, Comment comment) {
    return ListTile(
      tileColor: ColorConstants.appBarBackground.withOpacity(0.1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
      subtitle: Row(
        children: [
          Expanded(
            child: Text(comment.name,
                style: Theme.of(context).textTheme.bodySmall),
          ),
          Text(comment.email, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.body, style: Theme.of(context).textTheme.labelLarge),
          const SizedBox(height: 2.5),
          Divider(
            height: 0.5,
            thickness: 0.5,
            color: Theme.of(context).dividerColor,
            indent: 25.0,
            endIndent: 25.0,
          ),
          const SizedBox(height: 2.5),
        ],
      ),
    );
  }
}
