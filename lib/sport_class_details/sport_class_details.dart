import 'package:flutter/material.dart';
import 'package:untitled/core/cart_manager.dart';
import 'package:untitled/models/sport_class_details_model.dart';
import 'package:untitled/network_layer/api_manager.dart';

class SportClassDetails extends StatefulWidget {
  final String classNumber;

  const SportClassDetails({super.key, required this.classNumber});

  @override
  State<SportClassDetails> createState() => _SportClassDetailsState();
}

class _SportClassDetailsState extends State<SportClassDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Class Details"),
      ),
      body: FutureBuilder(
        future: ApiManager.getSportClassDetails(widget.classNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          var data = snapshot.data as SportClassDetailsModel;
          return Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    data.poster!,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data.className.toString(),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "Days",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: data.days!,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "Level",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: data.levelNumber.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "Starts:  ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: data.startDate.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const TextSpan(
                        text: ": To ",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      TextSpan(
                        text: data.startTime.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: "Ends:  ",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: data.endDate.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      "${data.hours!} Hours",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.access_time_rounded,
                      color: Colors.green,
                    ),
                    const Spacer(),
                    Text(
                      "${data.price} SAR",
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data.instractorImg!),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data.instractorName.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          data.instractorPosition.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    _addToCart(data);
                  },
                  child: const Text(
                    "Add To Cart",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _addToCart(SportClassDetailsModel data) {
    var isAddedToCart = CartManager.addToCart(data);
    if (isAddedToCart) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Added to cart"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Already added to cart"),
        ),
      );
    }
  }
}
