import 'package:app/components/my_button.dart';
import 'package:app/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  final VoidCallback showLoginPage;

  const RegisterPage({
    Key? key,
    required this.showLoginPage, 
    this.onTap,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers 
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _firstNameController.dispose();
  }

  // sign user up method
  Future signUp() async {
    if ( passwordConfirmed() ) {
      //crea l'utente
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(), 
        password: _passwordController.text.trim(),
      );
      // aggiungi i dettagli dell'utente
      addUserDetails(
        _firstNameController.text.trim(),
        _emailController.text.trim(),
      );
    }
  }

  Future addUserDetails(String nome, String email) async {
    await FirebaseFirestore.instance.collection('users').add({
      'nome': nome,
      'email': email,
    });
  }

  bool passwordConfirmed() {
    if ( _passwordController.text.trim() == _confirmPasswordController.text.trim() ) {
      return true;
    } else {
      return false;
    }
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

                // mail
                MyTextField(
                  controller: _firstNameController,
                  hintText: 'Nome',
                  obscureText: false,
                ),
          
                const SizedBox(height: 10),
                    
                // mail
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

                // confirm password
                MyTextField(
                  controller: _confirmPasswordController,
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
                      onTap: widget.showLoginPage,
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