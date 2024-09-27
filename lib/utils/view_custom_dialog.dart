import 'package:flutter/material.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';

Future<void> viewCustomDialog({
  required BuildContext context,
  required String title,
  required Widget content,
  String? confirmButtonText,
  String? cancelButtonText,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
}) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xffABBFB8),
        title: Text(
          title,
          style: AppStyle.styleRegular18,
        ),
        content: content,
        actions: <Widget>[
          if (cancelButtonText != null)
            TextButton(
              onPressed: () {
                if (onCancel != null) {
                  onCancel();
                }
                Navigator.of(context).pop();
              },
              child: Text(
                cancelButtonText,
                style: AppStyle.styleSemiBold28,
              ),
            ),
          if (confirmButtonText != null)
            TextButton(
              onPressed: () {
                if (onConfirm != null) {
                  onConfirm();
                }
                Navigator.of(context).pop();
              },
              child: Text(
                confirmButtonText,
                style: AppStyle.styleSemiBold28.copyWith(
                  color: Colors.red[500],
                ),
              ),
            ),
        ],
      );
    },
  );
}
