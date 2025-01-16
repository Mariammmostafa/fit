class TrainersModel {
  List<InstructorData>? _instructorData;
  bool? _isAdded;

  TrainersModel({
    List<InstructorData>? instructorData,
    bool? isAdded,
  }) {
    _instructorData = instructorData;
    _isAdded = isAdded;
  }

  TrainersModel.fromJson(dynamic json) {
    if (json['ToolData'] != null) {
      _instructorData = [];
      json['ToolData'].forEach((v) {
        _instructorData?.add(InstructorData.fromJson(v));
      });
    }
    _isAdded = json['IsAdded'];
  }

  List<InstructorData>? get instructorData => _instructorData;
  bool? get isAdded => _isAdded;
}

class InstructorData {
  int? _instructorID;
  String? _fullName;
  String? _position;
  String? _img;
  String? _exp; 
 
  int? _numofcourse; // عدد الدورات
  int? _rating; // التقييم

  InstructorData({
    int? instructorID,
    String? fullName,
    String? position,
    String? img,
    String? exp,
    int? numofcourse,
    int? rating,
  }) {
    _instructorID = instructorID;
    _fullName = fullName;
    _position = position;
    _img = img;
    _exp = exp;
    _numofcourse = numofcourse;
    _rating = rating;
  }

  InstructorData.fromJson(dynamic json) {
    _instructorID = json['instractorID'];
    _fullName = json['full_name'];
    _position = json['posintion'];
    _img = json['IMG'];
    _exp = json['exp']; // تجربة المدرب
    _numofcourse = json['numofcourse']; // عدد الدورات
    _rating = json['rating']; // التقييم
  }

  int? get instructorID => _instructorID;
  String? get fullName => _fullName;
  String? get position => _position;
  String? get img => _img;
  String? get exp => _exp; // getter لتجربة المدرب
  int? get numofcourse => _numofcourse; // getter لعدد الدورات
  int? get rating => _rating; // getter للتقييم
}