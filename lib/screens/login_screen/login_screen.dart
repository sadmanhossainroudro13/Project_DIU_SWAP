import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_diu_swap/widgets/custom_textfield.dart';
import 'package:project_diu_swap/widgets/customButton.dart';
import 'package:project_diu_swap/widgets/password_input.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool isPasswordHidden = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> LoginUser() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (!mounted) return;

      User user = userCredential.user!;

      await user.reload();
      user = FirebaseAuth.instance.currentUser!;

      if (!user.emailVerified) {
        await user.sendEmailVerification();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Please verify your email. Verification link sent again.",
            ),
          ),
        );

        await FirebaseAuth.instance.signOut();
        return;
      }

      Navigator.pushReplacementNamed(context, "/home");
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message = "Login Failed";

      if (e.code == 'user-not-found') {
        message = "No user found";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } finally {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> resetPassword() async {
    String email = _emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Enter your email first")));
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Password reset email sent")));
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message = "error occured";

      if (e.code == 'user-not-found') {
        message = "No user found with this email";
      } else if (e.code == 'invalid-email') {
        message = "Invalid email";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 100,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/just_logo.png',
                        height: 90,
                      ),
                    ),
                    SizedBox(height: 40),

                    //*Email input
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hint: Text("Enter DIU email"),
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    //*Password input
                    PasswordInput(
                      str: "Password",
                      controller: _passwordController,
                      isHidden: isPasswordHidden,
                      onToggle: () {
                        setState(() {
                          isPasswordHidden = !isPasswordHidden;
                        });
                      },
                    ),
                    //*Forget password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: resetPassword,
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ),

                    //*Login button
                    Custombutton(
                      buttonText: "Login",
                      buttonFunction: LoginUser,
                      bgColor: Colors.green,
                      textColor: Colors.white,
                      height: 50,
                    ),

                    SizedBox(height: 10),

                    SizedBox(height: 10),

                    //Dont have an account Sign up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont have an account?",
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            //Sign up button
                            "Sign Up",
                            style: TextStyle(color: Colors.green, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //loading overlay
            if (isLoading)
              Container(
                color: Colors.black87.withOpacity(0.3),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
