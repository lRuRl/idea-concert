import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iruri/components/palette.dart';

TextStyle bottomNavigationLabelTextStyle = TextStyle(
  fontSize: 12.0,
);

// app bar title
TextStyle appBarTitleTextStyle =
    TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black);

// home typhography
TextStyle bodyTextStyle = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black87);

TextStyle articleTitleTextStyle =
    TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black);
TextStyle articleTagTextStyle = TextStyle(
    fontSize: 11.0, fontWeight: FontWeight.normal, color: Colors.black);
TextStyle articleWriterTextStyle = TextStyle(
    fontSize: 12.0, fontWeight: FontWeight.normal, color: themeGrayText);
TextStyle articleDuedateTextStyle =
    TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600, color: themeOrange);
TextStyle articleDuedateTextStyle2 =
    TextStyle(fontSize: 10.0, fontWeight: FontWeight.w600, color: themeOrange);

TextStyle buttonWhiteTextStyle =
    TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

// Markdown standard
// @param FontWeight
// NotoSansKR
TextStyle notoSansTextStyle(
        {double fontSize, FontWeight fontWeight, Color textColor}) =>
    GoogleFonts.notoSans(
        fontSize: fontSize != null ? fontSize : 18,
        letterSpacing: 1.4, // 행간
        fontWeight: fontWeight != null ? fontWeight : FontWeight.normal,
        color: textColor != null ? textColor : primary);
// Montsesrrat
TextStyle montSesrratTextStyle(
        {double fontSize, FontWeight fontWeight, Color textColor}) =>
    GoogleFonts.montserrat(
        fontSize: fontSize != null ? fontSize : 18,
        letterSpacing: 1.4, // 행간
        fontWeight: fontWeight != null ? fontWeight : FontWeight.normal,
        color: textColor != null ? textColor : primary);
