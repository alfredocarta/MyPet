import 'package:app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:app/pages/login/auth_page.dart'; 
import 'package:app/api/firebase_api.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'MyPet',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('hu_HU', null); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
      theme: ThemeData(primarySwatch: Colors.grey),
    );
  }
}
