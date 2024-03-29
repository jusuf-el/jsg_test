import 'package:flutter/material.dart';
import 'package:jsg_test/data/models/photo.dart';

class PhotoTile extends StatelessWidget {
  final bool isLast;
  final Photo photo;

  const PhotoTile({super.key, required this.isLast, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 50.0 : 10.0),
      child: Row(
        children: [
          SizedBox(
            width: 150.0,
            height: 150.0,
            child: Image.network(photo.thumbnailUrl),
          ),
          const SizedBox(width: 15.0),
          Expanded(
            child: Text(
              photo.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
