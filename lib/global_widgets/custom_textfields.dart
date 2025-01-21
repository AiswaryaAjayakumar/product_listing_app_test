import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product_listing_app_test/utils/text_constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;

  final String? labelText;

  final String? hintText;

  final Widget? prefixIcon;

  final TextInputType? keyboardType;

  final List<TextInputFormatter>? inputFormatters;

  final int? maxLength;

  final String? Function(String?)? validator;

  final AutovalidateMode autovalidateMode;

  final TextStyle? labelStyle;
  final TextStyle? hintStyle;

  const CustomTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.labelStyle,
    this.hintStyle,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: autovalidateMode,
      keyboardType: keyboardType,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      validator: validator,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        hintText: hintText,

        labelStyle: labelStyle ?? MytextStyle.hintStyle1,
        hintStyle: hintStyle ?? MytextStyle.hintStyle1,

        prefixIcon: prefixIcon,

        counterText: "", 
      ),
    );
  }
}
