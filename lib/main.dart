import 'package:ddd/firebase_options.dart';
import 'package:ddd/screens/main_screen/main_screen.dart';
import 'package:ddd/screens/project_screen/project_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

/// Функция входа приложения.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const MainScreen(),
        '/project': (context) => const ProjectScreen(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
