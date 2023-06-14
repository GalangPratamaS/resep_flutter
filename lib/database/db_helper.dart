import 'package:path_provider/path_provider.dart';
import 'package:receipe_app/models/meal.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  DBHelper._createInstance();

  static final DBHelper _instance = DBHelper._createInstance();

  factory DBHelper() => _instance;

  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) return _db;
    _db = await setDB();
    return _db;
  }

  setDB() async {
    final directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "mealsDb");
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    var sql =
        "CREATE TABLE favorite(id INTEGER PRIMARY KEY, idMeal TEXT, strMeal TEXT, strInstructions TEXT, strMealThumb TEXT, strCategory TEXT)";
    await db.execute(sql);
  }

  // CRUD SQFLITE

  // INSERT
  Future<int> insert(Meal meal) async {
    var dbIns = await db;
    int res = await dbIns!.insert("favorite", meal.toJson());
    return res;
  }

  // READ (LIST)
  Future<List<Meal>> gets(String category) async {
    var dbC = await db;
    var sql = "SELECT * FROM favorite WHERE strCategory=? ORDER BY idMeal DESC";

    List<Map> list = await dbC!.rawQuery(sql, [category]);
    List<Meal> favorites = [];
    for (int i = 0; i < list.length; i++) {
      Meal favorite = Meal(
        idMeal: list[i]['idMeal'],
        strInstructions: list[i]['strInstructions'],
        strCategory: list[i]['strCategory'],
        strMeal: list[i]['strMeal'],
        strMealThumb: list[i]['strMealThumb'],
      );
      favorite.setFavorite(list[i]["idMeal"]);
      favorites.add(favorite);
    }
    return favorites;
  }

  // READ (item list)
  Future<Meal> get(String idMeal) async {
    var dbClient = await db;
    var sql = "SELECT * FROM favorite WHERE idMeal=? ORDER BY idMeal DESC";
    List<Map> list = await dbClient!.rawQuery(sql, [idMeal]);
    if (list.isNotEmpty) {
      return Meal.fromJson(list.first);
    } else {
      throw Exception('ID $idMeal not found');
    }
  }

  // DELETE
  Future<int> delete(Meal meals) async {
    var dbClient = await db;
    var sql = "DELETE FROM favorite WHERE idMeal = ?";
    int res = await dbClient!.rawDelete(sql, [meals.idMeal]);
    print("Favorite data deleted");
    return res;
  }

  // CHECK TERDAFTAR FAV / TIDAK
  Future<bool> isFavorite(String? idMeals) async {
    var dbClient = await db;
    var sql = "SELECT * FROM favorite WHERE idMeal = ?";
    var res = await dbClient!.rawQuery(sql, [idMeals]);

    return res.isNotEmpty;
  }
}
