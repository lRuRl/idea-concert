import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/typhography.dart';

// textformField - oneline
// InputDecoration
InputDecoration lightWhiteNoneBorderTextInputBox(
        {@required TextEditingController controller}) =>
    InputDecoration(
        // boder
        border: noneBorder,
        errorBorder: noneBorder,
        enabledBorder: noneBorder,
        focusedBorder: noneBorder,
        disabledBorder: noneBorder,
        focusedErrorBorder: noneBorder,
        // icon
        suffixIcon: controller.text.length > 0
            ? IconButton(
                icon: Icon(Icons.cancel_outlined, size: 20, color: subText),
                onPressed: () => controller.clear())
            : null,
        // color
        labelStyle: notoSansTextStyle(),
        fillColor: lightWhite,
        filled: true);

InputDecoration lightWhiteNoneBorderWithIconTextInputBox = InputDecoration(
    // boder
    border: noneBorder,
    errorBorder: noneBorder,
    enabledBorder: noneBorder,
    focusedBorder: noneBorder,
    disabledBorder: noneBorder,
    focusedErrorBorder: noneBorder,
    // icon
    prefixIcon: Icon(Icons.search_rounded, size: 20, color: primaryLine),
    // color
    labelStyle: notoSansTextStyle(),
    fillColor: lightWhite,
    filled: true);

/*
 *  STATUS CODE :
 *  -1 : error state ❌
 *  0 : normal state 
 *  1 : success state ✅
 */
InputDecoration borderTextInputBox(
        {@required bool displaySuffixIcon,
        Function onPressed,
        int validate,
        String errorText,
        Icon icon,
        String labelText,
        String hintText}) =>
    InputDecoration(
        // floating none
        floatingLabelBehavior: FloatingLabelBehavior.never,
        // border
        border: validate == 0 ? primaryBorder : successBorder,
        errorBorder: errorBorder,
        enabledBorder: primaryBorder,
        focusedBorder: primaryBorder,
        disabledBorder: primaryBorder,
        focusedErrorBorder: errorBorder,
        // icon
        suffixIcon: displaySuffixIcon
            ? IconButton(
                icon: Icon(FeatherIcons.xCircle,
                    size: 20,
                    color: validate == 0
                        ? themeGrayText
                        : validate == 1
                            ? onSuccess
                            : onError),
                onPressed: onPressed)
            : null,
        // icon
        icon: icon != null ? icon : null,
        // label
        labelText: labelText != null ? labelText : null,
        hintText: hintText != null ? hintText : null,
        // labelstyle
        labelStyle: notoSansTextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, textColor: subText),
        hintStyle: notoSansTextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, textColor: subText),
        errorStyle: notoSansTextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, textColor: onError),
        errorText: errorText != null ? errorText : null,
        // color
        fillColor: Colors.white,
        filled: true);

// OuttlineInputDecoration
OutlineInputBorder noneBorder = OutlineInputBorder(
    borderSide: BorderSide.none, borderRadius: BorderRadius.circular(8) // 8px
    );
OutlineInputBorder primaryBorder = OutlineInputBorder(
    borderSide: BorderSide(color: subLine, width: 3.0),
    borderRadius: BorderRadius.circular(8) // 8px
    );
OutlineInputBorder errorBorder = OutlineInputBorder(
    borderSide: BorderSide(color: onError, width: 3.0),
    borderRadius: BorderRadius.circular(8) // 8px
    );
OutlineInputBorder successBorder = OutlineInputBorder(
    borderSide: BorderSide(color: onSuccess, width: 3.0),
    borderRadius: BorderRadius.circular(8) // 8px
    );
