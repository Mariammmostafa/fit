class SportClassDetailsModel {
  SportClassDetailsModel({
    required this.classNumber,
    required this.className,
    required this.levelNumber,
    required this.days,
    required this.poster,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.hours,
    required this.instructorId,
    required this.count,
    required this.startTime,
    required this.endTime,
    required this.instractorName,
    required this.instractorImg,
    required this.instractorPosition,
  });

  final num? classNumber;
  final String? className;
  final num? levelNumber;
  final String? days;
  final String? poster;
  final String? startDate;
  final String? endDate;
  final String? price;
  final num? hours;
  final String? instructorId;
  final num? count;
  final String? startTime;
  final String? endTime;
  final String? instractorName;
  final String? instractorImg;
  final String? instractorPosition;

  factory SportClassDetailsModel.fromJson(Map<String, dynamic> json) {
    return SportClassDetailsModel(
      classNumber: json["class_number"],
      className: json["class_name"],
      levelNumber: json["level_number"],
      days: json["days"],
      poster: json["poster"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      price: json["price"],
      hours: json["hours"],
      instructorId: json["instructor_id"],
      count: json["count"],
      startTime: json["start_time"],
      endTime: json["end_time"],
      instractorName: json["instractor_Name"],
      instractorImg: json["instractor_IMG"],
      instractorPosition: json["instractor_Position"],
    );
  }
}
