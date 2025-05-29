import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'models/meal_model.dart';
import 'screens/detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TheMealDB',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomeScreen(),
      routes: {
        '/detail': (context) {
          final Meal meal = ModalRoute.of(context)!.settings.arguments as Meal;
          return DetailScreen(meal: meal);
        },
      },
    );
  }
}
