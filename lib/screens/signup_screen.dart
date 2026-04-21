import 'package:flutter/material.dart';
import 'package:project_diu_swap/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_diu_swap/widgets/bold_text.dart';
import 'package:project_diu_swap/widgets/customButton.dart';
import 'package:project_diu_swap/widgets/password_input.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isLoading = false;
  bool isPasswordHidden = true;
  bool isConfirmHidden = true;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();

  //Signup Function
  Future<void> SignUp() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPass = _confirmPassController.text;

    //empty check
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPass.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Pleas fill all required fields")));
      return;
    }

    //email check
    if (!email.contains("@diu.edu.bd")) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Email must contain @diu.edu.bd')));
      return;
    }

    //password match
    if (password != confirmPass) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Password does not match")));
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });
      //firebase setup
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      //email verifiaction
      await userCredential.user!.sendEmailVerification();

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Verification email sent')));

      //login page
      Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      String message = "Signup failed";

      if (e.code == "email-already-in-use") {
        message = "Email already in use";
      } else if (e.code == 'weak-password') {
        message = "Password is weak";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Account"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),

      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldText(str: "Full name"),

                  CustomTexField(
                    controller: _nameController,
                    hint: "Full name",
                  ),

                  BoldText(str: "DIU Email Address"),

                  CustomTexField(
                    controller: _emailController,
                    hint: "@diu.edu.bd",
                  ),

                  BoldText(str: "Password"),

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

                  SizedBox(height: 10),

                  BoldText(str: "Confirm Password"),

                  PasswordInput(
                    str: "Confirm Password",
                    controller: _confirmPassController,
                    isHidden: isConfirmHidden,
                    onToggle: () {
                      setState(() {
                        isConfirmHidden = !isConfirmHidden;
                      });
                    },
                  ),

                  SizedBox(height: 10),

                  //Sign up button
                  Custombutton(
                    buttonText: "Sign Up",
                    buttonFunction: SignUp,
                    bgColor: Colors.green,
                    textColor: Colors.white,
                    height: 50,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        child: Text(
                          "Log in",
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
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }
}
