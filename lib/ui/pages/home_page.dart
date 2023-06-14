import 'package:flutter/material.dart';
import 'package:receipe_app/models/response_filter.dart';
import 'package:receipe_app/network/net_client.dart';
import 'package:receipe_app/ui/pages/favorite_page.dart';
import 'package:receipe_app/ui/widgets/list_meals_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ResponseFilter? responseFilter;
  bool isLoading = true;
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final listNav = [
      ListMeal(responseFilter: responseFilter),
      ListMeal(responseFilter: responseFilter)
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receipe App"),
        actions: [
          IconButton(onPressed: () {
            // PINDAH HALAMAN            
             final route = MaterialPageRoute(
                      builder: (context) => const FavoritPage());
                  Navigator.push(context, route);
          }, icon: Icon(Icons.favorite))
        ],
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
    try {
      NetClient client = NetClient();
      final data = await client.fetchDataMeals(currentIndex);
      setState(() {
        isLoading = false;
        responseFilter = data;
      });
      print("Data meals ${responseFilter?.meals}");
    } catch (e) {
      print(e);
    }
  }

  


}
