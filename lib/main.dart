import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';

// Define custom colors
const darkestBlue = Color.fromARGB(255, 43, 83, 108);
const mediumBlue = Color.fromARGB(255, 29, 167, 189);
const lightOrange = Color.fromARGB(255, 227, 142, 73);
const lightestBlue = Color.fromARGB(255, 212, 235, 248);

var kColorScheme = ColorScheme.fromSeed(
  seedColor: darkestBlue,
);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimary,
          foregroundColor: kColorScheme.primary,
        ),
        scaffoldBackgroundColor: kColorScheme.onPrimary,
        // cardTheme: const CardTheme().copyWith(
        //   color: kColorScheme.secondaryContainer,
        //   margin: const EdgeInsets.symmetric(
        //     vertical: 5,
        //     horizontal: 15,
        //   ),
        // ),
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: kColorScheme.primaryContainer,
        //   ),
        // ),
        // textTheme: ThemeData().textTheme.copyWith(
        //   titleLarge: TextStyle(
        //     fontSize: 20,
        //     fontWeight: FontWeight.bold,
        //     color: kColorScheme.onSecondaryContainer,
        //   ),
        // ),
      ),
      home: const Expenses(),
    ),
  );
}

// Color.fromARGB(255, 212, 235, 248)
// Color.fromARGB(255, 31, 80, 154)
// Color.fromARGB(255, 10, 57, 129)
// Color.fromARGB(255, 227, 142, 73)