import 'package:app/components/login_app_bar.dart';
import 'package:app/components/my_button.dart';
import 'package:app/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  final VoidCallback showLoginPage;

  const RegisterPage({
    super.key,
    required this.showLoginPage,
    this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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

  // sign user up method
  void signUp() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      displayMessage("Le password non corrispondono!");
      return;
    }

    try {

      UserCredential userCredential = 
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      FirebaseFirestore.instance
        .collection("Users")
        .doc(userCredential.user!.email)
        .set({
          'username' :  emailController.text.split('@')[0],
          'nome': "Come si chiama il tuo animale?",
          'dataDiNascita': "Quando è nato?",
          'mantello': "Che mantello ha?",
          'razza': "Che razza è?",
        });

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessage(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: const LoginAppBar(
        title: Text(
          'MyPet',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //const SizedBox(height: 25),

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

                /* Nome
                MyTextField(
                  controller: firstNameController,
                  hintText: 'Nome',
                  obscureText: false,
                ),

                const SizedBox(height: 10),*/

                // mail
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
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

                /* o continua con
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
                */
                
                //const SizedBox(height: 50),

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
