import 'dart:core';

class Detail {
  final String img;
  final String title;
  final String description;

  // Constructor
  Detail({
    required this.img,
    required this.title,
    required this.description,
  });

  // Factory method to convert from JSON
  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      img: json['Img'],            // تأكد أن الاسم هنا يتوافق مع البيانات من الـ API
      title: json['Title'],        // تأكد أن الاسم هنا يتوافق مع البيانات من الـ API
      description: json['Description'],  // تأكد أن الاسم هنا يتوافق مع البيانات من الـ API
    );
  }
}