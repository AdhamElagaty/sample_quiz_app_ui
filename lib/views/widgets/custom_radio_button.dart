import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatelessWidget {
  const CustomRadioButton({
    super.key,
    required this.child,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.activeColor = Colors.green,
    this.inactiveColor = Colors.grey,
    this.size = 24.0,
    this.alignment,
  });

  final Widget child;
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final Color activeColor;
  final Color inactiveColor;
  final double size;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    bool isSelected = value == groupValue;

    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        alignment: alignment ?? Alignment.topCenter,
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? activeColor : inactiveColor,
            width: isSelected ? 4.0 : 2.0,
          ),
          color: isSelected ? activeColor.withOpacity(0.2) : Colors.transparent,
        ),
        child: child,
      ),
    );
  }
}
