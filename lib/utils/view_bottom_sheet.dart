import 'package:flutter/material.dart';

Future<void> viewBottomSheet(
    BuildContext context, Widget bottomSheetBody) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: const Color(0xff86948F),
    context: context,
    builder: (context) {
      return bottomSheetBody;
    },
  );
}
