import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app/components/button/my_button.dart';
import 'package:app/components/my_textfield.dart';
import 'package:app/components/appbar/login_app_bar.dart';
import 'package:app/pages/login/forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  final VoidCallback showRegisterPage;
  
  const LoginPage({
    Key? key,
    required this.showRegisterPage, 
    this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // sign user in method
  void signIn() async {

    // caricamento
    showDialog(
      context: context, 
      builder: (context) => const Center(
        child: CircularProgressIndicator()
      ),
    );
  

    // prova a accedere
    try { 
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text, 
      password: _passwordController.text,
    );

    if (context.mounted) Navigator.pop(context);

    } on FirebaseAuthException catch(e) {
      Navigator.pop(context);
      displayMessage(e.code);
    }
  }

  // messaggio di errore
  void displayMessage(String message) {
    showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[700],
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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true, // Imposta reverse su true
          child: Column(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50), // Spazio sopra il logo

                    Center(
                      child: Container(
                        width: 200, // Larghezza del logo
                        height: 200, // Altezza del logo
                        child: Image.asset('assets/icons/logo_nuovo.png'), // Immagine del logo
                      ),
                    ),
                    const SizedBox(height: 25),
                    
                    // Messaggio di benvenuto
                    Text(
                      'Bentornato, ci sei mancato!',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
              
                    const SizedBox(height: 25),
              
                    // username
                    MyTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
              
                    const SizedBox(height: 10),
              
                    // password
                    MyTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
              
                    const SizedBox(height: 10),
                    
                    // password dimenticata
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (context){
                                    return const ForgotPasswordPage();
                                  },
                                ),
                              );
                            },
                            child: Text(
                              'Hai dimenticato la password?',
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ),
                        ],
                      ),
                    ),
              
                    const SizedBox(height: 35),
              
                    // sign in
                    MyButton(
                      text: "Accedi",
                      onTap: signIn,
                    ),
              
                    const SizedBox(height: 20),
                    
                    // Non sei registrato? Registrati ora
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Non sei registrato?',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: const Text(
                            'Registrati ora',
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
            ],
          ),
        ),
      ),
    );
  }
}
