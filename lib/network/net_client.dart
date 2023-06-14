import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:receipe_app/models/response_detail.dart';
import 'package:receipe_app/models/response_filter.dart';

class NetClient {
  String baseUrl = 'https://www.themealdb.com/api/json/v1/1/';
  late String endPoint;

  Future<ResponseFilter?> fetchDataMeals(int currentIndex) async {
    if(currentIndex == 0) {
      endPoint = "filter.php?c=Seafood";
    } else {
      endPoint = "filter.php?c=Dessert";
    }
    final url = Uri.parse(baseUrl + endPoint);
    try {
      var res = await http.get(url);
      if (res.statusCode == 200) {
        final json = jsonDecode(res.body);
        final data = ResponseFilter.fromJson(json);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future <ResponseDetail?> fetchDetail(String id) async {
    endPoint = "lookup.php?i=$id";
    final url = Uri.parse(baseUrl + endPoint);
    try {
      var res = await http.get(url);
      if(res.statusCode == 200) {
        final json = jsonDecode(res.body);        
        ResponseDetail data = ResponseDetail.fromJson(json);
        return data;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
