import 'package:app/pages/profile/libretto_vaccinale/libretto_vaccinale.dart';
import 'package:app/pages/profile/trattamenti%20antiparassitari/tratt_ant.dart';
import 'package:flutter/material.dart';
import 'package:app/pages/profile/scheda_biografica/scheda_biografica_screen.dart'; // Importa la pagina CenterPage
import 'package:app/pages/profile/scheda_biografica/go_to_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 0), // Aggiunto padding superiore
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Divider(),
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Il mio profilo",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 0),
                GoToProfile(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SchedaBiograficaScreen()),
                    );
                  }, title: 'Scheda biografica',
                ),

                const SizedBox(height: 10),

                GoToProfile(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LibVacc()),
                    );
                  }, title: 'Libretto vaccinale',
                ),

                const SizedBox(height: 10),

                GoToProfile(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TrattAnt()),
                    );
                  }, title: 'T. antiparassitari',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
