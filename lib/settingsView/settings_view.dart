import 'dart:core';
import 'dart:core';
import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/settingsView/Widget/language_bottom_sheet_widget.dart';
import 'package:untitled/settingsView/Widget/settings_item.dart';


import '../Provider/app_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SettingsView extends StatelessWidget {




  const SettingsView({super.key });
  static const String routeName = "SettingsView";

  get onOptionTaped => null;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery
        .of(context)
        .size;
    var appProvider= Provider.of<AppProvider>(context);
    var local = AppLocalizations.of(context)!;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(

          children: [

      SettingsItems(settingOptionTitle: "Language",
        onOptionTaped: (){
  showLanguageBottomSheet(context);
      }, selectedOption: appProvider.currentLocal == "en" ? "English" : "عربي",

      ),




  GestureDetector(
    onTap:() {
    showLanguageBottomSheet(context);
    },


    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 30,vertical: 17,),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      width: mediaQuery.width,
      decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8))
    ),
    ) ,
      ],
    ),
    );
    }

    void showLanguageBottomSheet(context) {
   showModalBottomSheet
    (context: context,
   builder: (context) => Container(),
    );
    }
  }
