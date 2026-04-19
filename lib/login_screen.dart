import 'package:flutter/material.dart';
import 'package:project_diu_swap/screens/add_post/widgets/custom_textfield.dart';
import 'package:project_diu_swap/widgets/customButton.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('assets/images/logo.png', height: 200)),
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
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  hint: Text("Password"),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
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
                buttonFunction: () {},
                bgColor: Colors.green,
                textColor: Colors.white,
                height: 50,
              ),

              SizedBox(height: 10),

              //*or
              Align(
                alignment: Alignment.center,
                child: Text("or", style: TextStyle(fontSize: 20)),
              ),

              SizedBox(height: 10),

              //*Continue with google
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/google_logo.png", height: 20),

                      SizedBox(width: 10),

                      Text(
                        "Continue with google",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10),

              //Dont have an account Sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont have an account?", style: TextStyle(fontSize: 16)),
                  TextButton(
                    onPressed: () {},
                    child: Text(
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
    );
  }
}
