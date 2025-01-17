import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:untitled/models/get_sports_request.dart';
import 'package:untitled/models/sliders_model.dart';
import 'package:untitled/models/sport_class_details_model.dart';
import 'package:untitled/models/sport_class_model.dart';
import 'package:untitled/models/trainers_final_details.dart';
import 'package:untitled/models/trainers_model.dart';
import 'package:untitled/sport_class_details/sport_class_details.dart';

class ApiManager {
  static Future<List<ToolData>> fetchSource(String urlImages) async {
    var dio = Dio();
    dio.interceptors.addAll([PrettyDioLogger()]);

    try {
      log("tesssssst");
      var res =
          await dio.get("http://api.fit-lyft.com/Usersasmx.asmx/GetSLider");
      log(res.data.toString());
      return SlidersModel.fromJson(res.data).toolData ?? [];
    } catch (e) {
      print(e);

      print("خطأ في الاتصال: $e");
      throw Exception('فشل في جلب البيانات: $e');
    }
  }

  static Future<List<InstructorData>> fetchTeam(String urlImages) async {
    var dio = Dio();
    dio.interceptors.addAll([PrettyDioLogger()]);

    try {
      log("tesssssst");
      var res =
          await dio.get("http://api.fit-lyft.com//Usersasmx.asmx/GetOurTeam");
      log(res.data.toString());
      return (res.data["ToolData"] as List).map(
        (e) {
          return InstructorData.fromJson(e);
        },
      ).toList();
    } catch (e) {
      print(e);

      print("خطأ في الاتصال: $e");
      throw Exception('فشل في جلب البيانات: $e');
    }
  }

  static fetchTeamDetails(String id) async {
    var dio = Dio();
    dio.interceptors.addAll([PrettyDioLogger()]);
    try {
      var response = await dio.get(
        "http://api.fit-lyft.com//Usersasmx.asmx/GetOurDetailsTeam",
        queryParameters: {
          "instractorID": id,
        },
      );

      var data = TrainersFinalDetails.fromJson(response.data);
      print(data.fullName);
      return data;
    } catch (_) {}
  }

  static getSportsClasses() async {
    var dio = Dio();
    dio.interceptors.addAll([PrettyDioLogger()]);
    try {
      var response = await dio.get(
        "http://api.fit-lyft.com//Usersasmx.asmx/GetSportsClasses",
      );
      var data = GetSportClassRequest.fromJson(response.data);
      return data;
    } catch (_) {}
  }

  static getSports() async {
    var dio = Dio();
    dio.interceptors.addAll([PrettyDioLogger()]);
    try {
      var response = await dio.get(
        "http://api.fit-lyft.com/Usersasmx.asmx/GetSports",
      );
      var data = GetSportsRequest.fromJson(response.data);
      return data;
    } catch (_) {}
  }

  static getClassesBySport(String sportNumber) async {
    var dio = Dio();
    dio.interceptors.addAll([PrettyDioLogger()]);
    try {
      var response = await dio.get(
        "http://api.fit-lyft.com/Usersasmx.asmx/GetClassesbySports",
        queryParameters: {
          "sport_number": sportNumber,
        },
      );
      var data = GetSportClassRequest.fromJson(response.data);
      return data;
    } catch (_) {}
  }

  static getSportClassDetails(String classNumber) async {
    var dio = Dio();
    dio.interceptors.addAll([PrettyDioLogger()]);
    try {
      var response = await dio.get(
        "http://api.fit-lyft.com/Usersasmx.asmx/GetSportsClassesdetails",
        queryParameters: {
          "class_number": classNumber,
        },
      );
      var data = SportClassDetailsModel.fromJson(response.data);
      return data;
    } catch (_) {}
  }
}
