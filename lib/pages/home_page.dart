import 'package:app/components/button/home_button.dart';
import 'package:app/components/button/phone_button.dart';
import 'package:app/pages/chat_page.dart';
import 'package:app/pages/weight/weight_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      body: SafeArea(
        child: Column(
          children: [
            const Divider(),            
            
            const PhoneNumberButton(
              phoneNumber: '3348343186',
            ),

            HomeButton(
              sectionName: 'Peso',
              text: '5Kg', 
              icon: Icons.monitor_weight,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>   const MyWeight(currentWeight: '')),
                );
              }, 
            ),

            HomeButton(
              sectionName: 'Dieta',
              text: '...', 
              icon: Icons.food_bank,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
                );
              }, 
            ),

            HomeButton(
              sectionName: 'Appuntamenti',
              text: '...', 
              icon: Icons.calendar_month,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
                );
              }, 
            ),

            HomeButton(
              sectionName: 'Eventi',
              text: '...', 
              icon: Icons.event,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
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
      ),
    );
  }
}