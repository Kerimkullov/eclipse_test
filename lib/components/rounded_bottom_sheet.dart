import 'package:flutter/material.dart';

Future<void> showRoundedBottomSheet(
  BuildContext context,
  Widget child, {
  bool isDismissible = true,
  bool enableDrag = true,
  bool isScrollControlled = true,
}) =>
    showModalBottomSheet<void>(
      context: context,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(8.0))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
