class TrainersFinalDetails {
  String? fullName;
  String? position;
  String? poster;
  int? numOfCourse;
  String? exp;

  TrainersFinalDetails({
    this.fullName,
    this.position,
    this.poster,
    this.numOfCourse,
    this.exp,
  });

  // تحويل من JSON إلى كائن
  TrainersFinalDetails.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    position = json['posintion'];
    poster = json['poster'];
    numOfCourse = json['numofcourse'];
    exp = json['exp'];
  }

  // تحويل من كائن إلى JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['position'] = position;
    data['poster'] = poster;
    data['numofcourse'] = numOfCourse;
    data['exp'] = exp;

    return data;
  }
}
