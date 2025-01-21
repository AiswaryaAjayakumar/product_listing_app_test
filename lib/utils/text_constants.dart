import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:product_listing_app_test/utils/color_constants.dart';

class MytextStyle {
  static TextStyle buttonStyle = GoogleFonts.acme(
      textStyle: TextStyle(fontSize: 20, color: ColorConstants.customBlack));

  static TextStyle hintStyle = GoogleFonts.titilliumWeb(
      textStyle: TextStyle(fontSize: 18, color: ColorConstants.customGrey));
  static TextStyle hintStyle1 = GoogleFonts.titilliumWeb(
      textStyle: TextStyle(fontSize: 14, color: ColorConstants.customGrey));

  static TextStyle normalText = GoogleFonts.poppins(
      textStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 15,
          color: ColorConstants.customBlack));

  static TextStyle normalText1 = GoogleFonts.poppins(
      textStyle: TextStyle(fontSize: 15, color: ColorConstants.customGreen),
      fontWeight: FontWeight.bold);

  static TextStyle normalText4 = GoogleFonts.poppins(
      textStyle: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 11,
          color: ColorConstants.customBlack));

  static TextStyle headingText = GoogleFonts.lexend(
      textStyle: TextStyle(fontSize: 30, color: ColorConstants.customBlack),
      fontWeight: FontWeight.w500);

  static TextStyle welcome = GoogleFonts.lexend(
      textStyle: TextStyle(fontSize: 25, color: ColorConstants.customBlack),
      fontWeight: FontWeight.bold);
}
