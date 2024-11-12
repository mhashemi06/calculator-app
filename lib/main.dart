import 'package:calculator/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CalendarApplication());
}

class CalendarApplication extends StatefulWidget {
  const CalendarApplication({super.key});

  @override
  State<CalendarApplication> createState() => _CalendarApplicationState();
}

class _CalendarApplicationState extends State<CalendarApplication> {
  @override
  Widget build(BuildContext context) {
    return getMaterial();
  }
}

Widget getMaterial() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Calculator',
    home: HomeScreen(),
  );
}
