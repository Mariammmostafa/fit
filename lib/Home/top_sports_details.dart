import 'package:flutter/material.dart';
import 'package:untitled/Home/widgets/SportClassWidget.dart';
import 'package:untitled/models/get_sports_request.dart';
import 'package:untitled/models/sport_class_model.dart';

import '../network_layer/api_manager.dart';

class TopSportsDetails extends StatelessWidget {
  final SportModel item;

  const TopSportsDetails({
    super.key,
    required this.item,
  });

  static const String routeName = "TopSportsDetails";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          item.sportName ?? "",
          style: const TextStyle(
            color: Colors.green,
            fontStyle: FontStyle.italic,
            fontFamily: "assets/Fonts/Poppins-Medium.ttf",
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: ApiManager.getClassesBySport(item.sportNumber.toString()),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              var data = snapshot.data as GetSportClassRequest;
              if(data.toolData.isEmpty){
                return const Center(child:  Text("No classes found"));
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: data.toolData.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.5,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 8.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return SportClassWidget(data: data.toolData[index]);
                    },
                  ),
                ),
              );
            }
            return const Text("Something went wrong");
          },
        ),
      ),
    );
  }
}
