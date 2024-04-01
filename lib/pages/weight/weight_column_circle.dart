import 'package:flutter/material.dart';

class WeightColumnCircle extends StatelessWidget {
  final String weight;
  final String label;

  const WeightColumnCircle({
    super.key,
    required this.weight,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.0,
      height: 110.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
      ),
    );
  }
}