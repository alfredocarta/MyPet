import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: SizedBox(
                height: 80,
                width: double.infinity, // Imposta la larghezza massima disponibile
                child: ElevatedButton(
                  onPressed: () {
                    // Aggiungi qui la logica per gestire il primo pulsante
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.description,
                        color: Color.fromARGB(255, 61, 61, 61),
                        size: 50,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Scheda biografica',
                        style: TextStyle(
                          color: Color.fromARGB(255, 61, 61, 61),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: SizedBox(
                height: 80,
                width: double.infinity, // Imposta la larghezza massima disponibile
                child: ElevatedButton(
                  onPressed: () {
                    // Aggiungi qui la logica per gestire il primo pulsante
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.medical_information,
                        color: Color.fromARGB(255, 61, 61, 61),
                        size: 50,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Libretto vaccinale',
                        style: TextStyle(
                          color: Color.fromARGB(255, 61, 61, 61),
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}