import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 30),

          Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Text(
              'Profilo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),

          SizedBox(height: 30),
          
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Container(
              padding: EdgeInsets.all(12),
              color: Colors.grey[200],
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 30,
                        
                      ),
                      Text(
                        'Prova',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                    
                  ),
                ],
              ),
            ),
            
          ),
        ],
      ),
    );
  }
}