import 'package:flutter/material.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';

class BottomSheetHeaderWidget extends StatelessWidget {
  const BottomSheetHeaderWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          const Spacer(
            flex: 5,
          ),
          Text(
            title,
            style: AppStyle.styleBold22.copyWith(fontSize: 28),
          ),
          const Spacer(
            flex: 3,
          ),
          IconButton(
            icon: const Icon(
              Icons.close,
              size: 34,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
