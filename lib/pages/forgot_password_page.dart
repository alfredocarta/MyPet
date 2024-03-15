import 'package:app/components/my_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
          return AlertDialog(
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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          "Romeo",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: (){},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

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
            child: const Text(
              "Ripristina password", 
              style: TextStyle(
                color: Colors.white)
              ),
            color: Colors.grey[900],
          )
        ],
      ),
    );
  }
}