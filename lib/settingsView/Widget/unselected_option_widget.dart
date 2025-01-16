import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnselectedOptionWidget extends StatelessWidget {


  final String unSelectedTitle;

  const UnselectedOptionWidget({super.key, required this.unSelectedTitle, });

  @override
  Widget build(BuildContext context) {
    return



           Container(
             padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4),
             width: double.infinity,
             decoration:
             BoxDecoration(
               color: Colors.white10.withOpacity(0.05),
               borderRadius: BorderRadius.circular(8),
               border: Border.all(
                 color:Colors.black,
               ),
             ),

       child:
       Text(unSelectedTitle),
    );


  }
}
