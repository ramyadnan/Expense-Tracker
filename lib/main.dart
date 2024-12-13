import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'package:expense_tracker/widgets/expenses.dart';

// Define custom colors
const color0 = Color.fromARGB(255, 0, 0, 52);
const color1 = Color.fromARGB(255, 38, 70, 83);
const color2 = Color.fromARGB(255, 42, 157, 143);
const color3 = Color.fromARGB(255, 157, 215, 239);
const color4 = Color.fromARGB(255, 233, 196, 106);
const color5 = Color.fromARGB(255, 244, 162, 97);
const color6 = Color.fromARGB(255, 231, 111, 81);

var kColorScheme = ColorScheme.fromSeed(
  seedColor: color0,
);

var kColorSchemeDark = ColorScheme.fromSeed(
  seedColor: color0,
  brightness: Brightness.dark,
);

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]).then((fn) {
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: kColorSchemeDark,
          cardTheme: const CardTheme().copyWith(
            color: kColorSchemeDark.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 15,
            ),
          ),
        ),
        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimary,
            foregroundColor: kColorScheme.primary,
          ),
          scaffoldBackgroundColor: kColorScheme.onPrimary,
          cardTheme: const CardTheme().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 15,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            ),
          ),
        ),
        themeMode: ThemeMode.system,
        home: const Expenses(),
      ),
    );
  // });
  
}
