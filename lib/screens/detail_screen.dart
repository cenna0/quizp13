import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/meal_model.dart';

class DetailScreen extends StatefulWidget {
  final Meal meal;
  const DetailScreen({super.key, required this.meal});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String instructions = '';

  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  void fetchDetails() async {
    final url = 'https://www.themealdb.com/api/json/v1/1/lookup.php?i=${widget.meal.id}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      setState(() {
        instructions = body['meals'][0]['strInstructions'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: widget.meal.id,
              child: Image.network(widget.meal.thumbnail),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.meal.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(instructions.isEmpty ? "Loading..." : instructions),
            ),
            const SizedBox(height: 24), // biar gak mentok di bawah
          ],
        ),
      ),

    );
  }
}
