import 'package:flutter/material.dart';
import 'package:notes_app/Theme/color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Auth/auth_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: lightColor,
        appBarTheme:ThemeData().appBarTheme.copyWith(
          foregroundColor: lightColor.onPrimaryContainer,
          backgroundColor: lightColor.primaryContainer,
        ),
        cardTheme: ThemeData.light().cardTheme.copyWith(
          color: lightColor.primaryContainer,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: darkColor,
        appBarTheme:ThemeData().appBarTheme.copyWith(
          foregroundColor: lightColor.onPrimaryContainer,
          backgroundColor: lightColor.primaryContainer,
        ),
        cardTheme: ThemeData.dark().cardTheme.copyWith(
          color: darkColor.primaryContainer,
        ),
      ),
      home: AuthService().handleAuthState(),
    );
  }
}
