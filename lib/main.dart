import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_forward_session/utils/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  ).then(
    (value) => runApp(
      MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      themeMode: ThemeMode.dark,
      title: 'FFS',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      // initialRoute: '/login',
      initialRoute: _auth.currentUser == null ? '/login': '/user-screen',
    );
  }
}
