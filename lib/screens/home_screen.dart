import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../services/meal_service.dart';
import '../widgets/meal_card.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<String> _categories = ['Seafood', 'Dessert', 'Vegan'];
  late Future<List<Meal>> _meals;

  @override
  void initState() {
    super.initState();
    _meals = MealService.fetchMeals(_categories[_selectedIndex]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _meals = MealService.fetchMeals(_categories[_selectedIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TheMealDB")),
      body: FutureBuilder<List<Meal>>(
        future: _meals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError) return const Center(child: Text('Error loading meals.'));
          final meals = snapshot.data!;
          return GridView.count(
            crossAxisCount: 2,
            children: meals.map((meal) => MealCard(meal: meal)).toList(),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: "Seafood"),
          BottomNavigationBarItem(icon: Icon(Icons.cake), label: "Dessert"),
          BottomNavigationBarItem(icon: Icon(Icons.eco), label: "Vegan"),
        ],
      ),
    );
  }
}
