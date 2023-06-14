class ResponseDetail {
    final List<Map<String, String?>> meals;

    ResponseDetail({
        required this.meals,
    });

    factory ResponseDetail.fromJson(Map<String, dynamic> json) => ResponseDetail(
        meals: List<Map<String, String?>>.from(json["meals"].map((x) => Map.from(x).map((k, v) => MapEntry<String, String?>(k, v)))),
    );
  
}
