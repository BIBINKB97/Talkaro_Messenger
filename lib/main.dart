import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:talkaro/firebase_options.dart';
import 'package:talkaro/screens/splash_screen/splash_screen.dart';

import 'package:talkaro/utils/colors.dart';

void main() async {
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
      debugShowCheckedModeBanner: false,
      title: 'Talkaro',
      theme: ThemeData(
          primarySwatch: customColor,
          iconTheme: IconThemeData(color: Colors.black)),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
      },
    );
  }
}
