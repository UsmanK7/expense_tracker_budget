import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color myblue = Color(0xff95AEEE);
const Color light_bg = Color(0xffF0F2F5);
const Color dark_bg = Color(0xff121212);
const Color myGreen = Color(0xff00A86B);
const Color myRed = Color(0xffFD3C4A);
const Color budgetBlue = Color(0xff4A90E2);


class Themes {
  static final light = ThemeData(
    scaffoldBackgroundColor: Color(0xffF0F2F5),
    brightness: Brightness.light,
    // textTheme: GoogleFonts.poppinsTextTheme(),
  );

  static final dark = ThemeData(
    scaffoldBackgroundColor: Color(0xff121212),
    // textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.white),
    brightness: Brightness.dark,
  );
}

// class Const{

// final List<Map<String, dynamic>> expenseCategories = [
//     {"name": "Food", "icon": Icons.fastfood},
//     {"name": "Transportation", "icon": Icons.directions_car},
//     {"name": "Shopping", "icon": Icons.shopping_cart},
//     {"name": "Utilities", "icon": Icons.lightbulb_outline},
//     {"name": "Housing", "icon": Icons.home},
//     {"name": "Entertainment", "icon": Icons.local_movies},
//     {"name": "Healthcare", "icon": Icons.local_hospital},
//     {"name": "Education", "icon": Icons.school},
//     {"name": "Travel", "icon": Icons.flight},
//     {"name": "Insurance", "icon": Icons.local_offer},
//     {"name": "Charity", "icon": Icons.favorite},
//     {"name": "Personal Care", "icon": Icons.person},
//     {"name": "Gifts", "icon": Icons.card_giftcard},
//     {"name": "Other", "icon": Icons.category},
//   ];

// final List<String> cards = [
//   "HBL",
//   "Askari Bank"
// ];

// }

List<Color> sectionColors = [
  Colors.red,
  Colors.yellow,
  Colors.blue,
  Colors.green,
  Colors.orange,
  Colors.purple,
  Colors.teal,
  Colors.pink,
  Colors.amber,
  Colors.indigo,
  Colors.brown,
  Colors.grey,
  Colors.cyan,
  Colors.lime,
  Colors.deepOrange,
  Colors.deepPurple,
  Colors.lightBlue,
  Colors.lightGreen,
  Colors.deepPurpleAccent,
  Colors.redAccent,
];

List<Color> incomeColors = [
  Colors.green,
  Colors.blue,
  Colors.teal,
  Colors.orange,
  Colors.indigo,
  Colors.pink,
  Colors.amber,
  Colors.lightBlue,
  Colors.red,
  Colors.deepOrange,
  Colors.lime,
  Colors.deepPurple,
  Colors.cyan,
  Colors.purple,
  Colors.brown,
  Colors.blueGrey,
  Colors.yellow,
  Colors.deepOrangeAccent,
  Colors.lightGreen,
  Colors.deepPurpleAccent,
];
