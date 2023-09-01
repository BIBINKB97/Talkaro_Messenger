import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/firebase_options.dart';
import 'package:talkaro/router.dart';
import 'package:talkaro/screens/splash_screen/splash_screen.dart';

import 'package:talkaro/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MyApp()));
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
      onGenerateRoute: (settings) => generateRoute(settings),
      home: SplashScreen(),
    );
  }
}
