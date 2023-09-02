import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/widgets/error.dart';
import 'package:talkaro/common/widgets/loader.dart';
import 'package:talkaro/firebase_options.dart';
import 'package:talkaro/router.dart';
import 'package:talkaro/screens/home_page/home_page.dart';
import 'package:talkaro/screens/login_rejister/auth/controller/auth_controller.dart';
import 'package:talkaro/screens/splash_screen/splash_screen.dart';

import 'package:talkaro/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Talkaro',
        theme: ThemeData(
            primarySwatch: customColor,
            iconTheme: IconThemeData(color: Colors.black)),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: ref.watch(userDataAuthProvider).when(
              data: (user) {
                if (user == null) {
                  return SplashScreen();
                }
                return HomePage();
              },
              error: (err, trace) {
                return ErrorScreen(
                  error: err.toString(),
                );
              },
              loading: () => Loader(),
            ));
  }
}
