import 'package:flutter/material.dart';
import 'package:iruri/components/palette.dart';
import 'package:iruri/components/spacing.dart';
import 'package:iruri/components/typhography.dart';

InputDecoration textFieldStyle({Icon icon, String labelText}) => InputDecoration(
    // border
    border: roundedTextInputBorder,
    focusedBorder: roundedFocusedTextInputBorder,
    enabledBorder: roundedTextInputBorder,
    disabledBorder: roundedTextInputBorder,
    focusedErrorBorder: roundedTextInputBorder,
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Colors.red)),
    // icon
    icon: icon != null ? icon : null,
    // label
    labelText: labelText != null ? labelText : null,
    labelStyle: bodyTextStyle,
    // cursor
    contentPadding: paddingH20V5,
    // color
    focusColor: themeLightOrange,
    filled: true,
    fillColor: lightWhite);

InputDecoration searchInputDecoration = InputDecoration(
    // remove underline and make rounded
    border: roundedTextInputBorder,
    errorBorder: roundedTextInputBorder,
    enabledBorder: roundedTextInputBorder,
    focusedBorder: roundedFocusedTextInputBorder,
    disabledBorder: roundedTextInputBorder,
    focusedErrorBorder: roundedTextInputBorder,
    // label
    labelStyle: bodyTextStyle,
    // cursor
    contentPadding: paddingH20V5,
    // color
    filled: true,
    fillColor: lightWhite);
OutlineInputBorder roundedTextInputBorder = OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.all(Radius.circular(20)));
OutlineInputBorder roundedFocusedTextInputBorder = OutlineInputBorder(
    borderSide: BorderSide(color: themeLightOrange),
    borderRadius: BorderRadius.all(Radius.circular(20)));
