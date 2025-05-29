import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal_model.dart';

class MealService {
  static Future<List<Meal>> fetchMeals(String category) async {
    final url = 'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final meals = (body['meals'] as List).map((json) => Meal.fromJson(json)).toList();
      return meals;
    } else {
      throw Exception('Failed to load meals');
    }
  }
}
