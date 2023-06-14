import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:receipe_app/database/db_helper.dart';
import 'package:receipe_app/models/meal.dart';
import 'package:receipe_app/network/net_client.dart';

class DetailPage extends StatefulWidget {
  final String? idMeal;
  const DetailPage({super.key, required this.idMeal});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Meal meal;
  bool isLoading = false;
  bool isFavorite = false;
  final db = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Food Recipes'),
        actions: [
          IconButton(
            onPressed: () {
              setFavorite();
            },
            icon: isFavorite
                ? const Icon(Icons.favorite)
                : const Icon(Icons.favorite_border),
          )
        ],
      ),
      body: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  backgroundColor: Colors.orange,
                  strokeWidth: 5,
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Hero(
                            tag: '${meal.idMeal}',
                            child: Material(
                              child: CachedNetworkImage(
                                  imageUrl: meal.strMealThumb!),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text('${meal.strMeal}'),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Text('Instruction'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Center(
                          child: Text('${meal.strInstructions}'),
                        ),
                      )
                    ],
                  ),
                )),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  void setFavorite() async {
    if (!isFavorite) {
      await db.insert(meal);
    } else {
      await db.delete(meal);
    }

    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void fetchDetail() async {
    setState(() {
      isLoading = true;
    });
    isFavorite = await db.isFavorite(widget.idMeal);
    if (isFavorite) {
      // get data local
      final resultMeal = await db.get(widget.idMeal!);
      meal = resultMeal;
    } else {
      // Get data remote
      final netClient = NetClient();
      final result = await netClient.fetchDetail(widget.idMeal!);
      meal = Meal(
          strMeal: result!.meals[0]['strMeal']!,
          strMealThumb: result!.meals[0]['strMealThumb']!,
          idMeal: result!.meals[0]['idMeal']!,
          strInstructions: result!.meals[0]['strInstructions']!,
          strCategory: result!.meals[0]['strCategory']);
    }
    print(meal.strMeal);

    setState(() {
      isLoading = false;
    });
  }
}
