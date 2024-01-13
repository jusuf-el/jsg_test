import 'package:flutter/material.dart';
import 'package:jsg_test/data/constants/color_constants.dart';

class JSGuruDropdownButton extends StatelessWidget {
  final dynamic dropdownValue;
  final List<dynamic> items;
  final Future<void> Function(int) onChanged;

  const JSGuruDropdownButton({
    super.key,
    this.dropdownValue,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 85.0,
      child: DropdownButton(
        isExpanded: true,
        value: dropdownValue,
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
          items.length,
          (index) {
            return DropdownMenuItem(
              value: items[index],
              child: Text(
                items[index].toString(),
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
            onChanged(value as int);
          }
        },
      ),
    );
  }
}
