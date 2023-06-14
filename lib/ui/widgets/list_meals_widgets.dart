import 'package:flutter/material.dart';
import 'package:receipe_app/models/response_filter.dart';
import 'package:receipe_app/ui/pages/detail_page.dart';
import 'package:receipe_app/ui/widgets/item_meal_widgets.dart';

class ListMeal extends StatelessWidget {
  final ResponseFilter? responseFilter;
  final Function()? fetchDataMeals;

  const ListMeal(
      {super.key, required this.responseFilter, this.fetchDataMeals});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: responseFilter?.meals.length,
      itemBuilder: (context, index) {
        final meal = responseFilter?.meals[index];
        return meal != null
            ? InkWell(
                onTap: () async {
                  final route = MaterialPageRoute(
                      builder: (context) => DetailPage(
                            idMeal: meal.idMeal,
                          ));
                  await Navigator.push(context, route);
                  fetchDataMeals!();
                },
                child: ItemMealWidget(meal: meal),
              )
            : Container();
        // return ItemMealWidget(meal: meal!);
      },
    );
  }
}
