import 'package:app/components/appbar/back_app_bar.dart';
import 'package:app/pages/weight/weight_column.dart';
import 'package:app/pages/weight/weight_column_circle.dart';
import 'package:flutter/material.dart';

class MyWeight extends StatelessWidget {
  final String weight;

  const MyWeight({
    super.key,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const BackAppBar(
        title: Row(
          children: [
            Text(
              'MyPet',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const Divider(),
          const SizedBox(height: 5),
          const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Weight Tracker",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[400]!),
              ),
              padding: const EdgeInsets.only(left: 25, bottom: 15, top: 15, right: 25),
              margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WeightColumn(
                    weight: '3',
                    label: 'Peso Iniziale',
                  ),
                  WeightColumnCircle(
                      weight: weight,
                      label: 'Peso Attuale',
                    ),
                  const WeightColumn(
                    weight: '6',
                    label: 'Peso Obiettivo',
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.grey[100],
            width: double.infinity,
            height: 550,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Column(
                    children: [
                      Text(
                        'Statistiche',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
