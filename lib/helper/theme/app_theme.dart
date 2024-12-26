import 'package:flutter/material.dart';
import 'package:tentwenty_assessment/helper/theme/text_theme.dart';

import '../constants/colors_resources.dart';
import '../constants/dimension_resources.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    cardColor: Colorss.COLOR_CARD_BACKGROUND,
    primaryColorDark: Colorss.PRIMARY_COLOR_DARK,
    scaffoldBackgroundColor: Colorss.WHITE,
    primaryColor: Colorss.PRIMARY_COLOR,
    datePickerTheme: const DatePickerThemeData(
      headerBackgroundColor: Colorss.PINK_COLOR,
    ),
    colorScheme: ThemeData()
        .colorScheme
        .copyWith(primary: Colorss.COLOR_CARD_BACKGROUND),
    appBarTheme:  const AppBarTheme(
        backgroundColor: Colorss.WHITE,
        titleTextStyle: TextStyle(
            fontSize: Dim.D_20,
            fontWeight: FontWeight.normal,
            color: Colorss.COLOR_BLACK)),
    textSelectionTheme:  const TextSelectionThemeData(
      cursorColor: Colorss.PRIMARY_COLOR,
      selectionColor: Colorss.TEXT_FIELD_BORDER_COLOR,
      selectionHandleColor: Colorss.PRIMARY_COLOR,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dim.RADIUS_SMALL),
          borderSide:  const BorderSide(color: Colorss.TEXT_FIELD_BORDER_COLOR)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dim.RADIUS_SMALL),
          borderSide:  const BorderSide(color: Colorss.TEXT_FIELD_BORDER_COLOR)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dim.RADIUS_SMALL),
          borderSide:  const BorderSide(color: Colorss.TEXT_FIELD_BORDER_COLOR)),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dim.RADIUS_SMALL),
          borderSide:  const BorderSide(color: Colorss.TEXT_FIELD_BORDER_COLOR)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dim.RADIUS_SMALL),
          borderSide:  const BorderSide(color: Colorss.TEXT_FIELD_BORDER_COLOR)),
      focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Dim.RADIUS_SMALL),
          borderSide:  const BorderSide(color: Colorss.TEXT_FIELD_BORDER_COLOR)),
    ),
    textTheme: textTheme,
  );
}
