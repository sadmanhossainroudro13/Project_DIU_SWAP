import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_diu_swap/screens/main_screen.dart';
import 'package:project_diu_swap/screens/profile_page/pages/contact_us.dart';
import 'package:project_diu_swap/screens/profile_page/pages/privacy_policy.dart';
import 'package:project_diu_swap/screens/profile_page/pages/terms_page.dart';
import 'package:project_diu_swap/screens/profile_page/widgets/tile.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //Signout Function
  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        title: Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("No user data"));
          }

          var userData = snapshot.data!;

          String name = userData['name'] ?? "User";
          String email = userData['email'] ?? "email@diu.edu.bd";

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),

              child: Column(
                children: [
                  //  PROFILE CARD
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          child: Icon(Icons.person, size: 30),
                        ),

                        SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(email, style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 15),

                  //  MAIN OPTIONS CARD
                  // Container(
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),

                  //   child: Column(
                  //     children: [
                  //       _tile(Icons.favorite_border, "Favorites", () {}),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: 15),

                  //  SUPPORT SECTION
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: Column(
                      children: [
                        CustomTile(
                          chooseIcon: Icons.contact_mail,
                          title: "Contact Us",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ContactUsScreen(),
                              ),
                            );
                          },
                        ),

                        CustomTile(
                          chooseIcon: Icons.privacy_tip,
                          title: "Privacy Policy",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PrivacyPolicyScreen(),
                              ),
                            );
                          },
                        ),

                        CustomTile(
                          chooseIcon: Icons.description,
                          title: "Terms & Conditions",
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => TermsScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  //  LOGOUT
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => signOut(context),
                      icon: Icon(Icons.logout),
                      label: Text("Logout"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
