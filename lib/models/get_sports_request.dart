class GetSportsRequest {
  GetSportsRequest({
    required this.toolData,
    required this.isAdded,
  });

  final List<SportModel> toolData;
  final bool? isAdded;

  factory GetSportsRequest.fromJson(Map<String, dynamic> json){
    return GetSportsRequest(
      toolData: json["ToolData"] == null ? [] : List<SportModel>.from(json["ToolData"]!.map((x) => SportModel.fromJson(x))),
      isAdded: json["IsAdded"],
    );
  }

}

class SportModel {
  SportModel({
    required this.sportNumber,
    required this.sportName,
    required this.img,
  });

  final num? sportNumber;
  final String? sportName;
  final String? img;

  factory SportModel.fromJson(Map<String, dynamic> json){
    return SportModel(
      sportNumber: json["sport_number"],
      sportName: json["sport_name"],
      img: json["IMG"],
    );
  }

}
