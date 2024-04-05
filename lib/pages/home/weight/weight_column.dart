import 'package:flutter/material.dart';

class WeightColumn extends StatelessWidget {
  final String weight;
  final String label;

  const WeightColumn({
    super.key,
    required this.weight,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 33,),
        Text(
          '$weight Kg',
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 10.0, color: Colors.white,),
        ),
      ],
    );
  }
}