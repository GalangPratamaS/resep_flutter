import 'package:flutter/material.dart';
import 'package:receipe_app/database/db_helper.dart';
import 'package:receipe_app/models/response_filter.dart';
import 'package:receipe_app/ui/widgets/list_meals_widgets.dart';

class FavoritPage extends StatefulWidget {
  const FavoritPage({super.key});

  @override
  State<FavoritPage> createState() => _FavoritPageState();
}

class _FavoritPageState extends State<FavoritPage> {
  int currentIndex = 0;
  String category = 'Seafood';
  ResponseFilter? responseFilter;
  bool isLoading = false;

  var db = DBHelper();

  @override
  Widget build(BuildContext context) {
      final listNav = [
      ListMeal(responseFilter: responseFilter, fetchDataMeals: fetchDataMeals) ,
      ListMeal(responseFilter: responseFilter, fetchDataMeals: fetchDataMeals,),
    ];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receipe App"),
        
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : listNav[currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: "Seafood"),
          BottomNavigationBarItem(icon: Icon(Icons.cake), label: "Dessert"),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
            index == 0 ? category =  "Seafood" : category = "Dessert";
          });
          fetchDataMeals();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchDataMeals();
  }


  void fetchDataMeals() async {
    setState(() {
      isLoading = true;
    });

    var data = await db.gets(category);
    setState(() {
      responseFilter = ResponseFilter(meals: data);
      isLoading = false;
    });
  }
}