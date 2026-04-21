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

    //empty check
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
      //Firebase login
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      //check email verification
      if (!userCredential.user!.emailVerified) {
        await FirebaseAuth.instance.signOut();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please verify your email first!")),
        );
        return;
      }
      // Navigator.pushReplacementNamed(context, "/home");
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
                      child: Image.asset('assets/images/logo.png', height: 200),
                    ),
                    SizedBox(height: 10),

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
                        onPressed: () {},
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

                    //*or
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Text("or", style: TextStyle(fontSize: 20)),
                    // ),

                    // SizedBox(height: 10),

                    //*Continue with google
                    // SizedBox(
                    //   height: 50,
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //     onPressed: () {},
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: Colors.black,
                    //       foregroundColor: Colors.white,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //     ),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Image.asset(
                    //           "assets/images/google_logo.png",
                    //           height: 20,
                    //         ),

                    //         SizedBox(width: 10),

                    //         Text(
                    //           "Continue with google",
                    //           style: TextStyle(fontSize: 20),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
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
