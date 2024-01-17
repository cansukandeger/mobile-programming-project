// ignore_for_file: prefer_conditional_assignment, non_constant_identifier_names, unnecessary_null_comparison

import 'package:flutter/material.dart';

class ColorManager {
  Color get white => const Color(0xffffffff);
  Color get black => const Color(0xff020306);
  Color get transparent => const Color(0x00000000);
  Color get primary => const Color(0xff11111b);
  Color get greyBG => const Color(0xFFF2F2F2);
  Color get secondary => const Color(0xFFff85ca);
  Color get secondaryLight => const Color(0xFFADC8CF);
  Color get red => const Color(0xFFFF4E43);
  Color get green => const Color(0xFF2ECEA8);
  Color get grayBorder => const Color(0xFFF0F0F0);
  Color get darkGray => const Color(0xff383838);

  MaterialColor get materialGray => const MaterialColor(
        0xff000000,
        <int, Color>{
          50: Colors.black,
          100: Colors.black,
          200: Colors.black,
          300: Colors.black,
          400: Colors.black,
          500: Colors.black,
          600: Colors.black,
          700: Colors.black,
          800: Colors.black,
          900: Colors.black,
        },
      );
}
