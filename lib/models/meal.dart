class Meal {
  final String strMeal;
  final String strMealThumb;
  String idMeal;
  final String? strInstructions;
  final String? strCategory;

  Meal({  
    required this.idMeal,
    required this.strInstructions,
    required this.strCategory,
    required this.strMeal,
    required this.strMealThumb,
  });

  factory Meal.fromJson(Map<dynamic, dynamic> json) => Meal(
       idMeal: json["idMeal"],
        strInstructions: json["strInstructions"],
        strCategory: json["strCategory"],
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
      );

  Map<String, dynamic> toJson() => {        
        "idMeal": idMeal,
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "strInstructions": strInstructions,
        "strCategory": strCategory,        
      };

      void setFavorite(String id){
        idMeal = id;
      }
}
