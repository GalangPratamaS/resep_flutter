import 'meal.dart';

class ResponseFilter {
  final List<Meal> meals;

  ResponseFilter({
    required this.meals,
  });

  factory ResponseFilter.fromJson(Map<String, dynamic> json) => ResponseFilter(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );
}

