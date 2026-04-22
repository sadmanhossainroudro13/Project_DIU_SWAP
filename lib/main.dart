import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_diu_swap/screens/login_screen/login_screen.dart';
import 'package:project_diu_swap/screens/home/home_page.dart';
import 'package:project_diu_swap/screens/main_screen.dart';
import 'package:project_diu_swap/screens/sign_up/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        ('/login'): (context) => LoginScreen(),
        ('/signup'): (context) => SignupScreen(),
        ('/home'): (context) => MainScreen(),
      },

      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return MainScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
