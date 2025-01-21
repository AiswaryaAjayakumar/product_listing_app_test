import 'package:flutter/material.dart';
import 'package:product_listing_app_test/utils/color_constants.dart';
import 'package:product_listing_app_test/utils/text_constants.dart';

class CustomButton extends StatelessWidget {
  final String label;

  final VoidCallback? onPressed;

  final Color? backgroundColor;

  final TextStyle? textStyle;

  final double elevation;

  const CustomButton({
    super.key,
    required this.label,
    this.onPressed,
    this.backgroundColor,
    this.textStyle,
    this.elevation = 5,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? ColorConstants.customBluee,
        elevation: elevation,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: textStyle ?? MytextStyle.buttonStyle,
      ),
    );
  }
}
