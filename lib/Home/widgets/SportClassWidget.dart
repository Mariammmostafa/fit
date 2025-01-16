import 'package:flutter/material.dart';
import 'package:untitled/models/sport_class_model.dart';

class SportClassWidget extends StatelessWidget {
  final SportsClassModel data;

  const SportClassWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                data.poster!,
                fit: BoxFit.cover,
                height: size.height / 7,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(data.className!),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                const Text("Days: "),
                Expanded(
                  child: Text(
                    data.days!,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("${data.hours}Hours"),
                const SizedBox(width: 4),
                Icon(Icons.schedule, color: Colors.green.shade600),
                const Spacer(),
                Text("${data.price} Egp"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
