import 'package:cbo_report/features/user_auth/presentation/pages/detail_page.dart';
import 'package:cbo_report/features/user_auth/presentation/pages/sample.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cbo_report/features/app/splash-screen/splash_screen.dart';
import 'package:cbo_report/features/user_auth/presentation/pages/home_page.dart';
import 'package:cbo_report/features/user_auth/presentation/pages/login_page.dart';
import 'package:cbo_report/firebase_options.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'CBO Report',
      routes: {
        '/': (context) => const SplashScreen(
              child: LineChartSample2(),
            ),
        '/login': (context) => const LineChartSample2(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
