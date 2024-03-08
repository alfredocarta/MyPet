import 'package:app/components/profile_button.dart';
import 'package:app/pages/profile/scheda_biografica.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 30), // Aggiunto padding superiore
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Posiziona i widget all'inizio della colonna
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
                ProfileButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SchedaBiografica(),
                      ),
                    );
                  },
                  icon: Icons.book,
                  text: "Scheda biografica",
                ),
                const SizedBox(height: 10),
                ProfileButton(
                  onTap: onTap,
                  icon: Icons.file_open,
                  text: "Libretto vaccinale",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

