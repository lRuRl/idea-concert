import 'package:flutter/material.dart';

// margin
const marginH20V20 = EdgeInsets.all(20);
const marginH20V10 = EdgeInsets.symmetric(horizontal: 20, vertical: 10);

// padding
const paddingH20 = EdgeInsets.symmetric(horizontal: 20);
const paddingH20V20 = EdgeInsets.symmetric(horizontal: 20, vertical: 20);
const paddingH20V5 = EdgeInsets.symmetric(horizontal: 20, vertical: 5);
const paddingH6V4 = EdgeInsets.symmetric(horizontal: 6, vertical: 4);

// advanced : margin
EdgeInsets marginCustom({double hor, double ver}) =>
    EdgeInsets.symmetric(horizontal: hor, vertical: ver);
// advanced : padding
EdgeInsets pddingCustom({double hor, double ver}) =>
    EdgeInsets.symmetric(horizontal: hor, vertical: ver);
