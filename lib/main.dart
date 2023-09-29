// ignore_for_file: use_build_context_synchronously
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talkaro/common/widgets/error.dart';
import 'package:talkaro/common/widgets/error_page.dart';
import 'package:talkaro/common/widgets/loader.dart';
import 'package:talkaro/firebase_options.dart';
import 'package:talkaro/router.dart';
import 'package:talkaro/features/home_page/home_page.dart';
import 'package:talkaro/features/authentication/controller/auth_controller.dart';
import 'package:talkaro/features/splash_screen/splash_screen.dart';
import 'package:talkaro/utils/colors.dart';

final ThemeData nightModeTheme = ThemeData(
  brightness: Brightness.dark,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  Future<void> checkAndNavigate(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      // Navigate to the error screen
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ErrorPage()),
      );
    } else {
      ref.watch(userDataAuthProvider).when(
            data: (user) {
              if (user == null) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SplashScreen()),
                );
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              }
            },
            error: (err, trace) {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ErrorScreen(error: err.toString())),
              );
            },
            loading: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const Loader()),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Talkaro',
      theme: ThemeData(
        primarySwatch: customColor,
      ),
      onGenerateRoute: ((settings) => generateRoute(settings)),
      home: Builder(
        builder: (context) {
          checkAndNavigate(context);
          return const Scaffold(
            body: Center(child: Loader()),
          );
        },
      ),
    );
  }
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(ProviderScope(child: const MyApp()));
// }

// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Talkaro',
//         theme: ThemeData(
//             primarySwatch: customColor,
//             iconTheme: IconThemeData(color: Colors.black)),
//         onGenerateRoute: (settings) => generateRoute(settings),
//         home: ref.watch(userDataAuthProvider).when(
//               data: (user) {
//                 if (user == null) {
//                   return SplashScreen();
//                 }
//                 return HomePage();
//               },
//               error: (err, trace) {
//                 return ErrorScreen(
//                   error: err.toString(),
//                 );
//               },
//               loading: () => Loader(),
//             ));
//   }
// }