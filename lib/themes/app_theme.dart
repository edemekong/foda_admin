import 'package:flutter/material.dart';

class AppTheme {
  //spaces
  static const double cardPadding = 24;
  static const double elementSpacing = cardPadding * 0.5;
  static const double bottomNavBarHeight = 64;
  static const Duration animationDuration = Duration(milliseconds: 300);
  static BorderRadius cardRadius = BorderRadius.circular(14);
  static const double iconSize = cardPadding;

  static const Color blackLight = Color(0xFF292031);

  static const double buttonHeight = 50;
  static Size size(BuildContext context) => MediaQuery.of(context).size;
  static const double drawerWidth = 280;

  //colors
  static const Color black = Color(0xFF121016);
  static const Color orange = Color(0xFFFFBD69);
  static const Color orangeDark = Color(0xFFFF7565);

  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFFF6363);
  static const Color purple = Color(0xFF543864);
  static const Color purpleDark = Color(0xFF221C29);

  static const Color darkBlue = Color(0xFF202040);
  static const Color grey = Color(0xFF636363);
  static const Color darkBlueLight = Color(0xFF382843);

  static const lightBlue = Color(0xFF2184FE);
  static const navBarColor = Color(0xFF142B43);
  static const navBarColorLight = Color.fromARGB(255, 27, 56, 86);

  static const blue = Color(0xFF2E68FA);
  static const lightorange = Color(0xFFF2B252);
  static const lightBackground = Color(0xFFF5F7FA);

  static const blueGrey = Colors.blueGrey;
  static const darkRed = Color(0xFFFF535E);
  static const dimGrey = Color(0xFFCDD3E1);
  static const green = Color(0xFF29C66F);
  static const yellow = Color(0xFFFFC05A);
  static const incomingMessageColor = Color(0xFFD8D8DA);

  //text theme
  static TextTheme textTheme = const TextTheme(
    headline1: TextStyle(
      fontFamily: 'ArimaMadurai',
      fontSize: 38.4,
      letterSpacing: -1.0,
      color: orange,
      fontWeight: FontWeight.w400,
    ),
    headline2: TextStyle(
      fontFamily: 'ArimaMadurai',
      fontSize: 27.2,
      letterSpacing: -0.25,
      color: white,
      fontWeight: FontWeight.w400,
    ),
    headline3: TextStyle(
      fontFamily: 'ArimaMadurai',
      fontSize: 21.2,
      letterSpacing: 0,
      color: white,
      fontWeight: FontWeight.w600,
    ),
    headline4: TextStyle(
      fontFamily: 'ArimaMadurai',
      fontSize: 20.4,
      letterSpacing: 0,
      color: white,
      fontWeight: FontWeight.w400,
    ),
    headline5: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 18.0,
      letterSpacing: 0,
      color: white,
      fontWeight: FontWeight.w600,
    ),
    headline6: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 17.0,
      letterSpacing: 0.25,
      color: white,
      fontWeight: FontWeight.w400,
    ),
    subtitle1: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 15.3,
      letterSpacing: 0.15,
      color: white,
      fontWeight: FontWeight.w500,
    ),
    subtitle2: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 11.3,
      letterSpacing: 0.1,
      color: white,
      fontWeight: FontWeight.w500,
    ),
    bodyText1: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 13.6,
      letterSpacing: 0.5,
      color: white,
      fontWeight: FontWeight.w500,
    ),
    bodyText2: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 11.9,
      letterSpacing: 0.25,
      color: white,
      fontWeight: FontWeight.w500,
    ),
    caption: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 10.8,
      letterSpacing: 0.4,
      color: white,
      fontWeight: FontWeight.w400,
    ),
    button: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 18.0,
      letterSpacing: 0.60,
      color: white,
      fontWeight: FontWeight.w500,
    ),
    overline: TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 8.0,
      letterSpacing: 0.1,
      color: white,
      fontWeight: FontWeight.w400,
    ),
  );

  static ThemeData theme = ThemeData(
    backgroundColor: black,
    scaffoldBackgroundColor: black,
    primaryColor: red,
    appBarTheme: AppBarTheme(
      titleTextStyle: textTheme.headline6?.copyWith(color: white, fontWeight: FontWeight.w700),
      backgroundColor: darkBlue,
      centerTitle: false,
      elevation: 0.8,
    ),
    hintColor: white,
    indicatorColor: red,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: darkBlue,
      onPrimary: purpleDark,
      secondary: darkBlue,
      onSecondary: darkBlue,
      error: red,
      onError: red,
      background: darkBlue,
      onBackground: darkBlue,
      surface: darkBlue,
      onSurface: darkBlue,
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(red),
      splashRadius: 24,
    ),
    iconTheme: const IconThemeData(color: grey),
    splashColor: red.withOpacity(.4),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: black,
      filled: true,
      labelStyle: textTheme.subtitle1,
      hintStyle: textTheme.bodyText1?.copyWith(
        color: AppTheme.white.withOpacity(.6),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: AppTheme.cardPadding),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    primaryIconTheme: const IconThemeData(
      color: white,
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    unselectedWidgetColor: white,
    textTheme: textTheme,
    primaryTextTheme: textTheme,
    textSelectionTheme: const TextSelectionThemeData(cursorColor: red),
  );
}
