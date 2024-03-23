import 'package:app/components/appbar/back_app_bar.dart';
import 'package:app/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
        context: context, 
        builder: (context) {
          return const AlertDialog(
            content: Text('Link inviato! Controlla la tua mail'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context, 
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const BackAppBar(
        title: Row(
          children: [
            SizedBox(width: 0),
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
        children: [
          const Divider(),
          const SizedBox(height: 25),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Inserisci la tua email e riceverai un link per il reset della password',
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 10),
          
          MyTextField(
            controller: _emailController,
            hintText: 'Username',
            obscureText: false,
          ),

          const SizedBox(height: 10),
          
          MaterialButton(
            onPressed: passwordReset,
            color: Colors.grey[900],
            child: const Text(
              "Ripristina password", 
              style: TextStyle(
                color: Colors.white)
              ),
          )
        ],
      ),
    );
  }
}