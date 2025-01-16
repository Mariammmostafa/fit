import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/Home/HomeView.dart';

class TopSportsDetails extends StatelessWidget {
  final CardItem items;
  const TopSportsDetails({super.key, required this.items,});
  static const String routeName = "TopSportsDetails";
  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar :
        AppBar(
        centerTitle: true,
        title: Text( items.title , style: const TextStyle(
        color: Colors.green,
          fontStyle: FontStyle.italic, fontFamily:
        "assets/Fonts/Poppins-Medium.ttf",
          fontWeight: FontWeight.bold

    ),),
    ),
    );
  }
}
