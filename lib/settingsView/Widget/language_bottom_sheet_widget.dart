import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/Provider/app_provider.dart';
import 'package:untitled/settingsView/Widget/selected_option_widget.dart';
import 'package:untitled/settingsView/Widget/unselected_option_widget.dart';

class LanguageBottomSheetWidget extends StatelessWidget {
  const LanguageBottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {

    var theme = Theme.of(context);
   var appProvider= Provider.of<AppProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 25,),

  decoration: BoxDecoration(
    
    color: Colors.green.withOpacity(0.9),
    borderRadius: BorderRadius.circular(20),

  ),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector( onTap: () {
            appProvider.changeLanguage("en");
            Navigator.pop(context);
          },



            child:
                appProvider.currentLocal == "en" ?
    SelectedOptionWidget(selectedTitle: "English") 
                    : UnselectedOptionWidget(unSelectedTitle: "English"),
          ),
         const SizedBox(
           height: 30,
         ),
         GestureDetector(
    onTap: () {
      appProvider.changeLanguage("ar");
      Navigator.pop(context);

    },
             child:
                 appProvider.currentLocal == "en" ?

         UnselectedOptionWidget(unSelectedTitle: "عربي") :
                 SelectedOptionWidget(selectedTitle: "عربي"),

         ),
        ],
      ),
  );

  }
}
