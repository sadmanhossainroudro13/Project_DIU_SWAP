import 'package:flutter/material.dart';

class CategoriesSort extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "All", "icon": Icons.all_inbox},
    {"name": "Electronics", "icon": Icons.devices},
    {"name": "Books", "icon": Icons.menu_book},
    {"name": "Furniture", "icon": Icons.chair},
    {"name": "Sports", "icon": Icons.sports_soccer},
    {"name": "Gaming", "icon": Icons.sports_esports},
    {"name": "Others", "icon": Icons.category},
  ];

  String selectedCategory;

  final Function(String) onTap;
  CategoriesSort({required this.onTap, required this.selectedCategory});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = categories[index]['name'] == selectedCategory;
          return GestureDetector(
            onTap: () {
              onTap(categories[index]['name']);
            },
            child: Container(
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Icon(
                      categories[index]['icon'],
                      size: 35,
                      color: isSelected
                          ? const Color.fromARGB(255, 61, 189, 65)
                          : Colors.grey[600],
                    ),
                  ),

                  Text(categories[index]['name']),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
