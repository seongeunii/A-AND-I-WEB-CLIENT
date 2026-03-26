import 'package:flutter/material.dart';

final theme = ThemeData(
  primaryColor: const Color(0xff000000),
  useMaterial3: false,
  fontFamily: 'Pretendard',
  textTheme: Typography.blackMountainView.apply(
    fontFamily: 'Pretendard',
    bodyColor: const Color(0xFF000000),
    displayColor: const Color(0xFF000000),
  ),
  primaryTextTheme: Typography.blackMountainView.apply(
    fontFamily: 'Pretendard',
    bodyColor: const Color(0xFF000000),
    displayColor: const Color(0xFF000000),
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Color(0xffffffff)),
  scaffoldBackgroundColor: const Color(0xfff6f6f6),
);
