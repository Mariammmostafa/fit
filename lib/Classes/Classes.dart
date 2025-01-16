import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:untitled/Home/widgets/SportClassWidget.dart';
import 'package:untitled/models/sport_class_model.dart';

import '../network_layer/api_manager.dart';
import 'Classes.dart';

class Classes extends StatelessWidget {
  const Classes({super.key});
  static const String routeName = "Classes";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.classes),
      ),

      // body: Center(

      //   child: GridView.count(
      //     crossAxisCount: 2,
      //      mainAxisSpacing: 16.0,
      //     padding: EdgeInsets.all(8.0),
      //     crossAxisSpacing: 8.0,
      //     children: [
      //       Container(
      //         height: 100,
      //         width: 100,
      //         decoration: BoxDecoration(
      //           color: Colors.grey,
      //           borderRadius: BorderRadius.circular(16),
      //         ),
      //       ),
      //       Container(
      //         height: 100,
      //         width: 100,
      //         decoration: BoxDecoration(
      //           color: Colors.grey,
      //           borderRadius: BorderRadius.circular(16),
      //         ),
      //       ),
      //       Container(
      //         height: 100,
      //         width: 100,
      //         decoration: BoxDecoration(
      //           color: Colors.grey,
      //           borderRadius: BorderRadius.circular(16),
      //         ),
      //       ),
      //       Container(
      //         height: 100,
      //         width: 100,
      //         decoration: BoxDecoration(
      //           color: Colors.grey,
      //           borderRadius: BorderRadius.circular(16),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: Center(
        child: FutureBuilder(
          future: ApiManager.getSportsClasses(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasData) {
              var data = snapshot.data as GetSportClassRequest;
              return Center(
                child: GridView.builder(
                  itemCount: data.toolData!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                   childAspectRatio: 1/1.3,
                    mainAxisSpacing: 16.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Sportclasswidget(data: data.toolData![index]);
                  },
                ),
              );
            }
            return Text("Something went wrong");
          },
        ),
      ),
    );
  }
}
