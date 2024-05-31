import 'package:app/components/button/home_button.dart';
import 'package:app/components/button/phone_button.dart';
import 'package:app/pages/home/Eventi/booking_screen.dart';
import 'package:app/pages/home/chat_page.dart';
import 'package:app/pages/home/food/food.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection("Users"); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(),
        builder: (context,snapshot) {
          if ( snapshot.hasData ) {
            return SafeArea(
              child: Column(
                children: [
                  const Divider(),            
                  
                  const PhoneNumberButton(
                    phoneNumber: '3348343186',
                  ),

                  Row(
                    children: [
                    
                      Expanded(
                        child: HomeButton(
                          sectionName: 'Dieta',
                          text: '...', 
                          icon: Icons.food_bank,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MyFood()),
                            );
                          }, 
                        ),
                      ),
                    ],
                  ),

                  HomeButton(
                    sectionName: 'Eventi',
                    text: '...', 
                    icon: Icons.event,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const BookingCalendarDemoApp()),
                      );
                    }, 
                  ),

                  HomeButton(
                    sectionName: 'Ricetta',
                    text: '...', 
                    icon: Icons.medical_information,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ChatPage()),
                      );
                    }, 
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Errore ${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}