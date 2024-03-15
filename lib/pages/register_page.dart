import 'package:app/components/my_button.dart';
import 'package:app/components/my_textfield.dart';
import 'package:app/components/square_tile.dart';
import 'package:app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers 
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign user up method
  Future signUp() async {

    // show loading circle
    showDialog(
      context: context, 
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      )
    );

    if ( passwordController.text != confirmPasswordController.text ) {
      Navigator.pop(context);
      showErrorMessage('Le password non corrispondono');
      return;
    }

    // try creating the user
    try {

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, 
        password: passwordController.text,
      );

      // dopo aver creato l'utente, crea un documento in cloud firestore chiamato Users
      FirebaseFirestore.instance.
        collection("Users").
        doc(userCredential.user!.email) 
        .set({
          'username' : emailController.text.split('@')[0], // username iniziale
          'Nome' : 'Nome vuoto'
          // aggiungi altri campi se servono
        });

      // pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      
      // show error message
      showErrorMessage(e.code);
    }
  }

  // messaggio di errore
  void showErrorMessage(String message) {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ), 
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
          
                // logo
                const Icon(
                  Icons.lock,
                  size: 50,
                ),
                
                const SizedBox(height: 50),
                
                // Messaggio di benvenuto
                Text(
                  'Crea un account',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
          
                const SizedBox(height: 25),
          
                // username
                MyTextField(
                  controller: emailController,
                  hintText: 'Username',
                  obscureText: false,
                ),
          
                const SizedBox(height: 10),
          
                // password
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
          
                const SizedBox(height: 10),

                // confirm password
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Conferma la password',
                  obscureText: true,
                ),
          
                const SizedBox(height: 25),
          
                // sign in
                MyButton(
                  text: "Iscriviti",
                  onTap: signUp,
                ),
          
                const SizedBox(height: 50),
          
                // o continua con
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'O continua con',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
          
                const SizedBox(height: 50),
                
                // google + apple sign in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google
                    SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: '/Users/alfredocarta/Desktop/learn-flutter/flutter_application_1/lib/images/google.png',
                    ),
          
                    const SizedBox(width: 25),
          
                    //apple
                    SquareTile(
                      onTap: () {},
                      imagePath: '/Users/alfredocarta/Desktop/learn-flutter/flutter_application_1/lib/images/apple.png'
                    ),
                  ],
                ),
          
               const SizedBox(height: 50),
                
                // Non sei registrato? Registrati ora
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sei già registrato?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Accedi',
                        style: TextStyle(
                          color: Colors.blue, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}