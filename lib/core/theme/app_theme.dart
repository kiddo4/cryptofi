import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define static color constants
  static const Color pureWhite = Colors.white;
  static const Color pureBlack = Colors.black;
  static const Color grey = Color(0xFF808080);
  static const Color darkGrey = Color(0xFF1E1E1E);
  static const Color lightGrey = Color(0xFFE0E0E0);

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: pureWhite,
    scaffoldBackgroundColor: pureBlack,
    colorScheme: const ColorScheme.dark(
      primary: pureWhite,
      secondary: grey,
      background: pureBlack,
      surface: darkGrey,
      onPrimary: pureBlack,
      onSecondary: pureWhite,
      onBackground: pureWhite,
      onSurface: pureWhite,
      error: pureWhite,
      onError: pureBlack,
    ),
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
      bodyColor: pureWhite,
      displayColor: pureWhite,
    ),
    iconTheme: const IconThemeData(
      color: pureWhite,
    ),
    cardTheme: CardTheme(
      color: darkGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: pureWhite,
        foregroundColor: pureBlack,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkGrey,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: pureWhite),
      ),
      labelStyle: const TextStyle(color: grey),
      hintStyle: const TextStyle(color: grey),
    ),
    dividerTheme: const DividerThemeData(
      color: grey,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: pureBlack,
      selectedItemColor: pureWhite,
      unselectedItemColor: grey,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: pureBlack,
      foregroundColor: pureWhite,
      elevation: 0,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: pureWhite,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: darkGrey,
      contentTextStyle: TextStyle(color: pureWhite),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return pureWhite;
        return grey;
      }),
      trackColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return grey;
        return darkGrey;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return pureWhite;
        return grey;
      }),
      checkColor: MaterialStateProperty.all(pureBlack),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) return pureWhite;
        return grey;
      }),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: pureWhite,
      foregroundColor: pureBlack,
    ),
  );
}
