import 'package:data_reader_client/style/palette.dart';
import 'package:data_reader_client/style/text_theme.dart';
import 'package:flutter/material.dart';
import 'icon_theme.dart';

ThemeData defaultTheme = ThemeData(
  textTheme: textDefaultTheme,

  scaffoldBackgroundColor: palette[Col.background],

  appBarTheme: AppBarTheme(
      iconTheme: appbarIcon,
      titleTextStyle: textDefaultTheme.titleLarge,
      centerTitle: true,
      backgroundColor: palette[Col.background],

  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: palette[Col.primary],
    selectedItemColor: palette[Col.secondary]
  ),

  drawerTheme: DrawerThemeData(
    backgroundColor: palette[Col.background],
    width: 200,
  ),

  cardTheme: CardTheme(
    color:  palette[Col.secondary],
  ),

  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(palette[Col.primary]),
      foregroundColor: WidgetStateProperty.all(palette[Col.background])
    )
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      side: WidgetStateProperty.all(BorderSide(
        color: palette[Col.primary]!,
        width: 1.5
      )),
      foregroundColor: WidgetStateProperty.all(palette[Col.primary]),
    )
  ),

  textSelectionTheme: TextSelectionThemeData(
    cursorColor: palette[Col.primary],
  ),


  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: palette[Col.secondary],
    hintStyle: textDefaultTheme.titleMedium,
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: palette[Col.primary]!, width: 2),
    ),
  ),

  dividerTheme: DividerThemeData(
    color: palette[Col.primary],
    thickness: 2
  ),

);

BoxDecoration defaultUADHTheme = BoxDecoration(
  color: palette[Col.secondary]
);