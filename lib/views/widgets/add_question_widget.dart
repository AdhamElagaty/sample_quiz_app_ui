import 'package:flutter/material.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';

class AddQuestionWidget extends StatelessWidget {
  const AddQuestionWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              text,
              style: AppStyle.styleRegular18.copyWith(fontSize: 24),
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(
              Icons.delete,
              size: 34,
            ),
          )
        ],
      ),
    );
  }
}
