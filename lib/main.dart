import 'package:ddd/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/navigation_routes.dart';

/// Функция входа приложения.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final mainNavigation = MainNavigation();
  runApp(
    MaterialApp(
      initialRoute: NavigationRoutes.mainScreen,
      routes: mainNavigation.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
