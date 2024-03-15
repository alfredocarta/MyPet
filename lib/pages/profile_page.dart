import 'package:flutter/material.dart';
import 'package:app/pages/profile/profile_screen.dart'; // Importa la pagina CenterPage
import 'package:app/pages/profile/go_to_scheda_biografica.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30), // Aggiunto padding superiore
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Dati personali",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                SchedaBiografica(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
