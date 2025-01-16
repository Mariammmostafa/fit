
import 'package:flutter/material.dart';

class SelectedOptionWidget extends StatelessWidget {


  final String selectedTitle;


  const SelectedOptionWidget({super.key, required this.selectedTitle});



  @override
  Widget build(BuildContext context) {
    return Container(

          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
          width: double.infinity,
    decoration:
     BoxDecoration(
       color: Colors.white24,
       borderRadius: BorderRadius.circular(8),
    border: Border.all(
    color:Colors.black,
    ),
     ),


       child:Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
       Text(selectedTitle),
      Icon(Icons.check_circle, color:Colors.black ),
      ],
    ),
    );

  }
}
