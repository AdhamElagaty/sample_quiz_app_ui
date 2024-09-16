import 'package:flutter/material.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';
import 'package:sample_quiz_app_ui/views/widgets/custom_elevated_button_widget.dart';

class CustomDialogBoxWidget extends StatelessWidget {
  const CustomDialogBoxWidget({
    super.key,
    required this.content,
    required this.title,
    required this.textButton,
    required this.onPressed,
  });

  final Widget content;
  final String title;
  final String textButton;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double parentContainerWidth =
            constraints.maxWidth > 400 ? 400 : constraints.maxWidth;
        final double titleContainerWidth = parentContainerWidth * 0.45;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Card(
                color: Colors.transparent,
                elevation: 18,
                child: Container(
                  width: parentContainerWidth,
                  height: 240,
                  decoration: BoxDecoration(
                    color: const Color(0xffABBFB8),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 24),
                        content,
                        const SizedBox(height: 12),
                        CustomElevatedButtonWidget(
                            width: 122,
                            height: 29,
                            textName: textButton,
                            textStyle: AppStyle.styleMedium18,
                            onPressed: () {}),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: (parentContainerWidth - titleContainerWidth) / 2,
              top: -20, // Adjusted to center the red container
              child: Card(
                elevation: 8,
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffB8E893),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  width: titleContainerWidth,
                  height: 42,
                  child: Center(
                      child: Text(
                    title,
                    style: AppStyle.styleBold22,
                  )),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
