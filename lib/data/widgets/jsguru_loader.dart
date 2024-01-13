import 'package:flutter/material.dart';
import 'package:jsg_test/data/constants/color_constants.dart';

class JSGuruLoader extends StatelessWidget {
  const JSGuruLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorConstants.appBarBackground,
      ),
    );
  }
}
