/// ToolData : [{"Img":"http://api.fit-lyft.com/Images/slider1.png","Title":"Fitlyft Application","Description":"Congratulations on taking a forward step to get in shape and feel great"},{"Img":"http://api.fit-lyft.com/Images/slider2.png","Title":"Have nice body","Description":"Congratulations on taking a forward step to get in shape and feel great"}]
/// IsAdded : true

class SlidersModel {
  SlidersModel({
    List<ToolData>? toolData,
    bool? isAdded,
  }) {
    _toolData = toolData;
    _isAdded = isAdded;
  }

  SlidersModel.fromJson(dynamic json) {
    if (json['ToolData'] != null) {
      _toolData = [];
      json['ToolData'].forEach((v) {
        _toolData?.add(ToolData.fromJson(v));
      });
    }
    _isAdded = json['IsAdded'];
  }
  List<ToolData>? _toolData;
  bool? _isAdded;

  List<ToolData>? get toolData => _toolData;
  bool? get isAdded => _isAdded;


}

/// Img : "http://api.fit-lyft.com/Images/slider1.png"
/// Title : "Fitlyft Application"
/// Description : "Congratulations on taking a forward step to get in shape and feel great"

class ToolData {
  ToolData({
    String? img,
    String? title,
    String? description,
  }) {
    _img = img;
    _title = title;
    _description = description;
  }

  ToolData.fromJson(dynamic json) {
    _img = json['Img'];
    _title = json['Title'];
    _description = json['Description'];
  }
  String? _img;
  String? _title;
  String? _description;

  // can delete this getters an make attributes public
  String? get img => _img;
  String? get title => _title;
  String? get description => _description;


}
