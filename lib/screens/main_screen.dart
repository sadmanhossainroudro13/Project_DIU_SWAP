import 'package:flutter/material.dart';
import 'package:project_diu_swap/screens/add_post/add_post.dart';
import 'package:project_diu_swap/screens/home/home_page.dart';
import 'package:project_diu_swap/screens/my_posts/my_post.dart';
import 'package:project_diu_swap/screens/profile_page/profile_screen.dart';
import 'package:project_diu_swap/widgets/custom_bottom_nav.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Homepage(),
    AddPost(),
    MyPost(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
