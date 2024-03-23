import 'package:app/components/appbar/login_app_bar.dart';
import 'package:app/components/my_button.dart';
import 'package:app/components/my_textfield.dart';
import 'package:app/pages/login/forgot_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  final VoidCallback showRegisterPage;
  
  const LoginPage({
    super.key,
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
      backgroundColor: Colors.grey[100],
      appBar: const LoginAppBar(
        title: Row(
          children: [
            SizedBox(width: 10),
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
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Divider(),
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
                      hintText: 'Username',
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
              
                    const SizedBox(height: 25),
              
                    // sign in
                    MyButton(
                      text: "Accedi",
                      onTap: signIn,
                    ),
              
                    //const SizedBox(height: 50),
                    /*  
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
                          imagePath: '/Users/alfredocarta/Desktop/learn-flutter/flutter_application_1/lib/images/apple.png',
                        ),
                      ],
                    ),
              */
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
            ),
          ],
        ),
      ),
    );
  }
}