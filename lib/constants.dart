import 'package:flutter/material.dart';


  


const String google_api_key = "AIzaSyCtc6M45mhR3JijArhwSa0Dr_Kv8NGqCf4";
const Color primaryColor = Color.fromARGB(255, 130, 77, 222);

const Color blue1 = Color(0xFF888888);
const Color blue2 = Color(0xFF999999);
const Color blue3 = Color(0xFFaaaaaa);
const Color blue4 = Color(0xFFbbbbbb);
const Color blue5 = Color(0xFFcccccc);
const Color blue6 = Color(0xFFdddddd);
const Color mainbackgroundcolor = Color(0xFF3c1414);
const Color subbackgroundcolor = Color (0xFF7FA366);
const Color topbarbackgroundcolor = Color (0xFF3c1414);
const Color buttombarbackgroundcolor = Color (0xFF7FA366);
const Color bordercolor = Color (0xFFFFFFFF);
const Color shadowcolor = Color.fromARGB(255, 129, 125, 125);
const Color Gradienttop = Color.fromARGB(255, 14, 26, 129);
const Color Gradientbuttom = Color.fromARGB(255, 14, 26, 129);

// Added board colors
final List<Color> boardColors = [
  const Color(0xFF8c9091),
  const Color(0xFF8c9091),
  const Color(0xFF8c9091), // you can add more colors if you have more boards
];

// Added board text styles
final List<TextStyle> boardTextStyles = [
  TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFFFFFFF)),
  TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Color(0xFFFFFFFF)),
  TextStyle(fontSize: 20, fontWeight: FontWeight.w300, color: Color(0xFFFFFFFF)), 
  // you can add more text styles if you have more boards
];

const titlecustomTextStyle = TextStyle(
  fontFamily: 'Dubai', // Replace with the actual font family name
  fontSize: 18, // You can adjust the font size as needed.
  fontWeight: FontWeight.bold,
  // You can customize other properties like color, letterSpacing, etc. here.
);

const subtitleTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 16,
  fontFamily: 'Dubai',
);

const double defaultPadding = 16.0;
