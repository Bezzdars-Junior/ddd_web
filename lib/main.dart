import 'package:ddd/firebase_options.dart';
import 'package:ddd/screens/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
      const MaterialApp(debugShowCheckedModeBanner: false, home: MainScreen()));
}
