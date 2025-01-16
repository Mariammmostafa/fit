class GetSportClassRequest {
    GetSportClassRequest({
        required this.toolData,
        required this.isAdded,
    });

    final List<SportsClassModel> toolData;
    final bool? isAdded;

    factory GetSportClassRequest.fromJson(Map<String, dynamic> json){ 
        return GetSportClassRequest(
            toolData: json["ToolData"] == null ? [] : List<SportsClassModel>.from(json["ToolData"]!.map((x) => SportsClassModel.fromJson(x))),
            isAdded: json["IsAdded"],
        );
    }

}

class SportsClassModel {
    SportsClassModel({
        required this.classNumber,
        required this.className,
        required this.days,
        required this.poster,
        required this.hours,
        required this.price,
    });

    final int? classNumber;
    final String? className;
    final String? days;
    final String? poster;
    final int? hours;
    final String? price;

    factory SportsClassModel.fromJson(Map<String, dynamic> json){ 
        return SportsClassModel(
            classNumber: json["class_number"],
            className: json["class_name"],
            days: json["days"],
            poster: json["poster"],
            hours: json["hours"],
            price: json["price"],
        );
    }

}
