import 'package:flutter/material.dart';

class WeightEntry {
  final DateTime date;
  final double weight;

  WeightEntry({required this.date, required this.weight});
}

class WeightTrackerPage extends StatefulWidget {
  final double? weight;
  final DateTime? date;

  const WeightTrackerPage({
    super.key,
    required this.date,
    required this.weight,
  });

  @override
  _WeightTrackerPageState createState() => _WeightTrackerPageState();
}

class _WeightTrackerPageState extends State<WeightTrackerPage> {
  List<WeightEntry> weightEntries = [];

  void addWeight(double weight) {
    setState(() {
      weightEntries.add(WeightEntry(date: DateTime.now(), weight: weight));
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
        backgroundColor: Colors.grey[100],
        title: const Row(
          children: [
            SizedBox(width: 10),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Inserisci peso',
              border: OutlineInputBorder(),
            ),
            onSubmitted: (value) {
              double weight = double.tryParse(value) ?? 0.0;
              if (weight > 0) {
                addWeight(weight);
              }
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: weightEntries.length,
            itemBuilder: (context, index) {
              var entry = weightEntries[index];
              return ListTile(
                title: Text('${entry.date.toString()} - ${entry.weight.toString()}'),
              );
            },
          ),
        ),
      ],
    ),
  );
}

}
