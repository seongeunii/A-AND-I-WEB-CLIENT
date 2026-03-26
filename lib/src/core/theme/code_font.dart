import 'package:flutter/material.dart';

const String kVsCodeCodeFontFamily = 'D2Coding';
const List<String> kVsCodeCodeFontFamilyFallback = <String>[
  'monospace',
];

TextStyle vscodeCodeTextStyle(TextStyle style) {
  return style.copyWith(
    fontFamily: kVsCodeCodeFontFamily,
    fontFamilyFallback: kVsCodeCodeFontFamilyFallback,
  );
}
