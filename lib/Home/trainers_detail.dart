
import 'package:flutter/material.dart';
import 'package:untitled/models/trainers_final_details.dart';
import 'package:untitled/models/trainers_model.dart';
import 'package:untitled/network_layer/api_manager.dart';

class TrainerFinalDetails extends StatefulWidget {
  final InstructorData trainer;

  const TrainerFinalDetails({super.key, required this.trainer});

  @override
  State<TrainerFinalDetails> createState() => _TrainerFinalDetailsState();
}

class _TrainerFinalDetailsState extends State<TrainerFinalDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Trainer Details'),
        ),
        body: Center(
          child: FutureBuilder(
            future: ApiManager.fetchTeamDetails(
                widget.trainer.instructorID!.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                var data = snapshot.data as TrainersFinalDetails;

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(data.poster!),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                data.fullName!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                data.position!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  
                                ),
                              ),
                            ],
                          ),
                        ),


                        const SizedBox(height: 16,),

                        Text(data.exp!, style: const TextStyle(fontSize: 18)),
                      ],
                    ),

                  ),
                );
              }
              return Container();
            },
          ),
        )

        //  Padding(

        //   padding: const EdgeInsets.all(16.0),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //       CircleAvatar(
        //         radius: 80,
        //         backgroundImage: NetworkImage(widget.trainer.img ?? ''),
        //       ),
        //       SizedBox(height: 20),
        //       Text(
        //         widget.trainer.fullName ?? 'لا يوجد اسم',
        //         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        //       ),
        //       SizedBox(height: 10),
        //       Text(
        //         widget.trainer.position ?? 'لا يوجد مسمى وظيفي',
        //         style: TextStyle(fontSize: 18, color: Colors.grey),
        //       ),
        //       SizedBox(height: 20),
        //       Text('التجربة: ${widget.trainer.exp ?? 'غير متوفرة'}'),
        //       Text('عدد الدورات: ${widget.trainer.numofcourse ?? 0}'),
        //       Text('التقييم: ${widget.trainer.rating ?? 0}'),
        //     ],
        //   ),
        // ),

        );
  }
}
