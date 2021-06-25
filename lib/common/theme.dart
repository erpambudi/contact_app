import 'package:flutter/material.dart';

Color whiteColor = Color(0xFFFFFFFF);
Color greyColor = Color(0xFF8997B8);
Color darkBlueColor = Color(0xFF252836);
Color darkGreyColor = Color(0xFF4D5B7C);
Color purpleColor = Color(0xFF6A6AE3);

TextStyle titleTextStyle = TextStyle(
  color: whiteColor,
  fontWeight: FontWeight.bold,
  fontSize: 26,
);

TextStyle subtitleTextStyle = TextStyle(
  color: greyColor,
  fontWeight: FontWeight.w300,
  fontSize: 16,
);

InputDecoration textFieldInputDecoration = InputDecoration(
  hintText: 'Your hint text',
  hintStyle: TextStyle(
    color: greyColor,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(width: 2, color: purpleColor),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    borderSide: BorderSide(color: darkGreyColor, width: 2),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: whiteColor),
  ),
);
