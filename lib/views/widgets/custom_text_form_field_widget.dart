import 'package:flutter/material.dart';
import 'package:sample_quiz_app_ui/utils/app_style.dart';

class CustomTextFormFieldWidget extends StatefulWidget {
  const CustomTextFormFieldWidget({
    super.key,
    this.hintText,
    this.labelText,
    this.width,
    this.height,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.onChanged,
    this.onTap,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final double? width;
  final double? height;
  final IconData? prefixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final Future<void> Function()? onTap;

  @override
  State<CustomTextFormFieldWidget> createState() =>
      _CustomTextFormFieldWidgetState();
}

class _CustomTextFormFieldWidgetState extends State<CustomTextFormFieldWidget> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  String? initialValue;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        cursorWidth: 6,
        cursorColor: Colors.black,
        onTap: widget.onTap,
        readOnly: widget.onTap == null ? false : true,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xffD9D9D9),
          prefixIcon: widget.prefixIcon == null
              ? null
              : Icon(
                  widget.prefixIcon,
                  color: const Color(0xff777777),
                ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 6,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: widget.hintText,
          hintStyle: AppStyle.styleRegular18
              .copyWith(color: const Color(0xff000000).withOpacity(0.5)),
          label: getLabel(),
          errorMaxLines: 3,
        ),
      ),
    );
  }

  Widget? getLabel() {
    if (_isFocused ||
        widget.hintText == null ||
        widget.controller!.text.isNotEmpty) {
      return null;
    } else {
      return Text(widget.labelText ?? widget.hintText!,
          style: AppStyle.styleRegular18
              .copyWith(color: const Color(0xff000000).withOpacity(0.5)));
    }
  }
}
